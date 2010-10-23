/**
 * classes.project.core.OverlayFactory
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.LibFactory;
	import classes.project.model.IOverlay;
	import classes.project.model.BaseOverlay;
	import classes.project.model.overlays.*;
	
	public class OverlayFactory  {
		private static var instance:OverlayFactory;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():OverlayFactory  {
			if(instance == null)  {
				instance = new OverlayFactory();			}
			return instance;
		}
		public function OverlayFactory():void  {
			
		}
		/*
		 *  
		 */
		public static function makeOverlay(sType:String):IOverlay  {
			var overlay:IOverlay = null;
			switch(sType)  {
				case "players_tab":
					overlay = new PlayerProfileOverlay(sType, LibFactory.createMovieClip("Player_Overlay_MC"));
					break;
				case "characters_tab":
					overlay = new BaseOverlay(sType, LibFactory.createMovieClip("dummy2"));
					break;
				case "history_tab":
					overlay = new BaseOverlay(sType, LibFactory.createMovieClip("dummy3"));
					break;
				
				
			}
			return overlay;
		}
		
		
	}
}