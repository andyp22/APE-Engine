/**
 * classes.project.views.CalculatorMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	
	import classes.project.core.LibFactory;
	import classes.project.events.GuiControlEvent;
	import classes.project.views.components.CalculatorView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * CalculatorMediator
	 */
	public class CalculatorMediator extends Mediator {
		
		[Inject] public var view:CalculatorView;

		public function CalculatorMediator() {
			trace("Creating CalculatorMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void {
			trace("CalculatorMediator registered.");
			view.setHeader("Calculator");
			view.createContentContainer(LibFactory.createMovieClip("CalculatorViewAsset"));
			view.sizeToContents();
			view.init();
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.CALCULATOR_BTN_PRESSED, toggleView);
		}
		public function toggleView(e:GuiControlEvent):void  {
			view.resetCalc();
			view.toggleView();
		}

		
	}
}
