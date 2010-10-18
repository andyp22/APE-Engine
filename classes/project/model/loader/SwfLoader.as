/**
 * classes.project.model.loader.SwfLoader
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.loader  {
	
	import classes.project.core.Navigator;
	import classes.project.core.Server;
	import classes.project.core.ViewManager;
	import classes.project.events.LoaderEvent;
	import classes.project.model.loader.BaseLoader;
	import classes.project.model.loader.LoadData;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class SwfLoader extends BaseLoader  {
		
		private var _lData:LoadData;
		private var _loader:Loader;
		private var _asset:Sprite;
		private var _sUrl:String;
		
		public function SwfLoader()  {
			trace("Creating SwfLoader...");
			super();
			
		}
		
		override public function load(lData:LoadData):void {
			this._lData = lData;
			this._sUrl = this._lData.getUrl();
			this._loader = new Loader();
			this.configureListeners(this._loader.contentLoaderInfo);
			
			var _request:URLRequest = new URLRequest(this._sUrl);
			this._loader.load(_request, new LoaderContext(false, ApplicationDomain.currentDomain));
			
			
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, onSwfFileLoaded);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
		}
		private function onSwfFileLoaded(e:Event):void  {
			trace("SwfLoader: onSwfFileLoaded()");
			var _loaderInfo:LoaderInfo = e.target as LoaderInfo;
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOADED, this._lData, this, Event.COMPLETE));
			//determine what type of swf file and handle
			var sType:String = getSwfType(this._sUrl);
			var sName:String;
			
			switch(sType)  {
				case "audio":
					trace("\n\tTODO: Finish the SwfLoader audio handler!!\n");
					sName = getFileName(this._sUrl);
					//TODO: store the audio for use
					[Inject] Server.onFileLoaded(sName);
					break;
				case "clips":
					sName = getFileName(this._sUrl, true);
					var clip:MovieClip = e.target.content;
					[Inject] Server.storeAssets(clip, Server.getClipLink(this._sUrl));
					[Inject] Server.onFileLoaded(sName);
					[Inject] Navigator.onClipLoaded();
					break;
				case "assets":
					sName = getFileName(this._sUrl);
					[Inject] Server.storeAssets(this._loader, Server.getClipLink(this._sUrl));
					[Inject] Server.onFileLoaded(sName);
					break;
				case "views":
					sName = getFileName(this._sUrl);
					var view:MovieClip = e.target.content;
					[Inject] Server.storeAssets(view, Server.getClipLink(this._sUrl));
					[Inject] Server.onFileLoaded(sName);
					[Inject] ViewManager.onFileLoaded(sName);
					break;
				
				
			}
			
		}
		private function getFileName(sUrl:String, removeSuffixOnly:Boolean = false):String  {
			var nIndex:Number = sUrl.lastIndexOf("/");
			var sName:String = "";
			if(nIndex < 0 || removeSuffixOnly)  {
				nIndex = sUrl.indexOf(".");
				sName = sUrl.substr(0, nIndex);
			} else  {
				var sTemp:String = sUrl.substr((nIndex + 1));
				nIndex = sTemp.indexOf(".");
				sName = sTemp.substr(0, nIndex);
			}
			return sName;
		}
		
		private function getSwfType(sUrl:String):String  {
			var clipIndex:Number = sUrl.indexOf("clips");
			var audioIndex:Number = sUrl.indexOf("audio");
			var viewIndex:Number = sUrl.indexOf("views");
			
			if(clipIndex >= 0)  {
				return "clips";
			}
			if(audioIndex >= 0)  {
				return "audio";
			}
			if(viewIndex >= 0)  {
				return "views";
			}
			
			return "assets";
		}
		private function onLoadProgress(e:Event):void  {
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOAD_PROGRESS, this._lData, this, ProgressEvent.PROGRESS));
		}
		private function onLoadError(e:Event):void  {
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOAD_ERROR, this._lData, this, ProgressEvent.PROGRESS));
		}
		
		override public function kill():void {
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onSwfFileLoaded);
		}
		
		override public function getLoadData():LoadData  {
			return this._lData;
		}
		
		
		
	}
}