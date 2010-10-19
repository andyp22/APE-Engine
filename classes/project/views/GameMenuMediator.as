/**
 * classes.project.views.GameMenuMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.GameMenuView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class GameMenuMediator extends Mediator  {
		
		[Inject] public var view:GameMenuView;
		
		public function GameMenuMediator()  {
			trace("Creating GameMenuMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("GameMenuMediator registered.");
			
			
		}
		
		
	}
}