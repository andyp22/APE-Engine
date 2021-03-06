﻿/**
 * classes.project.model.popups.BasePopup
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.popups  {
	
	import classes.project.core.LibFactory;
	import classes.project.events.PopupEvent;
	import classes.project.model.popups.IPopup;
	import classes.project.model.controls.PopupControl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class BasePopup extends Sprite implements IPopup  {
		
		protected var _clip:MovieClip;
		protected var _id:String;
		protected var _close_btn:PopupControl;
		
		public function BasePopup(sId:String, mc:MovieClip)  {
			//trace("Creating new BasePopup -- " + this);
			this._clip = mc;
			this._id = sId;
			
			//this.init();
			
		}
		
		public function init():void  {
			//trace("BasePopup initializing...");
			this.initControls();
			this.addChild(this._clip);
			this.hide();
		}
		private function initControls():void  {
			this._close_btn = new PopupControl("popup_close_btn", LibFactory.createMovieClip("PopupControl_BTN"));
			this._close_btn.setReleaseEvent(PopupEvent.POPUP_CLOSED);
			this._close_btn.disableTooltip();
			this._close_btn.x = this._clip.mcPopup.width/2 - this._close_btn.width/2;
			this._clip.mcPopup.addChild(this._close_btn);
		}
		
		public function setText(sText:String):void  {
			var nPadding:Number = this._clip.mcPopup.mcText.y;
			this._clip.mcPopup.mcText.tf.htmlText = sText;
			this._clip.mcPopup.mcText.tf.autoSize = TextFieldAutoSize.CENTER;
			this._clip.mcPopup.mcBg.height = this._clip.mcPopup.mcText.tf.height + nPadding*4 + this._close_btn.height;
			this._clip.mcPopup.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
			this._close_btn.y = this._clip.mcPopup.height - (this._close_btn.height + 5);
		}
		public function setLabel(sText:String):void  {
			this._close_btn.setText(sText);
		}
		public function initBlocker(nW:uint, nH:uint):void  {
			this._clip.mcBlocker.width = nW;
			this._clip.mcBlocker.height = nH;
			//this.positionPopup();
		}
		public function positionPopup():void  {
			var nX:Number = this._clip.mcBlocker.width/2 - this._clip.mcPopup.width/2;
			var nY:Number = this._clip.mcBlocker.height/2 - this._clip.mcPopup.height/2;
			this._clip.mcPopup.x = nX;
			this._clip.mcPopup.y = nY;
		}
		public function getID():String  {
			return this._id;
		}
		public function show():void  {
			this.visible = true;
		}
		public function hide():void  {
			this.visible = false;
		}
		
		
	}
}