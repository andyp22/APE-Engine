/**
 * classes.project.views.LoadGameMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.LoadGameView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoadGameMediator extends Mediator  {
		
		[Inject] public var view:LoadGameView;
		
		public function LoadGameMediator()  {
			trace("Creating LoadGameMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("LoadGameMediator registered.");
			
			
		}
		
		
	}
}