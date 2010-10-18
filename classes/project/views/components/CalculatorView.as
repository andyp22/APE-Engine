/**
 * classes.project.views.components.CalculatorView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components {
	import classes.project.core.LibFactory;
	import classes.project.model.*;
	import classes.project.views.components.parts.CalcButton;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
	
	
	/**
	 * CalculatorView
	 */
	public class CalculatorView extends ContainerPanel {
		
		private var _display_txt:TextField;
		private var _buttons:Array;
		private var _nPadding:int;
		private var _nMaxChars:int;
		private var _nTrim:Number;
		private var _bTrim:Boolean;
		//TODO: Change this to pull in text from xml
		private var DIV_ERROR:String = "Div by ZERO!";
		
		private var equalPressed:Boolean = false;
		
		// button convenience vars
		private var btn0:Sprite;
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var btn5:Sprite;
		private var btn6:Sprite;
		private var btn7:Sprite;
		private var btn8:Sprite;
		private var btn9:Sprite;
		private var btnDecimal:Sprite;
		private var btnClear:Sprite;
		private var btnAdd:Sprite;
		private var btnSubtract:Sprite;
		private var btnMulitply:Sprite;
		private var btnDivide:Sprite;
		private var btnEquals:Sprite;
		
		private var hasDecimal:Boolean = false;
		private var sFirstNumber:String = "";
		private var sSecondNumber:String = "";
		private var sLastEntered:String = "";
		private var sAnswer:String = "";
		private var sOperator:String = "";
		private var bOperatorPressed = false;
		private var bEqualPressed = false;
		
		public function CalculatorView(sName:String, mc:MovieClip) {
			trace("Creating new CalculatorView -- " + this + " : " + sName);
			super(sName, mc);
			
			this._buttons = new Array("C","/","*","7","8","9","-","4","5","6","+","1","2","3","=","0",".");
			this._nPadding = 7;
			this._nMaxChars = 14;
			this._nTrim = 4;
			this._bTrim = true;
			
			//this.init();
		}
		public function init():void  {
			this.visible = false;
			this.initDisplayField();
			this.createButtons();
			this.assignButtons();
			this.initButtonEvents();
			
		}
		override public function createContentContainer(mc:DisplayObject):void  {
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			addChild(this.mcContent);
		}
		override public function sizeToContents():void  {
			var nPadding:int = this.mcContent.x;
			var newWidth:int = this.mcContent.width + nPadding*2;
			var newHeight:int = this.mcHeader.height + this.mcContent.height + nPadding*2;
			var widthDiff:int = this.mcPanel.mcBg.width - newWidth;
			
			this.mcPanel.mcBg.width = this.mcHeader.mcBg.width = newWidth;
			this.mcPanel.mcBg.height = newHeight;
			this.mcClose.x -= widthDiff;
		}
		
		
		private function initDisplayField():void  {
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0x000000;
            format.size = 16;
			
			this._display_txt = new TextField();
			this._display_txt.defaultTextFormat = format;
			this._display_txt.autoSize = TextFieldAutoSize.RIGHT;
			this._display_txt.text = "0";
			this._display_txt.selectable = false;
			this._display_txt.multiline = false;
			this._display_txt.wordWrap = false;
			this._display_txt.condenseWhite = true;
			
			var nX:int = this.mcContent.mcDisplay.x + this.mcContent.x + 5;
			var nY:int = this.mcContent.mcDisplay.y + this.mcContent.y + 5;
			var nWidth:int = this.mcContent.mcDisplay.width - 6;
			var nHeight:int = this.mcContent.mcDisplay.height - 6;
			this._display_txt.x = nX;
			this._display_txt.y = nY;
			this._display_txt.width = nWidth;
			this._display_txt.height = nHeight;
			
			this.addChild(this._display_txt);
		}
		private function createButtons():void  {
			var nRow:int = 0;
			var nCol:int = 0;
			var nRows:int = 5;
			var nCols:int = 4;
			var ROWSTART:int = this.mcContent.mcDisplay.x + this.mcContent.x;
			var nX:int = ROWSTART;
			var nY:int = this.mcContent.mcDisplay.y + this.mcContent.mcDisplay.height + this.mcContent.y + this._nPadding;
			
			var aTemp:Array = new Array();
			
			for(var i:int = 0; i < this._buttons.length; i++)  {
				[Inject] var btn:SimpleButton = LibFactory.createSimpleButton("calcNumButton");
				var nHeight:int = btn.height;
				var nWidth:int = btn.width;
				var label:String = this._buttons[i];
				if(label == "=")  {
					[Inject] btn = LibFactory.createSimpleButton("calcNumButtonTall");
				} else if(label == "0")  {
					[Inject] btn = LibFactory.createSimpleButton("calcNumButtonWide");
				}
				var button:CalcButton = new CalcButton(btn, label);
				button.x = nX;
				button.y = nY;
				addChild(button);
				
				nCol++;
				nX += nWidth + this._nPadding;
				
				if(nCol >= nCols)  {
					nCol = 0;
					nX = ROWSTART;
					nRow++;
					nY += nHeight + this._nPadding;
				}
				if(label == "C")  {
					nCol++;
					nX += nWidth + this._nPadding;
				}
				if(label == "0")  {
					nCol++;
					nX += nWidth + this._nPadding;
				}
				
				aTemp[label] = button;
			}
			this._buttons = aTemp;
		}
		private function assignButtons():void  {
			this.btn0 = this._buttons["0"];
			this.btn1 = this._buttons["1"];
			this.btn2 = this._buttons["2"];
			this.btn3 = this._buttons["3"];
			this.btn4 = this._buttons["4"];
			this.btn5 = this._buttons["5"];
			this.btn6 = this._buttons["6"];
			this.btn7 = this._buttons["7"];
			this.btn8 = this._buttons["8"];
			this.btn9 = this._buttons["9"];
			this.btnDecimal = this._buttons["."];
			this.btnClear = this._buttons["C"];
			this.btnAdd = this._buttons["+"];
			this.btnSubtract = this._buttons["-"];
			this.btnMulitply = this._buttons["*"];
			this.btnDivide = this._buttons["/"];
			this.btnEquals = this._buttons["="];
		}
		private function initButtonEvents():void  {
			
			this.btnClear.addEventListener(MouseEvent.CLICK, clearClickHandler, false, 0, true);
			this.btnAdd.addEventListener(MouseEvent.CLICK, addClickHandler, false, 0, true);
			this.btnSubtract.addEventListener(MouseEvent.CLICK, subtractClickHandler, false, 0, true);
			this.btnMulitply.addEventListener(MouseEvent.CLICK, multiplyClickHandler, false, 0, true);
			this.btnDivide.addEventListener(MouseEvent.CLICK, divideClickHandler, false, 0, true);
			this.btnEquals.addEventListener(MouseEvent.CLICK, equalsClickHandler, false, 0, true);
			
			this.btn0.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn1.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn2.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn3.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn4.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn5.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn6.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn7.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn8.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btn9.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			this.btnDecimal.addEventListener(MouseEvent.CLICK, numberClickHandler, false, 0, true);
			
			/*
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
			this.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true);
			*/
		}
		public function numberClickHandler(e:MouseEvent):void  {
			//trace("numberClickHandler() -- " + e.target.getLabel());
			if(this.bOperatorPressed)  {
				this.resetDisplay();
				this.bOperatorPressed = false;
			}
			if(this.bEqualPressed)  {
				this.resetDisplay();
				this.bEqualPressed = false;
			}
			updateDisplay(e.target.getLabel());
		}
		public function clearClickHandler(e:MouseEvent):void  {
			//trace("clearClickHandler()");
			if(this.bEqualPressed)  {
				this.resetCalc();
			} else  {
				this.resetDisplay();
			}
		}
		public function clearAllClickHandler(e:MouseEvent):void  {
			//trace("clearAllClickHandler()");
			this.resetCalc();
		}
		public function addClickHandler(e:MouseEvent):void  {
			//trace("addClickHandler()");
			this.handleClick();
			this.sOperator = "ADD";
		}
		public function subtractClickHandler(e:MouseEvent):void  {
			//trace("subtractClickHandler()");
			this.handleClick();
			this.sOperator = "SUBTRACT";
		}
		public function multiplyClickHandler(e:MouseEvent):void  {
			//trace("multiplyClickHandler()");
			this.handleClick();
			this.sOperator = "MULTIPLY";
		}
		public function divideClickHandler(e:MouseEvent):void  {
			//trace("divideClickHandler()");
			this.handleClick();
			this.sOperator = "DIVIDE";
		}
		public function equalsClickHandler(e:MouseEvent):void  {
			//trace("equalsClickHandler()");
			this.doEqual();
			this.bEqualPressed = true;
			this.sFirstNumber = this.sAnswer;
		}
		private function handleClick():void  {
			this.bOperatorPressed = true;
			if(this.bEqualPressed)  {
				//trace("bEqualPressed");
				this.resetDisplay();
				this.bEqualPressed = false;
			} else {
				if(this.sFirstNumber == "")  {
					//trace("first");
					this.sFirstNumber = this._display_txt.text;
				} else if(this.sFirstNumber != "")  {
					//trace("second");
					this.doEqual();
					this.sFirstNumber = this.sAnswer;
				}
			}
		}
		public function resetCalc():void  {
			this.resetState();
			this.resetDisplay();
		}
		private function resetDisplay():void  {
			//trace("resetDisplay()");
			this._display_txt.text = "0";
		}
		private function resetState():void  {
			//trace("resetState()");
			this.sFirstNumber = "";
			this.sSecondNumber = "";
			this.sLastEntered = "";
			this.sAnswer = "";
			this.sOperator = "";
			this.hasDecimal = false;
			this.bOperatorPressed = false;
			this.bEqualPressed = false;
		}
		private function doAdd():void  {
			//trace("doAdd()");
			var nA:Number = Number(this.sFirstNumber);
			var nB:Number = Number(this.sSecondNumber);
			var nC:Number = 0;
			nC = nA + nB;
			this.sAnswer = String(nC);
		}
		private function doSubtract():void  {
			//trace("doSubtract()");
			var nA:Number = Number(this.sFirstNumber);
			var nB:Number = Number(this.sSecondNumber);
			var nC:Number = 0;
			nC = nA - nB;
			this.sAnswer = String(nC);
		}
		private function doMultiply():void  {
			//trace("doMultiply()");
			var nA:Number = Number(this.sFirstNumber);
			var nB:Number = Number(this.sSecondNumber);
			var nC:Number = 0;
			nC = nA * nB;
			this.sAnswer = String(nC);
		}
		private function doDivide():void  {
			//trace("doDivide()");
			var nA:Number = Number(this.sFirstNumber);
			var nB:Number = Number(this.sSecondNumber);
			var nC:Number = 0;
			
			if(nB != 0)  {
				nC = nA / nB;
				this.sAnswer = String(nC);
			} else  {
				this.sAnswer = DIV_ERROR;
			}
			
			
		}
		private function doEqual():void  {
			//trace("doEqual() -- " + this.sOperator);
			if(!this.bEqualPressed)  {
				this.sSecondNumber = this._display_txt.text;
			} else  {
				this.sSecondNumber = this.sLastEntered;
			}
			
			switch(this.sOperator)  {
				case "ADD":
					this.doAdd();
					break;
				case "SUBTRACT":
					this.doSubtract();
					break;
				case "MULTIPLY":
					this.doMultiply();
					break;
				case "DIVIDE":
					this.doDivide();
					break;
			}
			this.showResult();
			this.sLastEntered = this.sSecondNumber;
		}
		private function showResult():void  {
			//trace("showResult()");
			if(this._bTrim)  {
				var nMultNum:Number = Math.pow(10, this._nTrim);
				var sHolder:String = this.sAnswer;
				sHolder = String((Math.round(Number(sHolder) * nMultNum) / nMultNum));
				this.sAnswer = sHolder;
			}
			var sDisplay:String = this.sAnswer;
			if(this.sAnswer.length > this._nMaxChars)  {
				sDisplay = this.toScientific();
			}
			this._display_txt.text = sDisplay;
		}
		private function updateDisplay(sChar:String):void  {
			var bDecimal = false;
			if(sChar == ".")  {
				bDecimal = true;
			}
			if(this.hasDecimal && bDecimal)  {
				// do nothing
			} else if(this._display_txt.length < this._nMaxChars)  {
				if(sChar == ".")  {
					this.hasDecimal = true;
				}
				if(this._display_txt.text == "0" && sChar != ".")  {
					this._display_txt.text = sChar;
				} else  {
					this._display_txt.appendText(sChar);
				}
			}
		}
		//convert any number to scientific notation with specified significant digits
		//e.g. .012345 -> 1.2345e-2 -- but 6.34e0 is displayed "6.34"
		private function toScientific() {
			//deal with messy input values
			var nNum:Number = Number(this.sAnswer);
			if (isNaN(nNum)) return this.sAnswer; //garbage in, NaN out
			//find exponent using logarithm
			//e.g. log10(150) = 2.18 -- round down to 2 using floor()
			var exponent:Number = Math.floor(Math.log(Math.abs(nNum)) / Math.LN10); 
			if (nNum == 0) exponent = 0; //handle glitch if the number is zero
			//find mantissa (e.g. "3.47" is mantissa of 3470; need to divide by 1000)
			var tenToPower:Number = Math.pow(10, exponent);
			var nMantissa:Number = nNum / tenToPower;
			//force significant digits in mantissa
			//e.g. 3 sig digs: 5 -> 5.00, 7.1 -> 7.10, 4.2791 -> 4.28
			var nMultNum:Number = Math.pow(10, this._nTrim);
			nMantissa = (Math.round(nMantissa * nMultNum) / nMultNum);
			var sOutput:String = String(nMantissa);
			//if exponent is zero, don't include e
			if(exponent != 0) {
					sOutput += "e" + String(exponent);
			}
			return(sOutput);
		}
		
		
	}
}
