/**
 * classes.project.views.components.GameMenuView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class GameMenuView extends BaseView  {
		
		/**
		 * Constructor
		 */
		public function GameMenuView(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new GameMenuView() -- " + sName);
			
		}
		
		
	}
}