/**
 * classes.project.events.TabControlEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.model.controls.TabControl;
	
	import flash.events.Event;
	
	public class TabControlEvent extends Event  {
		
		public var _tab:TabControl;
		
		public static const TAB_CONTROL_PRESSED:String = "TAB_CONTROL_PRESSED";
		
		
		
		public function TabControlEvent(sType:String, tab:TabControl = null)  {
			super(sType);
			this._tab = tab;
		}
		
		override public function clone():Event  {
			return new TabControlEvent(type, this._tab);
		}
	}
}