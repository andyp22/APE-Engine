/**
 * classes.project.model.structures.QuarryStructure
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
	
	public class QuarryStructure extends HexStructure {
		
		/**
		 * Constructor
		 */
		public function QuarryStructure(id:Number, sName:String, sMCid:String)  {
			trace("Creating a new QuarryStructure...");
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
			var bNextToStone:Boolean = false;
			var grid:HexGrid = HexGrid(MapManager.getGrid("game_map"));
			//can be located on hills
			if((tile.getType().indexOf("hills") > -1))  {
				bNextToStone = true;
			}
			
			[Inject] var neighbors:Array =  grid.getMap().getNeighbours(new Point(nX, nY));
			//or next to stone outcroppings or mountaintops
			for(var i:Number = 0; i < neighbors.length; i++)  {
				nX = neighbors[i].getPosition().x;
				nY = neighbors[i].getPosition().y;
				if((grid.getTileByAtLocation(nX, nY).getType().indexOf("stone") > -1) || (grid.getTileByAtLocation(nX, nY).getType().indexOf("tops") > -1))  {
					bNextToStone = true;
				}
			}
			if(tile.getWalkable() && !tile.isWater() && !tile.hasBuilding() && bNextToStone)  {
				return true;
			}
			return false;
		}
		
	}
}