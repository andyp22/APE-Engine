/**
 * classes.project.views.components.parts.CalcButton
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components.parts  {
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
	
	public class CalcButton extends Sprite  {
		
		private var _button:SimpleButton;
		private var _label:TextField;
		private var _label_txt:String;
		
		public function CalcButton(btn:SimpleButton, id:String)  {
			//trace("Creating new CalcButton("+btn+", "+id+")");
			this._button = btn;
			this._label_txt = id;
			
			initButton();
			initLabel();
		}
		private function initLabel():void  {
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0x000000;
            format.size = 18;
			
			this._label = new TextField();
			this._label.defaultTextFormat = format;
			this._label.autoSize = TextFieldAutoSize.LEFT;
			this._label.text = this._label_txt;
			this._label.selectable = false;
			this._label.multiline = false;
			this._label.wordWrap = false;
			this._label.condenseWhite = true;
			
			var nX:int = (this._button.width/2) - (this._label.width/2);
			var nY:int = (this._button.height/2) - (this._label.height/2);
			this._label.x = nX;
			this._label.y = nY;
			
			this.addChild(this._label);
		}
		private function initButton():void  {
			this.buttonMode = true;
			this.mouseChildren = false;
			addChild(this._button);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
		}
		public function mouseOverHandler(e:MouseEvent):void  {
			//trace("mouseOverHandler -- " + this);
		}
		public function mouseOutHandler(e:MouseEvent):void  {
			//trace("mouseOutHandler -- " + this);
		}
		public function mouseDownHandler(e:MouseEvent):void  {
			//trace("mouseDownHandler -- " + this);
		}
		public function mouseUpHandler(e:MouseEvent):void  {
			//trace("mouseUpHandler -- " + this);
		}
		
		public function getLabel():String  {
			return this._label_txt;
		}
		
	}
}