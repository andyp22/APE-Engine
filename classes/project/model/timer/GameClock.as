/**
 * classes.project.model.timer.GameClock
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.timer  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class GameClock extends Sprite {
		
		var _clockDisplay:MovieClip;
		var _showSeconds:Boolean = true;
		var _twentyFourHours:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function GameClock(mc:MovieClip)  {
			trace("Creating a new GameClock...");
			super();
			this._clockDisplay = mc;
			this.init();
		}
		private function init():void  {
			
			addChild(this._clockDisplay);
			
			//timer
			var myClock:Timer;
			if(_showSeconds)  {
				myClock = new Timer(500);
			} else  {
				myClock = new Timer(1000);
				this.clockHandler(null);
			}
			myClock.addEventListener("timer", clockHandler);
            myClock.start();
			
			
		}
		/*
		 *	Clock methods
		 *
		 *
		 */
		public function clockHandler(event:TimerEvent):void {
            //trace("clockHandler: " + event);
			var _currentTime:Date = new Date();
            this._clockDisplay.tf.text = this.formatClockTime(_currentTime);
        }
		private function formatClockTime(time:Date):String  {
			//get the time components
			var seconds:Number = time.getSeconds();
			var minutes:Number = time.getMinutes();
			var hours:Number = time.getHours();
			
			//build the display string
			var clock:String = "";
			var postFix:String = " AM";
			if(hours > 12 && !_twentyFourHours)  {
				hours -= 12;
				postFix = " PM";
			}
			if(hours < 10)  {
				clock += "0"+ hours + ":";
			} else  {
				clock += hours + ":";
			}
			if(minutes < 10)  {
				clock += "0"+ minutes;
			} else  {
				clock += minutes;
			}
			if(_showSeconds)  {
				if(seconds < 10)  {
					clock += ":0"+ seconds;
				} else  {
					clock += ":" + seconds;
				}
			}
			if(!_twentyFourHours)  {
				clock += postFix;
			}
			return clock;
		}
		
		
		
	}
}