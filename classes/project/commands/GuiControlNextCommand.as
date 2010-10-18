/**
 * classes.project.commands.GuiControlNextCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.Navigator;
	import classes.project.core.State;
	
	import org.robotlegs.mvcs.Command;
	
	public class GuiControlNextCommand extends Command  {
		
		override public function execute():void  {
			trace("NEXT!!!");
			
			[Inject] State.nAbsoluteIndex = Navigator.getNext();
			[Inject] Navigator.updateClipView();
		}
	}
}