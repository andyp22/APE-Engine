/**
 * classes.project.views.HexMapMediator
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
	
	public class HexMapMediator extends Mediator {
		
		[Inject] public var view:HexMapView;
		
		public function HexMapMediator()  {
			trace("Creating HexMapMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("HexMapMediator registered.");
			view.setHeader("Hex Map");
			
			view.createContentContainer(new MovieClip());
			view.sizeToContents();
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.HEXMAP_BTN_PRESSED, toggleView);
			
		}
		public function toggleView(e:GuiControlEvent):void  {
			view.toggleView();
		}
		
	}
}