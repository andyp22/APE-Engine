/**
 * classes.project.core.GameController
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.Preloader;
	import classes.project.core.Server;
	import classes.project.core.ViewManager;
	import classes.project.core.ViewState;
	import classes.project.events.GameControlEvent;
	import classes.project.views.components.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class GameController  {
		private static var instance:GameController;
		private static var bInit:Boolean = true;
		private static var _bLoading:Boolean = false;
		private static var _introComplete:Boolean = false;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():GameController  {
			if(instance == null)  {
				instance = new GameController();			}
			return instance;
		}
		public function GameController():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("GameController initializing...");
				bInit = false;
				
			} else  {
				trace("GameController have already been initialized.");
			}
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
		/*
		 *  Events
		 *
		 *
		 */
		public static function onInitComplete():void  {
			showStartup();
		}
		public static function onLoadingComplete():void  {
			if(!_bLoading && _introComplete)  {
				trace("GameController onLoadingComplete()");
				[Inject] Server.dispatch(new GameControlEvent(GameControlEvent.GAME_MENU_BTN_PRESSED));
			}
		}
		public static function onLoadFinished():void  {
			//trace("GameController onLoadFinished()");
			_bLoading = false;
			onLoadingComplete();
		}
		public static function onIntroComplete():void  {
			//trace("GameController onIntroComplete()");
			_introComplete = true;
			onLoadingComplete();
		}
		/*
		 *  
		 *
		 *
		 */
		public static function displayView(sView:String):void  {
			[Inject] if(!ViewManager.hasView(sView))  {
				[Inject] ViewManager.addView(sView);
			}
			[Inject] ViewManager.showView(sView);
		}
		public static function showStartup():void  {
			var sView:String = "intro_view";
			[Inject] ViewManager.addView(sView);
			[Inject] IntroView(ViewManager.getView(sView)).startShow();
			queueAssets();
		}
		private static function queueAssets():void  {
			State.sCurrentViewState = ViewState.INIT_STATE;
			
			queueFile("swfs/views/menuScreens");
			//queueFile("swfs/views/menuScreens");
			
			
			[Inject] Preloader.runBackgroundQueue();
			_bLoading = true;
			
		}
		private static function queueFile(sFile:String):void  {
			[Inject] Server.queueSWF(sFile);
			var sURL:String = Server.getFileLink(sFile) + ".swf";
			[Inject] Preloader.addToQueue(sURL, null, "", true);
		}
		
		
	}
}