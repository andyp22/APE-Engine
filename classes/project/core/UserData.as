/**
 * classes.project.core.UserData
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	
	
	public class UserData  {
		private static var instance:UserData;
		private static var bInit:Boolean = true;
		
		private static var _xml:XML;
		private static var _xmlData:Array;
		
		/***********************************************/
		public static var _playerProfiles:Array = new Array();
		
		
		
		
		
		/***********************************************/
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():UserData  {
			if(instance == null)  {
				instance = new UserData();			}
			return instance;
		}
		public function UserData():void  {
			
		}
		public static function init(xml:XML):void  {
			if(bInit)  {
				trace("UserData initializing...");
				_xml = xml;
				parseXMLData();
				bInit = false;
				
			} else  {
				trace("UserData has already been initialized.");
			}
		}
		private static function parseXMLData():void  {
			//trace("\n\t\UserData\n------------------------------------------------------------");
			var _userData:Array = new Array();
			for each (var uData:XML in _xml..uData) {
				//trace("\tuData --  id: "+uData.@sId+" text: "+uData.@text);
				_userData[uData.@sId] = uData.@text;
			}
			_xmlData = _userData;
			
		}
		public static function getUData(sId:String):String  {
			if(_xmlData[sId] != undefined)  {
				return _xmlData[sId];
			}
			return null;
		}
		
		
	}
}