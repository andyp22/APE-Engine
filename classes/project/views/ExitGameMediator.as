/**
 * classes.project.views.ExitGameMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.ExitGameView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ExitGameMediator extends Mediator  {
		
		[Inject] public var view:ExitGameView;
		
		public function ExitGameMediator()  {
			trace("Creating ExitGameMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("ExitGameMediator registered.");
			
			
		}
		
		
	}
}