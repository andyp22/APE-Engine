/**
 * classes.project.events.PopupEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	
	import flash.events.Event;
	
	public class PopupEvent extends Event  {
		public static const POPUP_OPEN:String = "POPUP_OPEN";
		public static const POPUP_CLOSED:String = "POPUP_CLOSED";
		
		public static const TWO_BUTTON_POPUP_CONFIRMED:String = "TWO_BUTTON_POPUP_CONFIRMED";
		
		
		
		public function PopupEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new PopupEvent(type);
		}
	}
}