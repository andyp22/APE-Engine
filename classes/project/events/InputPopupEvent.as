/**
 * classes.project.events.InputPopupEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.events.PopupEvent;
	
	import flash.events.Event;
	
	public class InputPopupEvent extends PopupEvent  {
		
		public var inputText:String;
		
		public static const INPUT_POPUP_CLOSED:String = "INPUT_POPUP_CLOSED";
		
		
		
		public function InputPopupEvent(sType:String, sInput:String = "")  {
			super(sType);
			this.inputText = sInput;
		}
		
		override public function clone():Event  {
			return new InputPopupEvent(type, this.inputText);
		}
	}
}