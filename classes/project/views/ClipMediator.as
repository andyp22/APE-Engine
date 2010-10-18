/**
 * classes.project.views.ClipMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	import classes.project.core.LibFactory;
	import classes.project.core.Navigator;
	import classes.project.core.Preloader;
	import classes.project.core.Server;
	import classes.project.core.State;
	import classes.project.events.GuiControlEvent;
	import classes.project.views.*;
	import classes.project.views.components.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ClipMediator extends Mediator {
		
		[Inject] public var view:ClipView;
		
		public function ClipMediator()  {
			trace("Creating ClipMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("ClipMediator registered.");
			
			[Inject] Navigator.setClipController(this);
			[Inject] State.nAbsoluteIndex = Navigator.getStartIndex();
			
			view.setHeader("Course Clips");
			view.createContentContainer(LibFactory.createMovieClip("ClipBackground"));
			view.sizeToContents();
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.CLIP_PANEL_BTN_PRESSED, toggleView);
			
		}
		public function toggleView(e:GuiControlEvent):void  {
			view.toggleView();
		}
		
		public function updateView():void  {
			view.update();
		}
		
		public function startSegment():void  {
			view.startSegment();
		}
		
	}
}