/**
 * classes.project.events.PreloaderEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	import classes.project.model.loader.LoadData;
	
	import flash.events.Event;
	
	public class PreloaderEvent extends Event  {
		public static const ON_FILE_LOAD_START:String = "ON_FILE_LOAD_START";
		public static const ON_FILE_LOAD_PROGRESS:String= "ON_FILE_LOAD_PROGRESS";
		public static const ON_FILE_LOADED:String = "ON_FILE_LOADED";
		public static const ON_FILE_LOAD_ERROR:String = "ON_FILE_LOAD_ERROR";
		public static const ON_FILE_ALL_LOADED:String = "ON_FILE_ALL_LOADED";
		
		private var _progress:Number;
		
		public var _type:String;
		public var data:LoadData;
		public var progress:Number;
		
		public function PreloaderEvent(sType:String, lData:LoadData = null, nProgress:Number = 0)  {
			//trace("Creating PreloaderEvent -- "+sType);
			super(sType);
			
			this._type = sType;
			this.data = lData;
			this.progress = nProgress;
			
			if(this.progress < 0)  {
				this.progress = 0;
			}
		}
		
		override public function clone():Event  {
			return new PreloaderEvent(this._type, this.data, this.progress);
		}
	}
}