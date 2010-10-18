/**
 * classes.project.core.PanelFactory
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.LibFactory;
	import classes.project.model.IPanel;
	import classes.project.views.components.*;
	
	public class PanelFactory  {
		private static var instance:PanelFactory;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():PanelFactory  {
			if(instance == null)  {
				instance = new PanelFactory();			}
			return instance;
		}
		public function PanelFactory():void  {
			
		}
		/*
		 *  
		 */
		public static function makePanel(configs:Array):IPanel  {
			var panel:IPanel = null;
			switch(configs["type"])  {
				case "Calculator":
					panel = new CalculatorView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				case "ClipsPanel":
					panel = new ClipView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				case "HexMap":
					panel = new HexMapView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				case "MainMenu":
					panel = new MainMenuView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				case "SlidingPanel":
					panel = new SlidingPanelView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				case "Timers":
					panel = new TimerPanelView(configs["sId"], LibFactory.createMovieClip("GuiControlPanelMC"));
					break;
				
			}
			return panel;
		}
		
		
	}
}