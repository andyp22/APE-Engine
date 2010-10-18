/**
 * classes.project.interactivities.events.DragAndDropEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.events  {
	
	import classes.project.interactivities.models.components.IDragger;
	
	import flash.events.Event;
	
	public class DragAndDropEvent extends Event  {
		public static const START_DRAG:String = "START_DRAG";
		public static const STOP_DRAG:String = "STOP_DRAG";
		
		public var dragger:IDragger;
		
		
		public function DragAndDropEvent(sType:String, dragger:IDragger = null)  {
			super(sType);
			this.dragger = dragger;
		}
		
		override public function clone():Event  {
			return new DragAndDropEvent(type, this.dragger);
		}
	}
}