/**
 * classes.project.events.UnitFocusEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.model.grid.HexUnit;
	
	import flash.events.Event;
	
	public class UnitFocusEvent extends Event  {
		
		public var unit:HexUnit;
		
		public static const CENTER_FOCUSED_UNIT:String = "CENTER_FOCUSED_UNIT";
		public static const DESTROY_UNIT_FOCUS:String = "DESTROY_UNIT_FOCUS";
		public static const NEW_UNIT_FOCUS:String = "NEW_UNIT_FOCUS";
		public static const UNIT_POSITION_UPDATED:String = "UNIT_POSITION_UPDATED";
		
		
		public function UnitFocusEvent(sType:String, unit:HexUnit = null)  {
			super(sType);
			this.unit = unit;
		}
		
		override public function clone():Event  {
			return new UnitFocusEvent(type, this.unit);
		}
	}
}