/**
 * classes.project.core.ViewFactory
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.core  {
	
	import classes.project.core.LibFactory;
	import classes.project.views.components.*;
	
	import flash.display.MovieClip;
	
	public class ViewFactory  {
		private static var instance:ViewFactory;
		
		/**
		 * Singleton Constructor
		 */
		public static function getInstance():ViewFactory  {
			if(instance == null)  {
				instance = new ViewFactory();			}
			return instance;
		}
		public function ViewFactory():void  {
			
		}
		/*
		 *  
		 */
		public static function makeView(sView:String):IView  {
			var view:IView = null;
			switch(sView)  {
				case "exit_game_view":
					[Inject] view = new ExitGameView(sView, "swfs_views_introAnimation");
					break;
				case "game_credits_view":
					[Inject] view = new GameCreditsView(sView, "swfs_views_introAnimation");
					break;
				case "game_menu_view":
					[Inject] view = new GameMenuView(sView, "swfs_views_menuScreens");
					break;
				case "intro_view":
					[Inject] view = new IntroView(sView, "swfs_views_introAnimation");
					break;
				case "load_game_view":
					[Inject] view = new LoadGameView(sView, "swfs_views_menuScreens");
					break;
				case "new_game_view":
					[Inject] view = new NewGameView(sView, "swfs_views_menuScreens");
					break;
				case "options_menu_view":
					[Inject] view = new OptionsMenuView(sView, "swfs_views_menuScreens");
					break;
				case "profile_menu_view":
					[Inject] view = new ProfileMenuView(sView, "swfs_views_menuScreens");
					break;
				case "report_bug_view":
					[Inject] view = new ReportBugView(sView, "swfs_views_menuScreens");
					break;
				case "save_game_view":
					[Inject] view = new SaveGameView(sView, "swfs_views_menuScreens");
					break;
				/*
				case "":
					
					break;
				*/
			}
			return view;
		}
		
		
	}
}