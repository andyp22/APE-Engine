/**
 * classes.project.views.TimerPanelMediator
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
	
	public class TimerPanelMediator extends Mediator {
		
		[Inject] public var view:TimerPanelView;
		
		public function TimerPanelMediator()  {
			trace("Creating TimerPanelMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("TimerPanelMediator registered.");
			view.setHeader("Timers");
			
			view.createContentContainer(new MovieClip());
			view.sizeToContents();
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.TIMER_BTN_PRESSED, toggleView);
			
		}
		public function toggleView(e:GuiControlEvent):void  {
			view.toggleView();
		}
		
	}
}