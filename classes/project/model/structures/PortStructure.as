/**
 * classes.project.model.structures.MainTownStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.structures {
	
	import classes.project.core.MapManager;
	import classes.project.core.Server;
	import classes.project.events.ConstructionPanelEvent;
	import classes.project.model.grid.HexGrid;
	import classes.project.model.grid.HexStructure;
	//import classes.project.model.grid.IGrid;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
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
			var nIndex:Number = tile.getID().indexOf("|");
			var nX:Number = Number(tile.getID().substr(0,nIndex));
			var nY:Number = Number(tile.getID().substr((nIndex+1)));
			var grid:HexGrid = HexGrid(MapManager.getGrid("game_map"));
			[Inject] var neighbors:Array =  grid.getMap().getNeighbours(new Point(nX, nY));
			var bNextToWater:Boolean = false;
			var bNextToLand:Boolean = false;
			for(var i:Number = 0; i < neighbors.length; i++)  {
				nX = neighbors[i].getPosition().x;
				nY = neighbors[i].getPosition().y;
				if(grid.getTileByAtLocation(nX, nY).isWater())  {
					bNextToWater = true;
				} else if(grid.getTileByAtLocation(nX, nY).getWalkable())  {
					bNextToLand = true;
				}
			}
			//must be next to land and water or port is useless
			if(tile.getWalkable() && !tile.isWater() && !tile.hasBuilding() && bNextToWater && bNextToLand)  {
				return true;
			}
			return false;
		}
		
	}
}