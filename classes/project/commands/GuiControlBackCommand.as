/**
 * classes.project.commands.GuiControlBackCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.Navigator;
	import classes.project.core.State;
	
	import org.robotlegs.mvcs.Command;
	
	public class GuiControlBackCommand extends Command  {
		
		override public function execute():void  {
			trace("BACK!!!");
			
			[Inject] State.nAbsoluteIndex = Navigator.getBack();
			[Inject] Navigator.updateClipView();
			
		}
	}
}