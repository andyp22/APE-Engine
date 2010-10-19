/**
 * classes.project.commands.InitCommand
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.commands  {
	
	import classes.project.core.Configs;
	import classes.project.core.GameController;
	import classes.project.core.Labels;
	import classes.project.core.LibFactory;
	import classes.project.core.MapManager;
	import classes.project.core.Navigator;
	import classes.project.core.PanelManager;
	import classes.project.core.Server;
	import classes.project.core.Structure;
	import classes.project.core.ViewManager;
	import classes.project.events.GuiControlEvent;
	import classes.project.interactivities.Interactivity;
	import classes.project.model.GuiControl;
	import classes.project.model.Tooltips;
	import classes.project.views.components.*;
	
	import flash.display.Sprite;
	
	import org.robotlegs.mvcs.*;
	
	public class InitCommand extends Command  {
		
		override public function execute():void  {
			trace("Executing InitCommand...");
			[Inject] Server.onStartupComplete();
			/*
			 *	Structure
			 *
			 */
			[Inject] Structure.getInstance();
			[Inject] Structure.init(Server.xmlData["course"]);
			/*
			 *	Navigation
			 *
			 */
			[Inject] Navigator.getInstance();
			[Inject] Navigator.init();
			/*
			 *	Configs
			 *
			 */
			[Inject] Configs.getInstance();
			[Inject] Configs.init(Server.xmlData["configs"]);
			/*
			 *	Labels
			 *
			 */
			[Inject] Labels.getInstance();
			[Inject] Labels.init(Server.xmlData["labels"]);
			/*
			 *	Grids
			 *
			 */
			[Inject] MapManager.getInstance();
			[Inject] MapManager.parseXMLData(Server.xmlData["mapGrids"]);
			/*
			 *	Views
			 *
			 */
			[Inject] ViewManager.getInstance();
			[Inject] ViewManager.setEventDispatcher(eventDispatcher);
			[Inject] ViewManager.contextView = contextView;
			[Inject] ViewManager.init();
			//[Inject] ViewManager.initViews();
			/*
			 *	Panels
			 *
			 */
			[Inject] PanelManager.getInstance();
			[Inject] PanelManager.setEventDispatcher(eventDispatcher);
			[Inject] PanelManager.contextView = contextView;
			[Inject] PanelManager.init();
			/*
			 *	Interactivities
			 *
			 */
			[Inject] Interactivity.getInstance();
			[Inject] Interactivity.setEventDispatcher(eventDispatcher);
			[Inject] Interactivity.contextView = contextView;
			[Inject] Interactivity.init();
			//sorting			
			[Inject] Interactivity.createActivity("SORTING");
			
			
			
			
			/*
			 *	Tooltips
			 *
			 */
			var tooltipView:Sprite = Sprite(contextView.getChildByName("tooltips"));
			[Inject] Tooltips.getInstance();
			tooltipView.addChild(Tooltips.getHolder());
			
			[Inject] GameController.onInitComplete();
		}
	}
}