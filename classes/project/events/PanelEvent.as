/**
 * classes.project.events.PanelEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.model.IPanel;
	
	import flash.events.Event;
	
	public class PanelEvent extends Event  {
		
		public var panel:IPanel;
		
		public static const PANEL_OPENED:String = "PANEL_OPENED";
		public static const PANEL_CLOSED:String = "PANEL_CLOSED";
		
		public static const MINI_MAP_UPDATED:String = "MINI_MAP_UPDATED";
		
		
		public function PanelEvent(sType:String, panel:IPanel = null)  {
			super(sType);
			this.panel = panel;
		}
		
		override public function clone():Event  {
			return new PanelEvent(type, this.panel);
		}
	}
}