/**
 * classes.project.core.Server
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.GameController;
	import classes.project.model.ControlGroup;
	import classes.project.model.GuiControl;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;
	
	public class Server  {
		private static var instance:Server;
		
		private static var _eventDispatcher:IEventDispatcher;
		private static var _eventMap:IEventMap;
		
		private static var controlGroups:Array;
		public static var xmlData:Array;
		private static var bXMLQueued:Boolean;
		private static var bSWFQueued:Boolean;
		private static var bStartupComplete:Boolean;
		
		
		private static var _assets:Array;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Server  {
			if(instance == null)  {
				instance = new Server();			}
			return instance;
		}
		public function Server():void  {
			this.init();
		}
		private function init():void  {
			trace("Server initializing...");
			
			controlGroups = new Array();
			xmlData = new Array();
			_assets = new Array();
			bXMLQueued = false;
			bSWFQueued = false;
			bStartupComplete = false;
			
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
		 * Dispatch helper method
		 *
		 * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
		 */
		public static function dispatch(event:Event):Boolean
		{
 		    if(_eventDispatcher.hasEventListener(event.type))
 		        return _eventDispatcher.dispatchEvent(event);
 		 	return false;
		}
		/*
		 *	Controls and ControlGroups
		 *
		 */
		public static function addControl(control:GuiControl, sGroup:String = null):void  {
			if(sGroup != null)  {
				if(sGroup.indexOf(",") != -1)  {
					var aGroups:Array = sGroup.split(",");
					for(var i:int = 0; i < aGroups.length; i++)  {
						addControlToGroup(control, aGroups[i]);
					}
				} else  {
					addControlToGroup(control, sGroup);
				}
			}
			addControlToGroup(control, "all");
		}
		public static function getControl(sName:String):GuiControl  {
			return controlGroups["all"].getControl(sName);
		}
		public static function hasControl(sName:String):Boolean  {
			return controlGroups["all"].hasControl(sName);
		}
		private static function addControlToGroup(control:GuiControl, sGroup:String):void  {
			if(controlGroups[sGroup] == null)  {
				controlGroups[sGroup] = new ControlGroup(sGroup);
			}
			controlGroups[sGroup].addControl(control);
		}
		public static function enableControlGroup(sGroup:String):void  {
			controlGroups[sGroup].enable();
		}
		public static function disableControlGroup(sGroup:String):void  {
			controlGroups[sGroup].disable();
		}
		public static function getControlGroup(sGroup:String):ControlGroup  {
			return controlGroups[sGroup];
		}
		/*
		 *	XML Loading and Handling
		 *
		 */
		public static function queueXML(sFile:String):void  {
			trace("Server: queueXML("+sFile+")");
			xmlData[sFile] = null;
		}
		public static function loadXMLQueue():void  {
			trace("Server: loadXMLQueue()");
			for(var elm in xmlData)  {
				if(xmlData[elm] == null)  {
					var sURL:String = "xmls/"+ elm + ".xml";
					Preloader.addToQueue(sURL);
				}
			}
		}
		/*
		 *	SWF Loading and Handling
		 *
		 */
		public static function queueSWF(sFile:String):void  {
			trace("Server: queueSWF("+sFile+")");
			_assets[getClipLink(sFile)] = null;
		}
		public static function loadSWFQueue():void  {
			trace("Server: loadSWFQueue()");
			for(var elm in _assets)  {
				if(_assets[elm] == null)  {
					var sURL:String = getFileLink(elm) + ".swf";
					Preloader.addToQueue(sURL);
				}
			}
		}
		public static function storeAssets(asset:DisplayObject, sName:String):void  {
			_assets[sName] = asset;
		}
		public static function getAsset(sName:String):DisplayObject  {
			return _assets[sName];
		}
		
		public static function getClipLink(sUrl:String):String  {
			var nIndex:Number = sUrl.indexOf(".");
			var sName:String = (nIndex >= 0) ? sUrl.substr(0, nIndex) : sUrl;
			nIndex = sName.indexOf("/");
			while(nIndex >= 0)  {
				var sFront:String = sName.substr(0, nIndex);
				var sBack:String = sName.substr((nIndex + 1));
				sName = sFront + "_" + sBack;
				nIndex = sName.indexOf("/");
			}
			return sName;
		}
		public static function getFileLink(sId:String):String  {
			var sFile:String = sId;
			var nIndex:Number = sFile.indexOf("_");
			while(nIndex >= 0)  {
				var sFront:String = sFile.substr(0, nIndex);
				var sBack:String = sFile.substr((nIndex + 1));
				sFile = sFront + "/" + sBack;
				nIndex = sFile.indexOf("_");
			}
			return sFile;
		}
		/*
		 *	File Loading and Handling
		 *
		 */
		public static function onFileLoaded(sType:String) : void  {
			trace("Server: onFileLoaded("+sType+")");
			// check to see if all queued files have been loaded
			bXMLQueued = false;
			for(var elm in xmlData)  {
				if(xmlData[elm] == null)  {
					bXMLQueued = true;
				}
			}
			
			bSWFQueued = false;
			for(var swfElm in _assets)  {
				if(_assets[swfElm] == null)  {
					bSWFQueued = true;
				}
			}
			
			if(!bXMLQueued && !bSWFQueued)  {
				instance.handleAllFilesLoaded();
			}
		}
		private function handleAllFilesLoaded() : void  {
			trace("Server: handleAllFilesLoaded()");
			if(!bStartupComplete)  {
				dispatch(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
				return;
			}
			// might need to do some other stuff here
			if(bStartupComplete)  {
				[Inject] GameController.onLoadFinished();
			}
		}
		public static function onStartupComplete() : void  {
			bStartupComplete = true;
		}
	}
}