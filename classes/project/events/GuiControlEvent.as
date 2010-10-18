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
		public static const CALCULATOR_BTN_PRESSED:String = "CALCULATOR_BTN_PRESSED";
		public static const CLIP_PANEL_BTN_PRESSED:String = "CLIP_PANEL_BTN_PRESSED";
		public static const HEXMAP_BTN_PRESSED:String = "HEXMAP_BTN_PRESSED";
		public static const MENU_BTN_PRESSED:String = "MENU_BTN_PRESSED";
		public static const SAVE_CONTROL_PRESSED:String = "SAVE_CONTROL_PRESSED";
		public static const SORTING_BTN_PRESSED:String = "SORTING_BTN_PRESSED";
		public static const TIMER_BTN_PRESSED:String = "TIMER_BTN_PRESSED";
		
		public static const CLIP_NEXT_BTN_PRESSED:String = "CLIP_NEXT_BTN_PRESSED";
		public static const CLIP_BACK_BTN_PRESSED:String = "CLIP_BACK_BTN_PRESSED";
		
		
		public function GuiControlEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new GuiControlEvent(type);
		}
	}
}