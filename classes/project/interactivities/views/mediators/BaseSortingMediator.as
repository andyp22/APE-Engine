/**
 * classes.project.interactivities.views.mediators.BaseSortingMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.interactivities.views.mediators {
	
	import classes.project.core.LibFactory;
	import classes.project.events.GuiControlEvent;
	import classes.project.interactivities.Interactivity;
	import classes.project.interactivities.events.DragAndDropEvent;
	import classes.project.interactivities.events.InteractivityEvent;
	import classes.project.interactivities.events.PopupEvent;
	import classes.project.interactivities.models.components.BasePopup;
	import classes.project.interactivities.models.evaluation.BaseEvaluation;
	import classes.project.interactivities.models.evaluation.IEvaluation;
	import classes.project.interactivities.views.displays.BaseSortingView;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BaseSortingMediator extends Mediator {
		
		[Inject] public var view:BaseSortingView;
		
		private var _evaluation:BaseEvaluation;
		private var _nTries:uint = 3;
		private var _currentTry:uint = 0;
		
		private var _popup:BasePopup;
		
		public function BaseSortingMediator()  {
			trace("Creating BaseSortingMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void  {
			trace("BaseSortingMediator registered.");
			
			eventMap.mapListener(eventDispatcher, InteractivityEvent.ACTIVITY_CREATED, onActivityCreated);
			eventMap.mapListener(eventDispatcher, InteractivityEvent.SUBMIT_PRESSED, onSubmitPressed);
			eventMap.mapListener(eventDispatcher, DragAndDropEvent.START_DRAG, onStartDrag);
			eventMap.mapListener(eventDispatcher, DragAndDropEvent.STOP_DRAG, onStopDrag);
			eventMap.mapListener(eventDispatcher, PopupEvent.POPUP_CLOSED, onClosePopup);
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.SORTING_BTN_PRESSED, toggleView);
			
			view.init();
		}
		
		public function onActivityCreated(e:InteractivityEvent):void  {
			//trace("onActivityCreated()");
			this.initEvaluator();
			this.initPopup();
			[Inject] Interactivity.dispatch(new InteractivityEvent(InteractivityEvent.ACTIVITY_STARTED));
		}
		public function onSubmitPressed(e:InteractivityEvent):void  {
			//trace("onSubmitPressed()");
			if(this._currentTry < this._nTries)  {
				this._evaluation.doEvaluation();
				this._currentTry++;
				if(this._currentTry == this._nTries || this._evaluation.allCorrect())  {
					view.lockDraggers();
				}
				if(!this._evaluation.allCorrect() && this._currentTry == this._nTries)  {
					view.showCorrect();
				}
				view.disableSubmit();
				this.startFeedback();
			} else  {
				trace("All tries used...");
				view.lockDraggers();
				view.disableSubmit();
			}
			
			
		}
		public function onStartDrag(e:DragAndDropEvent):void  {
			//trace("onStartDrag() -- " + e.dragger);
			view.setDragger(e.dragger);
		}
		public function onStopDrag(e:DragAndDropEvent):void  {
			//trace("onStopDrag() -- " + e.dragger);
			view.handleDrop();
		}
		public function onClosePopup(e:PopupEvent):void  {
			trace("onClosePopup()");
			this._popup.hide();
		}
		
		
		private function initEvaluator():void  {
			this._evaluation = new BaseEvaluation();
			this._evaluation.setupEvaluator(view.getEvaluatorArgs());
			
		}
		private function initPopup():void  {
			this._popup = new BasePopup(LibFactory.createMovieClip("FeedbackPopup_MC"), "feedback");
			this._popup.initBlocker(view.width, view.height);
			view.addChild(this._popup);
		}
		private function startFeedback():void  {
			//trace("startFeedback()");
			if(this._evaluation.allCorrect())  {
				this._popup.setLabel("Close");
				this._popup.setText("You got it correct!");
				[Inject] Interactivity.dispatch(new InteractivityEvent(InteractivityEvent.ACTIVITY_COMPLETED));
			} else  {
				if(this._currentTry == this._nTries)  {
					this._popup.setLabel("Close");
					this._popup.setText("You got it wrong!! The correct answers shoud be shown.");
					[Inject] Interactivity.dispatch(new InteractivityEvent(InteractivityEvent.ACTIVITY_COMPLETED));
				} else  {
					this._popup.setLabel("Try Again");
					this._popup.setText("You got it wrong!!");
				}
			}
			this._popup.positionPopup();
			this._popup.show();
			
		}
		
		public function toggleView(e:GuiControlEvent):void  {
			view.toggleView();
			if(!view.isShowing())  {
				view.resetView();
				_evaluation.resetEval();
				this._popup.hide();
			}
		}
		
		
	}
}