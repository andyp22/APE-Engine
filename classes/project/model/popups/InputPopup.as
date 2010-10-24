/**
 * classes.project.model.popups.InputPopup
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.popups  {
	
	import classes.project.core.LibFactory;
	import classes.project.events.PopupEvent;
	import classes.project.events.InputPopupEvent;
	import classes.project.model.popups.BasePopup;
	import classes.project.model.controls.PopupControl;
	import classes.project.model.controls.InputPopupControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class InputPopup extends BasePopup  {
		
		private var _add_btn:InputPopupControl;
		
		public function InputPopup(sId:String, mc:MovieClip)  {
			super(sId, mc);
			trace("Creating new InputPopup -- " + this);
		}
		private function initControls():void  {
			trace("InputPopup initControls()");
			this._close_btn = new PopupControl("popup_close_btn", LibFactory.createMovieClip("PopupControl_BTN"));
			this._close_btn.setReleaseEvent(PopupEvent.POPUP_CLOSED);
			this._close_btn.disableTooltip();
			
			this._clip.mcPopup.addChild(this._close_btn);
			
			var nX:Number = this._clip.mcPopup.width/2 - this._close_btn.width - 10;
			this._close_btn.x = nX;
			nX += 20 + this._close_btn.width;
			
			this._add_btn = new InputPopupControl("popup_add_btn", LibFactory.createMovieClip("PopupControl_BTN"));
			this._add_btn.setReleaseEvent(InputPopupEvent.INPUT_POPUP_CLOSED);
			this._add_btn.disableTooltip();
			this._add_btn.x = nX;
			this._clip.mcPopup.addChild(this._add_btn);
		}
		/*
		 *	Overrides
		 *
		 */
		override public function init():void  {
			//trace("InputPopup initializing...");
			this.addChild(this._clip);
			this.hide();
			initControls();
			
		}
		override public function setText(sText:String):void  {
			var nPadding:Number = this._clip.mcPopup.mcText.y;
			this._clip.mcPopup.mcText.tf.htmlText = sText;
			this._clip.mcPopup.mcText.tf.autoSize = TextFieldAutoSize.CENTER;
			this._clip.mcPopup.mcInput.y = this._clip.mcPopup.mcText.tf.y + this._clip.mcPopup.mcText.tf.height + nPadding*2;
			this._clip.mcPopup.mcBg.height = this._clip.mcPopup.mcInput.y + this._clip.mcPopup.mcInput.height + nPadding*4 + this._close_btn.height;
			this._clip.mcPopup.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
			this._close_btn.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
			this._add_btn.y = this._close_btn.y;
		}
		public function setLabels(sText0:String, sText1:String):void  {
			this._close_btn.setText(sText0);
			this._add_btn.setText(sText1);
		}
		
		
		
	}
}