/**
 * classes.project.commands.GameControlErrorCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import org.robotlegs.mvcs.Command;
	
	public class GameControlErrorCommand extends Command  {
		
		override public function execute():void  {
			trace("/*\n *\t[object GameMenuControl] still has the\n *\tdefault command mapped to it.\n/*");
			
		}
	}
}