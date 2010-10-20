/**
 * classes.project.views.NewGameMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.NewGameView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class NewGameMediator extends Mediator  {
		
		[Inject] public var view:NewGameView;
		
		public function NewGameMediator()  {
			trace("Creating NewGameMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("NewGameMediator registered.");
			
			
		}
		
		
	}
}