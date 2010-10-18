/**
 * classes.project.model.timer.GameTimer
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.timer  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class GameTimer extends Sprite {
		
		var _startTime:Date;
		var _timerDisplay:MovieClip;
		var _showTenthSeconds:Boolean = true;
		
		/**
		 * Constructor
		 */
		public function GameTimer(mc:MovieClip)  {
			trace("Creating a new GameTimer...");
			super();
			this._timerDisplay = mc;
			this.init();
		}
		private function init():void  {
			
			addChild(this._timerDisplay);
			
			this._startTime = new Date();
			//timer
			var myTimer:Timer;
			if(_showTenthSeconds)  {
				myTimer = new Timer(50);
			} else  {
				myTimer = new Timer(500);
			}
            myTimer.addEventListener("timer", timerHandler);
            myTimer.start();
			
			
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
			this._timerDisplay.tf.text = this.formatTimerTime(nDiff);
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
			var days:Number = Math.floor(time/1000/60/60/24);
			//build the timer string
			var timer:String = "";
			if(days > 0)  {
				timer += days + " days, ";
			}
			if(hours < 10)  {
				timer += "0"+ hours + ":";
			} else  {
				timer += hours + ":";
			}
			if(minutes < 10)  {
				timer += "0"+ minutes + ":";
			} else  {
				timer += minutes + ":";
			}
			if(seconds < 10)  {
				timer += "0"+ seconds;
			} else  {
				timer += seconds;
			}
			if(_showTenthSeconds)  {
				timer += "." + tenthSeconds;
			}
			return timer;
		}
		
		
		
	}
}