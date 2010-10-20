/**
 * classes.project.commands.GameMenuCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class GameMenuCommand extends Command  {
		
		override public function execute():void  {
			trace("GameMenuCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.GAME_MENU_STATE;
			[Inject] GameController.displayView("game_menu_view");
		}
	}
}