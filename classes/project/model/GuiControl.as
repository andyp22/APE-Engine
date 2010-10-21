/**
 * classes.project.model.GuiControl
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model {
	
	import classes.project.core.Labels;
	import classes.project.core.Server;
	import classes.project.events.GuiControlEvent;
	import classes.project.model.Tooltips;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class GuiControl extends Sprite {
		
		protected var _releaseEvent:String;
		
		protected var sName:String;
		protected var sText:String;
		
		protected var bEnabled:Boolean;
		protected var bAutosize:Boolean;
		protected var _bTooltip:Boolean;
		
		protected var mcButton:MovieClip;
		protected var mcText:MovieClip;
		protected var mcBg:MovieClip;
		
		/**
		 * Constructor
		 */
		public function GuiControl(sName:String, mc:MovieClip, bAutosize:Boolean = true)  {
			super();
			//trace("Creating new GuiControl -- " + this + " : " + sName);
			
			this.sName = sName;
			this.mcButton = mc;
			this.mcText = this.mcButton.mcText;
			this.mcBg = this.mcButton.mcBg;
			this.bEnabled = true;
			this.bAutosize = bAutosize;
			this._bTooltip = true;
			
			this._releaseEvent = GuiControlEvent.GUICONTROL_PRESSED;
			
			this.init();
		}
		
		private function init():void  {
			this.mouseChildren = false;
			this.buttonMode = true;
			//set up the mouse events
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.handlePress);
			this.addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
			this.addEventListener(MouseEvent.MOUSE_UP, this.handleRelease);
			
			this.setText(Labels.getLabel(this.sName));
			
			this.mcBg.gotoAndPlay("_up");
			addChild(this.mcButton);
		}
		
		protected function handlePress(e:MouseEvent):void  {
			if(this.bEnabled)  {
				this.mcBg.gotoAndPlay("_down");
			}
		}
		protected function handleRollOver(e:MouseEvent):void  {
			if(this.bEnabled)  {
				this.mcBg.gotoAndPlay("_over");
				if(this._bTooltip)  {
					[Inject] Tooltips.create(e);
				}
			}
		}
		protected function handleRollOut(e:MouseEvent):void  {
			if(this.bEnabled)  {
				this.mcBg.gotoAndPlay("_out");
				if(this._bTooltip)  {
					[Inject] Tooltips.destroy();
				}
			}
		}
		protected function handleRelease(e:MouseEvent):void  {
			if(this.bEnabled)  {
				trace("handleRelease -- "+ this + " : " + this.sName);
				this.mcBg.gotoAndPlay("_overNoOut");
				[Inject] Server.dispatch(new GuiControlEvent(this._releaseEvent));
			}
		}
		
		public function setText(sText:String):void  {
			var nPadding:int = this.mcText.x - this.mcBg.x;
			this.sText = sText;
			this.mcText.tf.text = this.sText;
			if(this.bAutosize)  {
				//resize the button based on text length
				this.mcText.tf.autoSize = TextFieldAutoSize.CENTER;
				this.mcBg.height = this.mcText.tf.height + nPadding;
			}
		}
		public function enable():void  {
			this.bEnabled = true;
			this.useHandCursor = true;
			this.mcBg.gotoAndPlay("_up");
		}
		public function disable():void  {
			this.bEnabled = false;
			this.useHandCursor = false;
			this.mcBg.gotoAndPlay("_disabled");
			if(this._bTooltip)  {
				[Inject] Tooltips.destroy();
			}
		}
		
		public function getName():String  {
			return this.sName;
		}
		public function getTooltipText():String  {
			return this.sText;
		}
		
		public function setReleaseEvent(sEvent:String):void  {
			_releaseEvent = sEvent;
		}
		
		public function disableTooltip():void  {
			this._bTooltip = false;
		}
		
		
	}
}