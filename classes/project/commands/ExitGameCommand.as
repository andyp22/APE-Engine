﻿/**
 * classes.project.commands.ExitGameCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.State;
	import classes.project.core.ViewState;
	
	import org.robotlegs.mvcs.Command;
	
	public class ExitGameCommand extends Command  {
		
		override public function execute():void  {
			trace("ExitGameCommand executing...");
			[Inject] State.sCurrentViewState = ViewState.EXIT_GAME_STATE;
			[Inject] GameController.displayView("exit_game_view");
		}
	}
}