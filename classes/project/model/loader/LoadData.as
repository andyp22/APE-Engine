/**
 * classes.project.model.loader.LoadData
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.loader  {
	//import flash.display.DisplayObject;
	
	public class LoadData  {
		private var _sUrl:String;
		private var _oTarget:Object;
		private var _sId:String;
		private var _callback:Function;
		private var _scope:Object;
		private var _bytesTotal:Number;
		private var _bytesLoaded:Number;
		
		
		public function LoadData(sUrl:String, oLoc:Object, sId:String, fCallback:Function, oCallbackScope:Object)  {
			trace("Creating LoadData...");
			this._sUrl = sUrl;
			this._oTarget = oLoc;
			this._sId = sId;
			this._callback = fCallback;
			this._scope = oCallbackScope;
		}
		public function getUrl():String  {
			return this._sUrl;
		}
		public function getTarget():Object  {
			return this._oTarget;
		}
		public function getID():String  {
			return this._sId;
		}
		public function get location():Object {
			return this._scope;
		}
		public function doCallback():void {
			if((this._callback == null) || (this._scope == null)) {
				return;
			}
			trace("Running Callback " + _scope);
			this._callback.apply(this._scope.scope);
		}
		public function getType():String  {
			return this._sUrl.substr((this._sUrl.lastIndexOf(".")+1)).toLowerCase();
		}
		public function set bytesTotal(inTotal:Number):void {
			this._bytesTotal = inTotal;
		}
		public function get bytesTotal():Number {
			return this._bytesTotal;
		}
		
		public function set bytesLoaded(inLoaded:Number):void {
			this._bytesLoaded = inLoaded;
		}
		public function get bytesLoaded():Number {
			return this._bytesLoaded;
		}
		
		
		
	}
}