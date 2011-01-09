/**
 * classes.project.model.structures.MainTownStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.structures {
	
	import classes.project.core.Server;
	import classes.project.events.ConstructionPanelEvent;
	import classes.project.model.grid.HexStructure;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	
	public class PortStructure extends HexStructure {
		
		/**
		 * Constructor
		 */
		public function PortStructure(id:Number, sName:String, sMCid:String)  {
			trace("Creating a new PortStructure...");
			super(id, sName, sMCid);
			
			this.init();
		}
		
		private function init():void  {
			//[Inject] Server.dispatch(new ConstructionPanelEvent(ConstructionPanelEvent.MAIN_TOWN_CONSTRUCTED, this));
			
		}
		override public function targetTileValid(tile:ITile):Boolean  {
			//get the tile's neighbors
			
			
			
			if(tile.getWalkable() && !tile.isWater() && !tile.hasBuilding())  {
				return true;
			}
			return false;
		}
		
	}
}