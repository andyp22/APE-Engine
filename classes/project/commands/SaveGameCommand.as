/**
 * classes.project.commands.SaveGameCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class SaveGameCommand extends Command  {
		
		override public function execute():void  {
			trace("SaveGameCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.SAVING_VIEW_STATE;
			[Inject] GameController.displayView("save_game_view");
		}
	}
}