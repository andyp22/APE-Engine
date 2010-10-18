/**
 * classes.project.commands.StartupCommand
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.commands  {
	
	import classes.project.core.GameController;
	import classes.project.core.Preloader;
	import classes.project.core.Server;
	import classes.project.core.State;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.base.ContextEvent;
	
	public class StartupCommand extends Command  {
		
		
		override public function execute():void  {
			trace("Executing StartupCommand...");
			// PRIMARY FUNCTION: setup the Preloader; initialize 
			// the Server and load XML files
			/*
			 *	Preloader
			 *
			 */
			[Inject] Preloader.getInstance();
			[Inject] Preloader.setEventDispatcher(eventDispatcher);
			[Inject] Preloader.init();
			/*
			 *	Server
			 *
			 */
			[Inject] Server.getInstance();
			[Inject] Server.setEventDispatcher(eventDispatcher);
			/*
			 *	State
			 *
			 */
			[Inject] State.getInstance();
			[Inject] State.init();
			/*
			 *	GameController
			 *
			 */
			[Inject] GameController.getInstance();
			[Inject] GameController.setEventDispatcher(eventDispatcher);
			[Inject] GameController.init();
			/**
			 *	Load any SWF files needed here.
			 *
			 */
			[Inject] Server.queueSWF("swfs/assets");
			[Inject] Server.queueSWF("swfs/views/introAnimation");
			[Inject] Server.loadSWFQueue();
			/**
			 *	Load any XML files needed here.
			 *
			 */
			[Inject] Server.queueXML("configs");
			[Inject] Server.queueXML("course");
			[Inject] Server.queueXML("labels");
			[Inject] Server.queueXML("mapGrids");
			[Inject] Server.loadXMLQueue();
			/**
			 *	Run the Preloader
			 *
			 */
			[Inject] Preloader.runQueue();
			// STARTUP_COMPLETE event handled by Server after XML finishes loading
			//eventDispatcher.dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}
	}
}