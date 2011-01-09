/**
 * classes.project.core.ResourceManager
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.model.PlayerResource;
	
	import flash.display.DisplayObjectContainer;
	
	
	public class ResourceManager  {
		private static var instance:ResourceManager;
		private static var bInit:Boolean = true;
		
		private static var _resources:Array;
		private static var _structureCosts:Array;
		
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():ResourceManager  {
			if(instance == null)  {
				instance = new ResourceManager();			}
			return instance;
		}
		public function ResourceManager():void  {
			if(bInit)  {
				trace("ResourceManager initializing...");
				init();
				bInit = false;
			} else  {
				trace("ResourceManager has already been initialized.");
			}
		}
		private static function init():void  {
			_resources = new Array();
			_structureCosts = new Array();
			
			parseResourceData();
			parseStructureConstructionData();
			
		}
		private static function parseResourceData():void  {
			trace("ResourceManager parsing Resources...");
			[Inject] var configs:Array = Configs.getConfigGroup("ResourceMasterList");
			
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				var sOutput:String = "";
				var sLabel:String = aConfigs["sId"];
				var nQuantity:Number = 0;
				
				sOutput += "Resource: "+sLabel;
				
				if(aConfigs["nQuantity"] != null && !isNaN(Number(aConfigs["nQuantity"])))  {
					nQuantity = Number(aConfigs["nQuantity"]);
					sOutput += " -- Qty: "+nQuantity;
				}
				
				var resource:PlayerResource = new PlayerResource(sLabel, aConfigs["mcID"], nQuantity);
				
				_resources[sLabel] = resource;
				trace(sOutput);
			}
		}
		public static function parseStructureConstructionData():void  {
			trace("ResourceManager parsing StructureConstructionData...");
			[Inject] var configs:Array = Configs.getConfigGroup("StructureMasterList");
			
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				var aCosts:Array = new Array();
				
				for(var res in aConfigs)  {
					if(String(res).indexOf("n") > -1 && String(res).indexOf("n") < 1)  {
						var sRes:String = String(res).substr(1).toLowerCase();
						var nQty:Number = Number(aConfigs[res]);
						
						aCosts[sRes] = nQty;
						
						
					}
				}
				_structureCosts[aConfigs["sId"]] = aCosts;
			}
			
			
		}
		/*
		 *  
		 *
		 *
		 */
		public static function addResource(resource:PlayerResource):void  {
			_resources[resource.getName()] = resource;
		}
		public static function getResource(sName:String):PlayerResource  {
			return _resources[sName];
		}
		public static function hasResource(sName:String):Boolean  {
			if(_resources[sName] != null)  {
				return true;
			}
			return false;
		}
		/*
		 *  
		 *
		 *
		 */
		public static function checkConstructionResources(sName:String):Boolean  {
			var bReturn:Boolean = true;
			var aCosts:Array = _structureCosts[sName];
			for(var elm in aCosts)  {
				var nResQty:Number = (hasResource(elm)) ? getResource(elm).getQty() : 0;
				if(nResQty < Number(aCosts[elm]))  {
					bReturn = false;
				}
			}
			return bReturn;
		}
		public static function removeConstructionResources(sName:String):void  {
			var aCosts:Array = _structureCosts[sName];
			for(var elm in aCosts)  {
				getResource(elm).update((-1 * Number(aCosts[elm])));
			}
			
		}
		public static function refundConstructionResources(sName:String):void  {
			trace("refundConstructionResources: "+sName);
			var aCosts:Array = _structureCosts[sName];
			for(var elm in aCosts)  {
				getResource(elm).update(Number(aCosts[elm]));
			}
		}
		
		
		
		
	}
}