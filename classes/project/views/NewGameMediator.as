/**
 * classes.project.views.NewGameMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewManager;
	import classes.project.core.ViewState;
	import classes.project.events.GameControlEvent;
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
			
			eventMap.mapListener(eventDispatcher, GameControlEvent.TEST_GAME_BTN_PRESSED, onStartTestGame);
			
		}
		
		private function onStartTestGame(e:GameControlEvent) : void  {
			trace("Starting a test game...");
			
			[Inject] State.sCurrentViewState = ViewState.TEST_GAME_STATE;
			
			//create the map
			[Inject] GameController.displayView("test_game_view");
			
		}
		
	}
}