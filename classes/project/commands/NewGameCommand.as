/**
 * classes.project.commands.NewGameCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class NewGameCommand extends Command  {
		
		override public function execute():void  {
			trace("NewGameCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.NEW_GAME_STATE;
			[Inject] GameController.displayView("new_game_view");
		}
	}
}