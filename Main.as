package {
	
	import classes.project.AppContext;
	
	import flash.display.Sprite;
	
	public class Main extends Sprite {
		
		private var context:AppContext;
		
		/**
		 * Constructor
		 */
		public function Main()  {
			trace("Starting the application...");
			super();
			this.init();
		}
		private function init():void  {
			trace("Initializing...");
			this.context = new AppContext(this);
		}
		
	}
}