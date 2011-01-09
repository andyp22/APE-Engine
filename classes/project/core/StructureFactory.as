/**
 * classes.project.core.StructureFactory
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.LibFactory;
	import classes.project.model.grid.HexStructure;
	import classes.project.model.structures.*;
	import classes.project.views.components.*;
	
	public class StructureFactory  {
		private static var instance:StructureFactory;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():StructureFactory  {
			if(instance == null)  {
				instance = new StructureFactory();			}
			return instance;
		}
		public function StructureFactory():void  {
			
		}
		/*
		 *  
		 */
		public static function makeStructure(configs:Array):HexStructure  {
			var building:HexStructure = null;
			switch(configs["type"])  {
				case "main_town":
					building = new MainTownStructure(Number(configs["nId"]), configs["type"], configs["sMCid"]);
					break;
				case "port":
					building = new PortStructure(Number(configs["nId"]), configs["type"], configs["sMCid"]);
					break;
				default:
					building = new HexStructure(Number(configs["nId"]), configs["type"], configs["sMCid"]);
					break;
				
			}
			return building;
		}
		
		
	}
}