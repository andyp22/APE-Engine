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
		public static const CONSTRUCTION_BTN_PRESSED:String = "CONSTRUCTION_BTN_PRESSED";
		public static const CREATE_PLAYER_BTN_PRESSED:String = "CREATE_PLAYER_BTN_PRESSED";
		public static const DELETE_PLAYER_BTN_PRESSED:String = "DELETE_PLAYER_BTN_PRESSED";
		public static const LOAD_PLAYER_BTN_PRESSED:String = "LOAD_PLAYER_BTN_PRESSED";
		
		
		public function GuiControlEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new GuiControlEvent(type);
		}
	}
}