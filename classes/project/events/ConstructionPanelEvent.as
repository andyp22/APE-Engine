/**
 * classes.project.events.ConstructionPanelEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import classes.project.model.grid.HexStructure;
	
	import flash.events.MouseEvent;
	
	public class ConstructionPanelEvent extends MouseEvent  {
		
		public var building:HexStructure;
		
		public static const SELECT_BUILDING_FOR_CONSTRUCTION:String = "SELECT_BUILDING_FOR_CONSTRUCTION";
		
		
		public function ConstructionPanelEvent(sType:String, building:HexStructure = null)  {
			super(sType);
			this.building = building;
		}
		
	}
}