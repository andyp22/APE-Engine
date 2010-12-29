/**
 * classes.project.model.grid.HexStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.LibFactory;
	import classes.project.model.grid.HexPiece;
	import classes.project.model.grid.ITile;
	
	import flash.display.MovieClip;
	
	public class HexStructure extends HexPiece {
		private var _clipID:String;
		
		/**
		 * Constructor
		 */
		public function HexStructure(id:Number, sName:String, sMCid:String)  {
			trace("Creating a new HexStructure...");
			super(id, sName, LibFactory.createMovieClip(sMCid));
			this._clipID = sMCid;
			
			this.init();
		}
		
		private function init():void  {
			
		}
		public function targetTileValid(tile:ITile):Boolean  {
			if(tile.isWalkable() && !tile.isWater())  {
				return true;
			}
			return false;
		}
		public function get clipID():String  {
			return this._clipID;
		}
		
	}
}