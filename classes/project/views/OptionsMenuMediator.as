/**
 * classes.project.views.OptionsMenuMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.OptionsMenuView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class OptionsMenuMediator extends Mediator  {
		
		[Inject] public var view:OptionsMenuView;
		
		public function OptionsMenuMediator()  {
			trace("Creating OptionsMenuMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("OptionsMenuMediator registered.");
			
			
		}
		
		
	}
}