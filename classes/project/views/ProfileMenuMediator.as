/**
 * classes.project.views.ProfileMenuMediator
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views {
	
	import classes.project.core.Labels;
	import classes.project.core.LibFactory;
	import classes.project.events.GuiControlEvent;
	import classes.project.events.InputPopupEvent;
	import classes.project.events.PopupEvent;
	import classes.project.events.TabControlEvent;
	import classes.project.model.popups.*;
	import classes.project.views.components.ProfileMenuView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ProfileMenuMediator extends Mediator  {
		
		[Inject] public var view:ProfileMenuView;
		
		private var _currentPopup:IPopup;
		
		public function ProfileMenuMediator()  {
			trace("Creating ProfileMenuMediator...");
			// avoid doing work here
			// mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister() : void  {
			trace("ProfileMenuMediator registered.");
			
			eventMap.mapListener(eventDispatcher, GuiControlEvent.CREATE_PLAYER_BTN_PRESSED, onCreatePlayer);
			eventMap.mapListener(eventDispatcher, GuiControlEvent.DELETE_PLAYER_BTN_PRESSED, onDeletePlayer);
			eventMap.mapListener(eventDispatcher, GuiControlEvent.LOAD_PLAYER_BTN_PRESSED, onLoadPlayer);
			eventMap.mapListener(eventDispatcher, InputPopupEvent.INPUT_POPUP_CLOSED, onInputPopupClosed);
			eventMap.mapListener(eventDispatcher, PopupEvent.POPUP_CLOSED, onPopupClosed);
			eventMap.mapListener(eventDispatcher, TabControlEvent.TAB_CONTROL_PRESSED, toggleTab);
		}
		
		private function toggleTab(e:TabControlEvent):void  {
			trace("toggleTab()"+ e._tab.getName());
			view.update(e._tab.getName());
		}
		
		private function onCreatePlayer(e:GuiControlEvent):void  {
			trace("ProfileMenuMediator onCreatePlayer()");
			//determine current number of active profiles
			var nCount:Number = 0;
			for(var i = 0; i < view.getPlayerProfiles().length; i++)  {
				if(view.getPlayerProfiles()[i].tf.text != null && view.getPlayerProfiles()[i].tf.text != "")  {
					nCount++;
				}
			}
			if(nCount < 5)  {
				//show popup with input text field requesting name for the profile
				//need two button popup with input text field
				var inputPopup:InputPopup = new InputPopup("player_input_popup", LibFactory.createMovieClip("InputPopup_MC"));
				inputPopup.init();
				inputPopup.setText(Labels.getLabel("createPlayerNameTxt"));
				inputPopup.setLabels(Labels.getLabel("popup_cancel"), Labels.getLabel("popup_add"));
				inputPopup.initBlocker(view.stage.stageWidth, view.stage.stageHeight);
				inputPopup.positionPopup();
				inputPopup.show();
				_currentPopup = inputPopup;
				view.addChild(inputPopup);
			} else  {
				//show popup telling player they must delete a profile before being able to create any more
				var popup:BasePopup = new BasePopup("player_feedback_popup", LibFactory.createMovieClip("FeedbackPopup_MC"));
				popup.init();
				popup.setText(Labels.getLabel("createPlayerMaximumTxt"));
				popup.setLabel(Labels.getLabel("popup_close"));
				popup.initBlocker(view.stage.stageWidth, view.stage.stageHeight);
				popup.positionPopup();
				popup.show();
				_currentPopup = popup;
				view.addChild(popup);
			}
				
				
			
		}
		private function onPopupClosed(e:PopupEvent):void  {
			this._currentPopup.hide();
			view.removeChild(Sprite(this._currentPopup));
		}
		private function onInputPopupClosed(e:InputPopupEvent):void  {
			this._currentPopup.hide();
			
			trace("Input: "+e.inputText);
			view.addPlayer(e.inputText);
			
			
			view.removeChild(Sprite(this._currentPopup));
		}
		private function onDeletePlayer(e:GuiControlEvent):void  {
			trace("ProfileMenuMediator onDeletePlayer()");
			//show popup with confirm and cancel buttons requesting confirmation that player is sure they want to delete character
			
			//if confirmed, delete character
			
			//if cancelled, close popup and do nothing
			
		}
		private function onLoadPlayer(e:GuiControlEvent):void  {
			trace("ProfileMenuMediator onLoadPlayer()");
			//if a player is selected, load the profile info into the info panel
			//if a player is selected, enable the character overlay
			
		}
		
		
	}
}