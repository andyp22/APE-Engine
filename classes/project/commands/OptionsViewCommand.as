/**
 * classes.project.commands.OptionsViewCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class OptionsViewCommand extends Command  {
		
		override public function execute():void  {
			trace("OptionsViewCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.OPTIONS_MENU_VIEW_STATE;
			[Inject] GameController.displayView("options_menu_view");
			
		}
	}
}