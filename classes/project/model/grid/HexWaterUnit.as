/**
 * classes.project.model.grid.HexWaterUnit
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.MapManager;
	import classes.project.model.grid.HexUnit;
	
	import flash.display.MovieClip;
	
	public class HexWaterUnit extends HexUnit {
		
		/**
		 * Constructor
		 */
		public function HexWaterUnit(id:Number, sName:String, mc:MovieClip)  {
			trace("Creating a new HexWaterUnit...");
			super(id, sName, mc);
			
		}
		override public function checkMove(nX:Number, nY:Number):Boolean  {
			[Inject] var grid:IGrid = MapManager.getGrid(CURRENT_MAP);
			if(grid.getTileByLocation(nX, nY) != null)  {
				if(grid.getTileByLocation(nX, nY).isWater())  {
					return true;
				}
			}
			return false;
		}
		
		
	}
}