/**
 * classes.project.views.BaseMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.BaseView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BaseMediator extends Mediator {
		
		[Inject] public var view:BaseView;
		
		public function BaseMediator()  {
			trace("Creating BaseMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("BaseMediator registered.");
			
			
			
		}
		
		
	}
}