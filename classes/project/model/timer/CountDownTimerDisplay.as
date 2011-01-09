/**
 * classes.project.model.timer.CountDownTimerDisplay
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.timer  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class CountDownTimerDisplay extends Sprite {
		
		var _startTime:Date;
		var _timer:Timer;
		var _duration:uint;
		var _timerDisplay:MovieClip;
		var _showTenthSeconds:Boolean = true;
		var _showSeconds:Boolean = true;
		var _showMinutes:Boolean = true;
		var _showHours:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function CountDownTimerDisplay(mc:MovieClip, nDuration:uint)  {
			trace("Creating a new CountDownTimerDisplay...");
			super();
			this._timerDisplay = mc;
			//convert from seconds to milliseconds
			this._duration = nDuration * 1000;
			trace("this._duration: "+this._duration);
			this.init();
		}
		private function init():void  {
			
			addChild(this._timerDisplay);
			
			this._startTime = new Date();
			
			if(this._duration >= 360000)  {
				_showHours = true;
			}
			if(this._duration < 60000)  {
				_showMinutes = false;
			}
			if(this._duration < 1000)  {
				_showSeconds = false;
			}
			
			
			//timer
			this._timer = new Timer(50);
            this._timer.addEventListener("timer", timerHandler);
            this._timer.start();
			
			
		}
		/*
		 *	Timer methods
		 *
		 *
		 */
		public function timerHandler(event:TimerEvent):void {
            //trace("timerHandler: " + event);
			var _currentTime:Date = new Date();
            var nDiff:Number = (_currentTime.getTime() - _startTime.getTime());
			var timeLeft:Number = this._duration - nDiff;
			if(timeLeft > 0)  {
				this._timerDisplay.tf.text = this.formatTimerTime(timeLeft);
			} else  {
				this._timerDisplay.tf.text = "Time-up!";
				this.timerComplete();
			}
			
        }
		private function formatTimerTime(time:Number):String  {
			//figure out the time components
			var tenthSeconds:Number = Math.floor(time/10);
			if(tenthSeconds >= 10)  {
				var multTS:Number = Math.floor(tenthSeconds/10);
				tenthSeconds -= (multTS*10);
			}
			var seconds:Number = Math.floor(time/1000);
			if(seconds >= 60)  {
				var multS:Number = Math.floor(seconds/60);
				seconds -= multS*60;
			}
			var minutes:Number = Math.floor(time/1000/60);
			if(minutes >= 60)  {
				var multM:Number = Math.floor(minutes/60);
				minutes -= multM*60;
			}
			var hours:Number = Math.floor(time/1000/60/60);
			if(hours >= 24)  {
				var multH:Number = Math.floor(hours/24);
				hours -= multH*24;
			}
			//build the timer string
			var timer:String = "";
			if(_showHours)  {
				if(hours < 10)  {
					timer += "0"+ hours + ":";
				} else  {
					timer += hours + ":";
				}
			}
			if(_showHours || _showMinutes)  {
				if(minutes < 10)  {
					timer += "0"+ minutes + ":";
				} else  {
					timer += minutes + ":";
				}
			}
			if(_showHours || _showMinutes || _showSeconds)  {
				if(seconds < 10)  {
					timer += "0"+ seconds;
				} else  {
					timer += seconds;
				}
			}
			if(_showTenthSeconds)  {
				timer += "." + tenthSeconds;
			}
			return timer;
		}
		
		private function timerComplete():void  {
			this._timer.stop();
			
			//TODO: add timer complete event
		}
		
		public function disableTenthSeconds():void  {
			_showTenthSeconds = false;
		}
		public function enableTenthSeconds():void  {
			_showTenthSeconds = true;
		}
		
		//start the timer over
		public function restart():void  {
			this._timer.stop();
			this._startTime = new Date();
			this._timer.start();
		}
		//change the timer duration and start over
		public function reset(nDuration:uint):void  {
			this._duration = nDuration * 1000;
			this.restart();
		}
		
		
		
		
	}
}