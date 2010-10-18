/**
 * classes.project.views.IntroMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.IntroView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class IntroMediator extends Mediator  {
		
		[Inject] public var view:IntroView;
		
		public function IntroMediator()  {
			trace("Creating IntroMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("IntroMediator registered.");
			view.startShow();
			
		}
		
		
	}
}