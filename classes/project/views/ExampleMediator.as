/**
 * classes.project.views.ExampleMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.ExampleView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ExampleMediator extends Mediator  {
		
		[Inject] public var view:ExampleView;
		
		public function ExampleMediator()  {
			trace("Creating ExampleMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("ExampleMediator registered.");
			
			
		}
		
		
	}
}