/**
 * classes.project.model.Player
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model {
	
	import flash.display.Sprite;
	
	public class Player extends Sprite {
		
		private var CURRENT_MAP:String = "sample_map";
		
		
		/**
		 * Constructor
		 */
		public function Player()  {
			trace("Creating a new Player...");
			super();
			
			this.init();
		}
		private function init():void  {
			
		}
		
		
	}
}