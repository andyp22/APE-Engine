/**
 * classes.project.commands.ProfileViewCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class ProfileViewCommand extends Command  {
		
		override public function execute():void  {
			trace("ProfileViewCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.PROFILE_MENU_VIEW_STATE;
			[Inject] GameController.displayView("profile_menu_view");
		}
	}
}