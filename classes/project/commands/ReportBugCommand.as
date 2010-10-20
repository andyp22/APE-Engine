/**
 * classes.project.commands.ReportBugCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class ReportBugCommand extends Command  {
		
		override public function execute():void  {
			trace("ReportBugCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.REPORT_BUG_STATE;
			[Inject] GameController.displayView("report_bug_view");
		}
	}
}