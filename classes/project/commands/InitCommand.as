/**
 * classes.project.commands.InitCommand
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.commands  {
	
	import classes.project.core.*;
	import classes.project.events.GuiControlEvent;
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
			 *	ResourceManager
			 *
			 */
			[Inject] ResourceManager.getInstance();
			[Inject] ResourceManager.parseResourceData();
			/*
			 *	Views
			 *
			 */
			[Inject] ViewManager.getInstance();
			[Inject] ViewManager.setEventDispatcher(eventDispatcher);
			[Inject] ViewManager.contextView = contextView;
			[Inject] ViewManager.init();
			/*
			 *	Panels
			 *
			 */
			[Inject] PanelManager.getInstance();
			[Inject] PanelManager.setEventDispatcher(eventDispatcher);
			[Inject] PanelManager.contextView = contextView;
			[Inject] PanelManager.init();
			/*
			 *	Tooltips
			 *
			 */
			var tooltipView:Sprite = Sprite(contextView.getChildByName("tooltips"));
			[Inject] Tooltips.getInstance();
			tooltipView.addChild(Tooltips.getHolder());
			/*
			 *	UserData
			 *
			 */
			[Inject] UserData.getInstance();
			[Inject] UserData.init(Server.xmlData["userData"]);
			/*
			 *	Factories
			 *
			 */
			[Inject] OverlayFactory.getInstance();
			[Inject] StructureFactory.getInstance();
			/*
			 *	Initialization Complete
			 *
			 */
			[Inject] GameController.onInitComplete();
		}
	}
}