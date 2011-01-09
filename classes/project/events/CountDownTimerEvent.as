/**
 * classes.project.events.CountDownTimerEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import flash.events.Event;
	
	public class CountDownTimerEvent extends Event  {
		
		public static const COUNTDOWN_TIMER_COMPLETE:String = "COUNTDOWN_TIMER_COMPLETE";
		public static const UNDO_COUNTDOWN_TIMER_COMPLETE:String = "UNDO_COUNTDOWN_TIMER_COMPLETE";
		
		
		
		public function CountDownTimerEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new CountDownTimerEvent(type);
		}
	}
}