/**
 * classes.project.views.components.TimerPanelView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components  {
	
	import classes.project.core.LibFactory;
	import classes.project.events.GuiControlEvent;
	import classes.project.model.ContainerPanel;
	import classes.project.model.timer.CountDownTimer;
	import classes.project.model.timer.GameClock;
	import classes.project.model.timer.GameTimer;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class TimerPanelView extends ContainerPanel  {
		
		public function TimerPanelView(sName:String, mc:MovieClip)  {
			trace("Creating new TimerPanelView -- " + this + " : " + sName);
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			trace("TimerPanelView initializing...");
			addChild(this.mcContent);
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			var nY:Number = 0;
			/*
			 *	Timer
			 */
			[Inject] var timer:GameTimer = new GameTimer(LibFactory.createMovieClip("TimerDisplay"));
			this.mcContent.addChild(timer);
			nY += timer.height;
			/*
			 *	Count Down Timers
			 */
			[Inject] var cdTimer:CountDownTimer = new CountDownTimer(LibFactory.createMovieClip("TimerDisplay"), 30);
			cdTimer.y = nY;
			this.mcContent.addChild(cdTimer);
			nY += cdTimer.height;
			
			[Inject] var cdTimer1:CountDownTimer = new CountDownTimer(LibFactory.createMovieClip("TimerDisplay"), 80);
			cdTimer1.y = nY;
			this.mcContent.addChild(cdTimer1);
			nY += cdTimer1.height;
			
			[Inject] var cdTimer2:CountDownTimer = new CountDownTimer(LibFactory.createMovieClip("TimerDisplay"), 3700);
			cdTimer2.y = nY;
			cdTimer2.disableTenthSeconds();
			this.mcContent.addChild(cdTimer2);
			nY += cdTimer2.height;
			/*
			 *	Clock
			 */
			[Inject] var clock:GameClock = new GameClock(LibFactory.createMovieClip("TimerDisplay"));
			clock.y = nY;
			this.mcContent.addChild(clock);
			
			
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
			this.mcHeader.tf.width
		}
		
		
	}
}