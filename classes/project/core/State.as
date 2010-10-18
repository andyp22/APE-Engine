/*
 * classes.project.core.State
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.core  {
	
	import classes.project.model.structure.*;
	
	
	public class State  {
		private static var instance:State;
		private static var bInit:Boolean = true;
		
		public static var nAbsoluteIndex:Number;
		public static var nRelativeIndex:Number;
		public static var sLink:String;
		
		public static var sChapterID:String;
		public static var sSectionID:String;
		public static var sClipID:String;
		public static var sSegmentID:String;
		
		public static var nChapter:Number;
		public static var nSection:Number;
		public static var nClip:Number;
		public static var nSegment:Number;
		
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():State  {
			if(instance == null)  {
				instance = new State();			}
			return instance;
		}
		public function State():void  {
			
		}
		public static function init():void  {
			if(bInit)  {
				trace("State initializing...");
				bInit = false;
				
			} else  {
				trace("State has already been initialized.");
			}
		}
		
		
	}
}