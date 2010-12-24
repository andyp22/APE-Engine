/**
 * classes.project.events.GameControlEvent
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.events  {
	
	import flash.events.Event;
	
	public class GameControlEvent extends Event  {
		//default GameControlEvent
		public static const GAMEMENU_CONTROL_PRESSED:String = "GAMEMENU_CONTROL_PRESSED";
		//define other GameControlEvents here (in alphabetical order)
		public static const CREDITS_BTN_PRESSED:String = "CREDITS_BTN_PRESSED";
		public static const EXIT_BTN_PRESSED:String = "EXIT_BTN_PRESSED";
		public static const GAME_MENU_BTN_PRESSED:String = "GAME_MENU_BTN_PRESSED";
		public static const LOAD_GAME_BTN_PRESSED:String = "LOAD_GAME_BTN_PRESSED";
		public static const NEW_GAME_BTN_PRESSED:String = "NEW_GAME_BTN_PRESSED";
		public static const OPTIONS_BTN_PRESSED:String = "OPTIONS_BTN_PRESSED";
		public static const PROFILES_BTN_PRESSED:String = "PROFILES_BTN_PRESSED";
		public static const REPORT_BUG_BTN_PRESSED:String = "REPORT_BUG_BTN_PRESSED";
		public static const SAVE_GAME_BTN_PRESSED:String = "SAVE_GAME_BTN_PRESSED";
		
		
		public static const TEST_GAME_BTN_PRESSED:String = "TEST_GAME_BTN_PRESSED";
		
		
		public function GameControlEvent(sType:String)  {
			super(sType);
		}
		
		override public function clone():Event  {
			return new GameControlEvent(type);
		}
	}
}