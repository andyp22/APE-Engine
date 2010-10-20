/**
 * classes.project.commands.LoadGameCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadGameCommand extends Command  {
		
		override public function execute():void  {
			trace("LoadGameCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.LOADING_VIEW_STATE;
			[Inject] GameController.displayView("load_game_view");
		}
	}
}