/**
 * classes.project.core.Labels
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	
	
	public class Labels  {
		private static var instance:Labels;
		private static var bInit:Boolean = true;
		
		private static var _xml:XML;
		private static var _xmlData:Array;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():Labels  {
			if(instance == null)  {
				instance = new Labels();			}
			return instance;
		}
		public function Labels():void  {
			
		}
		public static function init(xml:XML):void  {
			if(bInit)  {
				trace("Labels initializing...");
				_xml = xml;
				parseXMLData();
				bInit = false;
				
			} else  {
				trace("Labels have already been initialized.");
			}
		}
		private static function parseXMLData():void  {
			//trace("\n\t\Labels\n------------------------------------------------------------");
			var labels:Array = new Array();
			for each (var label:XML in _xml..label) {
				//trace("\tlabel --  id: "+label.@sId+" text: "+label.@text);
				labels[label.@sId] = label.@text;
			}
			_xmlData = labels;
			
		}
		public static function getLabel(sId:String):String  {
			if(_xmlData[sId] != undefined)  {
				return _xmlData[sId];
			}
			return "undefined";
		}
		
		
	}
}