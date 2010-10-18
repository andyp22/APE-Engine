/**
 * classes.project.views.MainMenuMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.views.*;
	import classes.project.views.components.*;
	import classes.project.events.GuiControlEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMenuMediator extends Mediator {
		
		[Inject] public var view:MainMenuView;
		
		public function MainMenuMediator()  {
			trace("Creating MainMenuMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("MainMenuMediator registered.");
			view.setHeader("Main Menu");
			
			view.createContentContainer(new MovieClip());
			//view.createContentContainer(new testBG1());
			//view.createContentContainer(new testBG2());
			view.sizeToContents();
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.MENU_BTN_PRESSED, toggleView);
			
		}
		public function toggleView(e:GuiControlEvent):void  {
			view.toggleView();
		}
		
	}
}