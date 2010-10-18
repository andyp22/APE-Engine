/**
 * classes.project.interactivities.events.InteractivityEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.events  {
	
	import flash.events.Event;
	
	public class InteractivityEvent extends Event  {
		public static const ACTIVITY_CREATED:String = "ACTIVITY_CREATED";
		public static const ACTIVITY_STARTED:String = "ACTIVITY_STARTED";
		
		public static const SUBMIT_PRESSED:String = "SUBMIT_PRESSED";
		
		public static const ACTIVITY_COMPLETED:String = "ACTIVITY_COMPLETED";
		public static const ACTIVITY_DESTROYED:String = "ACTIVITY_DESTROYED";
		
		
		
		public function InteractivityEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new InteractivityEvent(type);
		}
	}
}