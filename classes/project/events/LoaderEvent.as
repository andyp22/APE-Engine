/**
 * classes.project.events.LoaderEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	import classes.project.model.loader.*;
	
	import flash.events.Event;
	
	public class LoaderEvent extends Event  {
		
		public static var ON_LOAD_PROGRESS:String= "ON_LOAD_PROGRESS";
		public static var ON_LOAD_ERROR:String = "ON_LOAD_ERROR";
		public static var ON_LOADED:String = "ON_LOADED";
		
		public var _type:String; 
		public var data:LoadData;
		public var loader:ILoader;
		public var isBackground:Boolean
		public var status:String;
		
		public function LoaderEvent(sType:String, lData:LoadData, oLoader:ILoader, sStatus:String) {
			//trace("Creating LoaderEvent -- "+sType);
			super(sType);
			this._type = sType;
			this.data = lData;
			this.loader = oLoader;
			this.status = sStatus;
		}
		
		override public function clone():Event  {
			return new LoaderEvent(this._type, this.data, this.loader, this.status);
		}
	}
}