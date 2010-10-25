/**
 * classes.project.model.popups.TwoButtonPopup
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.popups  {
	
	import classes.project.core.LibFactory;
	import classes.project.events.PopupEvent;
	import classes.project.model.popups.BasePopup;
	import classes.project.model.controls.PopupControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class TwoButtonPopup extends BasePopup  {
		
		private var _confirm_btn:PopupControl;
		private var _fCancel:Function;
		private var _fConfirm:Function;
		
		public function TwoButtonPopup(sId:String, mc:MovieClip)  {
			super(sId, mc);
			trace("Creating new TwoButtonPopup -- " + this);
		}
		private function initControls():void  {
			trace("TwoButtonPopup initControls()");
			this._close_btn = new PopupControl("popup_close_btn", LibFactory.createMovieClip("PopupControl_BTN"));
			this._close_btn.setReleaseEvent(PopupEvent.POPUP_CLOSED);
			this._close_btn.disableTooltip();
			
			this._clip.mcPopup.addChild(this._close_btn);
			
			var nX:Number = this._clip.mcPopup.width/2 - this._close_btn.width - 10;
			this._close_btn.x = nX;
			nX += 20 + this._close_btn.width;
			
			this._confirm_btn = new PopupControl("popup_add_btn", LibFactory.createMovieClip("PopupControl_BTN"));
			this._confirm_btn.setReleaseEvent(PopupEvent.TWO_BUTTON_POPUP_CONFIRMED);
			this._confirm_btn.disableTooltip();
			this._confirm_btn.x = nX;
			this._clip.mcPopup.addChild(this._confirm_btn);
		}
		/*
		 *	Overrides
		 *
		 */
		override public function init():void  {
			//trace("TwoButtonPopup initializing...");
			this.addChild(this._clip);
			this.hide();
			initControls();
			
		}
		override public function setText(sText:String):void  {
			var nPadding:Number = this._clip.mcPopup.mcText.y;
			this._clip.mcPopup.mcText.tf.htmlText = sText;
			this._clip.mcPopup.mcText.tf.autoSize = TextFieldAutoSize.CENTER;
			this._clip.mcPopup.mcBg.height = this._clip.mcPopup.mcText.y + this._clip.mcPopup.mcText.height + nPadding*4 + this._close_btn.height;
			this._clip.mcPopup.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
			this._close_btn.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
			this._confirm_btn.y = this._close_btn.y;
		}
		public function setLabels(sText0:String, sText1:String):void  {
			this._close_btn.setText(sText0);
			this._confirm_btn.setText(sText1);
		}
		
		
		
	}
}