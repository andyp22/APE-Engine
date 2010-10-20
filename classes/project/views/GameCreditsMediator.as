/**
 * classes.project.views.GameCreditsMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.GameCreditsView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class GameCreditsMediator extends Mediator  {
		
		[Inject] public var view:GameCreditsView;
		
		public function GameCreditsMediator()  {
			trace("Creating GameCreditsMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("GameCreditsMediator registered.");
			
			
		}
		
		
	}
}