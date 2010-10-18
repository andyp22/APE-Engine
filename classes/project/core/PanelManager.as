/**
 * classes.project.core.PanelManager
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.Configs;
	import classes.project.core.PanelFactory;
	import classes.project.events.PanelEvent;
	import classes.project.model.IPanel;
	import classes.project.views.components.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class PanelManager  {
		private static var instance:PanelManager;
		private static var bInit:Boolean = true;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		private static var _currentPanel:IPanel = null;
		private static var _panels:Array;
		
		[Inject] public static var contextView:DisplayObjectContainer;
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():PanelManager  {
			if(instance == null)  {
				instance = new PanelManager();			}
			return instance;
		}
		public function PanelManager():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("PanelManager initializing...");
				
				_panels = new Array();
				
				initPanels();
				
				eventMap.mapListener(_eventDispatcher, PanelEvent.PANEL_OPENED, onPanelOpened);
				eventMap.mapListener(_eventDispatcher, PanelEvent.PANEL_CLOSED, onPanelClosed);
				
				bInit = false;
			} else  {
				trace("PanelManager has already been initialized.");
			}
			
		}
		/*
		 *  event dispatcher
		 *
		 *
		 */
		public static function setEventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}
		public static function get eventMap():IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(_eventDispatcher));
		}
		/*
		 *  Event Handler Methods
		 *
		 *
		 */
		public static function onPanelOpened(e:PanelEvent):void  {
			//trace("onPanelOpened() -- "+ e.panel.getName());
			_currentPanel = e.panel;
			
			for(var i:int = 0; i < _panels.length; i++)  {
				if((_currentPanel.getName() != _panels[i].getName()) && _panels[i].isShowing())  {
					_panels[i].hide();
				}
			}
			
		}
		public static function onPanelClosed(e:PanelEvent):void  {
			//trace("onPanelClosed() -- "+ e.panel.getName());
		}
		/*
		 *  
		 *
		 *
		 */
		private static function initPanels():void  {
			[Inject] var configs:Array = Configs.getConfigGroup("PanelList");
			[Inject] var panelView:Sprite = Sprite(contextView.getChildByName("panels"));
			
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				var nX:Number = (aConfigs["xPos"] != null) ? Number(aConfigs["xPos"]): 0;
				var nY:Number = (aConfigs["yPos"] != null) ? Number(aConfigs["yPos"]): 0;
				
				var panel:IPanel = PanelFactory.makePanel(aConfigs);
				panel.setPos(nX, nY);
				panelView.addChild(Sprite(panel));
				if(aConfigs["bRegister"] != null && Boolean(aConfigs["bRegister"]))  {
					registerPanel(panel);
				}
			}
			
		}
		public static function registerPanel(panel:IPanel):void  {
			trace("Registering panel -- " + panel.getName());
			_panels.push(panel);
		}
		
		
		
		
	}
}