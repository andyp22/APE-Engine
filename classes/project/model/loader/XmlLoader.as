/**
 * classes.project.model.loader.XmlLoader
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.loader  {
	
	import classes.project.core.Server;
	import classes.project.events.LoaderEvent;
	import classes.project.model.loader.BaseLoader;
	import classes.project.model.loader.LoadData;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XmlLoader extends BaseLoader  {
		
		private var _lData:LoadData;
		private var _loader:URLLoader
		private var _xml:XML;
		
		public function XmlLoader()  {
			trace("Creating XmlLoader...");
			super();
			
		}
		
		override public function load(lData:LoadData):void {
			this._lData = lData;
			this._loader = new URLLoader(new URLRequest(this._lData.getUrl()));
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			this._loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			this._loader.addEventListener(Event.COMPLETE, onXmlFileLoaded);
		}
		
		private function onXmlFileLoaded(e:Event):void  {
			trace("XmlLoader: onXmlFileLoaded()");
			// add the xml data to the xmlData array
			var loader:URLLoader = e.target as URLLoader;
			this._xml = new XML(loader.data);
			var sElm:String = this._xml.name().localName;
			Server.xmlData[sElm] = this._xml;
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOADED, this._lData, this, Event.COMPLETE));
			Server.onFileLoaded("xml");
		}
		private function onLoadProgress(e:Event):void  {
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOAD_PROGRESS, this._lData, this, ProgressEvent.PROGRESS));
		}
		private function onLoadError(e:Event):void  {
			[Inject]  Server.dispatch(new LoaderEvent(LoaderEvent.ON_LOAD_ERROR, this._lData, this, ProgressEvent.PROGRESS));
		}
		
		override public function kill():void {
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			this._loader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			this._loader.removeEventListener(Event.COMPLETE, onXmlFileLoaded);
		}
		
		override public function getLoadData():LoadData  {
			return this._lData;
		}
		
		
		
	}
}