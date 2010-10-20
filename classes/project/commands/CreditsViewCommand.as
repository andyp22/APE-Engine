/**
 * classes.project.commands.CreditsViewCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class CreditsViewCommand extends Command  {
		
		override public function execute():void  {
			trace("CreditsViewCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.GAME_CREDITS_VIEW_STATE;
			[Inject] GameController.displayView("game_credits_view");
		}
	}
}