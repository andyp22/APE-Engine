/**
 * classes.project.core.Preloader
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	import classes.project.model.loader.*;
	import classes.project.events.PreloaderEvent;
	import classes.project.events.LoaderEvent;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class Preloader  {
		private static const PRIMARY_LOAD:uint = 1;
		private static const BACKGROUND_LOAD:uint = 2;
		private static const LOAD_PAUSED:uint = 3;
		private static const INACTIVE:uint = 4;
		private static const MAX_LOADERS:uint = 3;
		
		private static var instance:Preloader;
		private static var bInit:Boolean = true;
		
		private static var _primaryQueue:Array;
		private static var _backgroundQueue:Array;
		private static var _currentQueue:Array;
		private static var _loaders:Array;
		
		private static var _primaryTotal:uint;
		private static var _loadingState:uint;
		
		private static var _bQueueRunning:Boolean;
		private static var _bBackgroundPaused:Boolean;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Preloader  {
			if(instance == null)  {
				instance = new Preloader();			}
			return instance;
		}
		public function Preloader():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				bInit = false;
				trace("Preloader initializing...");
				_primaryQueue = new Array();
				_backgroundQueue = new Array();
				_currentQueue = new Array();
				_loaders = new Array();
				_primaryTotal = 0;
				_bQueueRunning = false;
				_bBackgroundPaused = false;
				
				initEvents();
			} else  {
				trace("Preloader has already been initialized.");
			}
		}
		private static function initEvents():void  {
			eventMap.mapListener(_eventDispatcher, LoaderEvent.ON_LOADED, onFileLoaded);
			eventMap.mapListener(_eventDispatcher, LoaderEvent.ON_LOAD_ERROR, onLoadError);
			eventMap.mapListener(_eventDispatcher, LoaderEvent.ON_LOAD_PROGRESS, onLoadProgress);
			
		}
		/*
		 *  event dispatcher
		 *
		 *
		 */
		public static function setEventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}
		public static function get eventMap():IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(_eventDispatcher));
		}
		/*
		 * Dispatch helper method
		 *
		 * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
		 */
		public static function dispatch(event:Event):Boolean
		{
 		    if(_eventDispatcher.hasEventListener(event.type))
 		        return _eventDispatcher.dispatchEvent(event);
 		 	return false;
		}
		/**
		 *	Primary Methods
		 */
		public static function addToQueue(sUrl:String, oLoc:Object = null, sId:String = "", bBackground:Boolean = false, fCallback:Function = null, oCallbackScope:Object = null):void {
			trace("Preloader -- addToQueue() -- "+ sUrl);
			var ld:LoadData = new LoadData(sUrl, oLoc, sId, fCallback, oCallbackScope);
			
			if(bBackground) {
				_backgroundQueue.push(ld);
			}else{
				// pull it out of the background array if we are adding it to the active queue
				removeElement(_backgroundQueue, ld);
				_primaryQueue.push(ld);
			}
		}
		public static function runQueue():void {
			trace("Preloader -- runQueue()");
			if(_primaryQueue.length == 0) {
				handleAllLoaded();
				return;
			}
			_primaryTotal = _primaryQueue.length;
			// if we are currently running the background load then pause it
			if(_loadingState == BACKGROUND_LOAD) {
				pauseBackgroundLoad();
			}
			
			_loadingState = PRIMARY_LOAD;
			[Inject]  Server.dispatch(new PreloaderEvent(PreloaderEvent.ON_FILE_LOAD_START));
			// go ahead and start as meay concurrent loads as we can
			_bQueueRunning = true;
			for(var i:Number = 0; i < MAX_LOADERS; i++) {
				startNextInQueue();
			}
		}
		private static function startNextInQueue():void {
			//trace("Preloader -- startNextInQueue()");
			if(_loadingState == BACKGROUND_LOAD)  {
				_currentQueue = _backgroundQueue;
			} else if(_loadingState == PRIMARY_LOAD)  {
				_currentQueue = _primaryQueue;
			}
			
			if(_currentQueue.length == 0) { return; }
			
			// get a data object, create a loader and start load
			var lData:LoadData = LoadData(_currentQueue.shift());
			var loader = getLoader(lData.getType());
			loader.setEventDispatcher(_eventDispatcher);
			addLoader(loader);
			loader.load(lData);	
		}
		/**
		 *	Background Queue Methods
		 */
		public static function runBackgroundQueue():void {
			//trace("Preloader -- runBackgroundQueue()");
			if(_backgroundQueue.length == 0) {
				// need to frame delay and send all done so if nothings 
				// been added to the queue then we still send the all clear
				_loadingState = INACTIVE;
				handleAllLoaded();
				return;
			}
			_loadingState = BACKGROUND_LOAD;
			startNextInQueue();
		}
		private static function pauseBackgroundLoad():void {
			//trace("Preloader -- pauseBackgroundLoad()");
			if(_loadingState != BACKGROUND_LOAD) { return; }
			_bBackgroundPaused = true;
		}
		private static function resumeBackgroundLoad():void {
			//trace("Preloader -- resumeBackgroundLoad()");
			_bBackgroundPaused = false;
			if(_backgroundQueue.length == 0) { return; }
			runBackgroundQueue();
		}
		/**
		 *	Clearing Methods
		 */
		public static function stopLoadAndClear():void {
			//trace("Preloader -- stopLoadAndClear()");
			if(!_bBackgroundPaused)  {
				pauseBackgroundLoad();
			}
			if(_loadingState == PRIMARY_LOAD) {
				trace("\n\tTODO: Finish the Preloader stopLoadAndClear()!!\n");
				for(var i:Number; i < _loaders.length; i++) {
					//_loaders[i].stopLoad();
					//_backgroundQueue.push(_loaders[i].getLoadData());
					//_loaders[i].removeEventListener(LoaderEvent.ON_LOADED, this);
					//_loaders[i].removeEventListener(LoaderEvent.ON_LOAD_ERROR, this);
					//delete _loaders[i];
				}
				_loaders = new Array();
			}
		}
		public static function clearBackgroundLoad():void  {
			//trace("Preloader -- clearBackgroundLoad()");
			if(_backgroundQueue.length == 0) { return; }
			_backgroundQueue = new Array();
		}
		/**
		 *	Loader Methods
		 */
		private static function getLoader(sFileType:String):ILoader {
			//trace("Preloader -- getLoader()");
			switch(sFileType) {
				case "jpg":
				case "jpeg":
				case "png":
				case "gif":
				case "swf":
					return new SwfLoader();
					break;
				case "txt":
				case "xml":
					return new XmlLoader();
					break;
				case "mp3":
					trace("\n\tTODO: Finish the Preloader SoundLoader()!!\n");
					//return new SoundLoader();
					break;
				default:
					trace("\n\tUnknown file type: "+sFileType);
			}
			return null;
		}
		private static function addLoader(loader:ILoader):void {
			//trace("Preloader -- addLoader()");
			if(_loadingState == PRIMARY_LOAD) {
				//loader.addEventListener(LoaderEvent.ON_LOAD_PROGRESS, onLoadProgress);
			}
			_loaders.push(loader);
		}
		private static function removeLoader(loader:ILoader):void {
			//trace("Preloader -- removeLoader()");
			loader.kill();
			if(_loadingState == PRIMARY_LOAD) {
				//loader.removeEventListener(LoaderEvent.ON_LOAD_PROGRESS, onLoadProgress);
			}
			removeElement(_loaders, loader);
		}
		/**
		 * 	Load Event Methods
		 */
		public static function onFileLoaded(e:LoaderEvent):void {
			trace("Preloader -- onFileLoaded()");
			removeLoader(e.loader);
			[Inject]  Server.dispatch(new PreloaderEvent(PreloaderEvent.ON_FILE_LOADED, e.data));
			// if we are all done loading do some clean up
			//do call back if there is one
			e.data.doCallback();
			
			if((_currentQueue.length == 0) && (_loaders.length == 0)) {
				handleAllLoaded();
			}else{
				startNextInQueue();
			}
		}
		private static function handleAllLoaded():void {
			trace("Preloader -- handleAllLoaded()");
			if(_loadingState == PRIMARY_LOAD) {
				_loadingState = INACTIVE;
				// restart the background load if there is one
				if(_bBackgroundPaused) {
					resumeBackgroundLoad();
				}
				// send all loaded event
				[Inject]  Server.dispatch(new PreloaderEvent(PreloaderEvent.ON_FILE_ALL_LOADED, null, 100));
			}else{
				_primaryTotal = 0;
				_loadingState = INACTIVE;
			}
		}
		public static function onLoadError(e:LoaderEvent):void {
			trace("Preloader -- onLoadError()");
			removeLoader(e.loader);
			[Inject]  Server.dispatch(new PreloaderEvent(PreloaderEvent.ON_FILE_LOADED, e.data));
			// if we are all done loading do some clean up
			if((_currentQueue.length == 0) && (_loaders.length == 0)) {
				handleAllLoaded();
			}else{
				startNextInQueue();
			}
		}
		public static function onLoadProgress(e:LoaderEvent):void {
			//trace("Preloader -- onLoadProgress() -- "+ getLoadProgress());
			var nProgress = getLoadProgress();
			[Inject]  Server.dispatch(new PreloaderEvent(PreloaderEvent.ON_FILE_LOAD_PROGRESS, e.data, nProgress));
		}
		private static function getLoadProgress():Number {
			//trace("Preloader -- getLoadProgress()");
			var nPart:Number = 100/_primaryTotal;
			var nProgress:Number = (_primaryTotal - (_loaders.length + _currentQueue.length)) * nPart;
			for(var i:Number = 0; i < _loaders.length; i++) {
				var lData = _loaders[i].getLoadData();
				var nLoaderProgress = nPart  * (lData.bytesLoaded / lData.bytesTotal );
				if(!isNaN(nLoaderProgress)) {
					nProgress += nLoaderProgress;
				}
			}
			if(nProgress < 0)  {
				nProgress = 0;
			}
			return nProgress;
		}
		
		/*
		 *	Searches array for an element with a specific value.
		 *	@param inList: array to perform search on.
		 *	@param inValue: (generically typed) value to search for in List elements.
		 *	@return Boolean indicating successful removal.
		 */
		private static function removeElement(inList:Array, inValue:Object):Boolean  {
			//trace("Preloader -- removeElement()");
			for (var i:Number=0; i < inList.length; ++i) {
				if (inList[i] == inValue) {
					inList.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		public static function toString():String {
			return "classes.project.core.Preloader";
		}
	}
}