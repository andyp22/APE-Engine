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
			
			
			
		}
		public static function parseResourceData():void  {
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
			[Inject] var configs:Array = Configs.getConfigGroup("StructureMasterList");
			var bReturn:Boolean = true;
			
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				//get the building
				if(aConfigs["sId"] == sName)  {
					//check the resources
					for(var res in aConfigs)  {
						if(String(res).indexOf("n") > -1 && String(res).indexOf("n") < 1)  {
							var sRes:String = String(res).substr(1).toLowerCase();
							var nQty:Number = Number(aConfigs[res]);
							
							var nResQty:Number = (hasResource(sRes)) ? getResource(sRes).getQty() : 0;
							if(nResQty < nQty)  {
								bReturn = false;
							}
						}
					}
				}
			}
			
			return bReturn;
		}
		public static function removeConstructionResources(sName:String):Boolean  {
			[Inject] var configs:Array = Configs.getConfigGroup("StructureMasterList");
			var bReturn:Boolean = true;
			
			for(var elm in configs)  {
				var aConfigs:Array = configs[elm];
				//get the building
				if(aConfigs["sId"] == sName)  {
					//check the resources
					for(var res in aConfigs)  {
						if(String(res).indexOf("n") > -1 && String(res).indexOf("n") < 1)  {
							var sRes:String = String(res).substr(1).toLowerCase();
							var nQty:Number = Number(aConfigs[res]);
							
							getResource(sRes).update((-1 * nQty));
						}
					}
				}
			}
			
			return bReturn;
		}
		
		
		
		
	}
}