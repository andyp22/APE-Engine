/**
 * classes.project.core.Configs
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.model.BaseProfile;
	import classes.project.model.ProfileLibrary;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Configs  {
		private static var instance:Configs;
		private static var bInit:Boolean = true;
		
		private static var _xml:XML;
		private static var _xmlData:Array;
		
		public static var profiles:ProfileLibrary;
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Configs  {
			if(instance == null)  {
				instance = new Configs();			}
			return instance;
		}
		public function Configs():void  {
			
		}
		public static function init(xml:XML):void  {
			if(bInit)  {
				trace("Configs initializing...");
				_xml = xml;
				profiles = new ProfileLibrary("all");
				parseXMLData();
				bInit = false;
				
			} else  {
				trace("Configs have already been initialized.");
			}
		}
		private static function parseXMLData():void  {
			//trace("\n\t\tConfigs\n------------------------------------------------------------");
			var configGroups:Array = new Array();
			for each (var configGroup:XML in _xml..configGroup) {
				configGroups[configGroup.@id] = new Array();
				//trace("\configGroup: "+configGroup.@id);
				for each(var config:XML in configGroup..config)  {
					configGroups[configGroup.@id][config.@sId] = new Array();
					//add each element in the column to the array
					var attNamesList:XMLList = config.@*;
					//create our output trace
					var sOutput:String = "\t\tconfig -- ";
					for (var z:int = 0; z < attNamesList.length(); z++)  {
						//get the element name
						var element:String = String(attNamesList[z].name());
						//get the element's value
						var elementValue:String = String(attNamesList[z].valueOf());
						//add it to our array
						configGroups[configGroup.@id][config.@sId][element] = elementValue;
						//add each element to our output string
						sOutput += ("\t " + element + ": " + elementValue);
					}
					//trace(sOutput);
				}
				if(configGroup.@type != undefined)  {
					var type:String = configGroup.@type;
					switch(type)  {
						case "profile":
							[Inject] var _profile = new BaseProfile(configGroup.@id);
							_profile.initProfileConfigs(configGroups[configGroup.@id]);
							profiles.addProfile(_profile);
							break;
					}
				}
				
			}
			_xmlData = configGroups;
			
		}
		public static function getConfigGroup(sGroup:String):Array  {
			if(_xmlData[sGroup] != null)  {
				return _xmlData[sGroup];
			}
			return null;
		}
		
		
	}
}