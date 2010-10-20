/**
 * classes.project.views.SaveGameMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.components.SaveGameView;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SaveGameMediator extends Mediator  {
		
		[Inject] public var view:SaveGameView;
		
		public function SaveGameMediator()  {
			trace("Creating SaveGameMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("SaveGameMediator registered.");
			
			
		}
		
		
	}
}