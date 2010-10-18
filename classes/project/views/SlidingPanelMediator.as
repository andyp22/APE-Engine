/**
 * classes.project.views.SlidingPanelMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	
	import classes.project.views.components.*;
	import classes.project.events.GuiControlEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SlidingPanelMediator extends Mediator {
		
		[Inject]
		public var view:SlidingPanelView;
		
		
		public function SlidingPanelMediator()  {
			trace("Creating SlidingPanelMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("SlidingPanelMediator registered.");
			view.setHeader("Main Menu");
			
			view.createContentContainer(new MovieClip());
			//view.alignToSide("top");
			//view.alignToSide("bottom");
			//view.alignToSide("right");
			//view.alignToSide("left");
			view.sizeToContents();
			
		}
		
		
		
	}
}