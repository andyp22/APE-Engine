/**
 * classes.project.events.GuiControlEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import flash.events.Event;
	
	public class GuiControlEvent extends Event  {
		//default GuiControlEvent
		public static const GUICONTROL_PRESSED:String = "GUICONTROL_PRESSED";
		//define other GuiControlEvents here (in alphabetical order)
		
		
		
		public function GuiControlEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new GuiControlEvent(type);
		}
	}
}