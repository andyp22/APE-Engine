/**
 * classes.project.views.components.ExampleView
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components  {
	
	import classes.project.views.components.BaseView;
	
	import flash.display.MovieClip;
	
	public class ExampleView extends BaseView  {
		
		/**
		 * Constructor
		 */
		public function ExampleView(sName:String, mc:MovieClip)  {
			super(sName, mc);
			trace("Creating new ExampleView() -- " + sName);
			
		}
		
		
	}
}