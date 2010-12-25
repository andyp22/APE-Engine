/**
 * classes.project.model.grid.HexStructure
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.model.grid.HexPiece;
	
	import flash.display.MovieClip;
	
	public class HexStructure extends HexPiece {
		
		/**
		 * Constructor
		 */
		public function HexStructure(id:Number, sName:String, mc:MovieClip)  {
			trace("Creating a new HexStructure...");
			super(id, sName, mc);
			
			this.init();
		}
		
		private function init():void  {
			
		}
		
	}
}