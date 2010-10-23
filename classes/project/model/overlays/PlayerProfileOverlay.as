/**
 * classes.project.model.overlays.PlayerProfileOverlay
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.overlays  {
	
	//import classes.project.core.LibFactory;
	//import classes.project.core.Server;
	import classes.project.model.BaseOverlay;
	
	import flash.display.MovieClip;
	//import flash.display.Sprite;
	
	public class PlayerProfileOverlay extends BaseOverlay  {
		
		
		
		/**
		 * Constructor
		 */
		public function PlayerProfileOverlay(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new PlayerProfileOverlay -- " + this + " : " + sName);
			
			//this.init();
		}
		
		private function init():void  {
			//trace("PlayerProfileOverlay initializing...");
			
			
			
			
		}
		
	}
}