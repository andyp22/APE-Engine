/**
 * classes.project.model.timer.CountDownTimer
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model.timer  {
	
	import classes.project.core.Server;
	import classes.project.events.CountDownTimerEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class CountDownTimer  {
		
		protected var _startTime:Date;
		protected var _timer:Timer;
		protected var _duration:uint;
		protected var _releaseEvent:String;
		/**
		 * Constructor
		 */
		public function CountDownTimer(nSeconds:uint, sCompletionEvent:String = "COUNTDOWN_TIMER_COMPLETE")  {
			//trace("Creating a new CountDownTimer...");
			//convert from seconds to milliseconds
			this._duration = nSeconds * 1000;
			this._releaseEvent = sCompletionEvent;
			this.init();
		}
		private function init():void  {
			this._startTime = new Date();
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
			if(timeLeft <= 0)  {
				this.timerComplete();
			}
			
        }
		private function timerComplete():void  {
			this._timer.stop();
			[Inject] Server.dispatch(new CountDownTimerEvent(this._releaseEvent));
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
		public function stop():void  {
			this._timer.stop();
		}
	}
}