/**
 * classes.project.core.MapManager
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.Configs;
	import classes.project.model.grid.IGrid;
	
	import flash.display.DisplayObjectContainer;
	
	
	public class MapManager  {
		private static var instance:MapManager;
		private static var bInit:Boolean = true;
		
		private static var _xml:XML;
		private static var _xmlData:Array;
		
		private static var _currentMap:IGrid = null;
		private static var _maps:Array;
		
		[Inject] public static var contextView:DisplayObjectContainer;
		
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():MapManager  {
			if(instance == null)  {
				instance = new MapManager();			}
			return instance;
		}
		public function MapManager():void  {
			if(bInit)  {
				trace("MapManager initializing...");
				init();
				bInit = false;
			} else  {
				trace("MapManager has already been initialized.");
			}
		}
		private static function init():void  {
			_xmlData = new Array();
			_maps = new Array();
			
			
			
		}
		public static function parseXMLData(xml:XML):void  {
			trace("MapManager parsing XML...");
			_xml = xml;
			
			//trace("\n\t\Grids\n------------------------------------------------------------");
			var maps:Array = new Array();
			for each (var grid:XML in _xml..grid) {
				//trace("\tgrid --  id: "+grid.@id);
				maps[grid.@id] = new Array();
				
				for each (var row:XML in grid..row) {
					//trace("\t\trow --  id: "+row.@id);
					maps[grid.@id][Number(row.@id)] = new Array();
					
					for each (var col:XML in row..col) {
						maps[grid.@id][Number(row.@id)][Number(col.@id)] = new Array();
						
						//add each element in the column to the array
						var attNamesList:XMLList = col.@*;
						//create our output trace
						var sOutput:String = "\t\t\tcol -- ";
						for (var z:int = 0; z < attNamesList.length(); z++)  {
							//get the element name
							var element:String = String(attNamesList[z].name());
							//get the element's value
							var elementValue:String = String(attNamesList[z].valueOf());
							//add it to our array
							maps[grid.@id][Number(row.@id)][Number(col.@id)][element] = elementValue;
							//add each element to our output string
							sOutput += ("\t " + element + ": " + elementValue);
						}
						//trace(sOutput);
						
					}
				}
			}
			_xmlData = maps;
		}
		/*
		 *  
		 *
		 *
		 */
		public static function getGridXML(sID:String):Array  {
			return _xmlData[sID];
		}
		public static function registerGrid(grid:IGrid):void  {
			trace("Registering map grid -- " + grid.getID());
			_maps[grid.getID()] = grid;
		}
		public static function getGrid(sID:String):IGrid  {
			return _maps[sID];
		}
		
		
		
		
	}
}