/**
 * classes.project.views.components.ClipView
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Navigator;
	import classes.project.core.Preloader;
	import classes.project.core.Server;
	import classes.project.core.State;
	import classes.project.core.Structure;
	import classes.project.events.GuiControlEvent;
	import classes.project.model.*;
	import classes.project.model.structure.*;
	import classes.project.views.*;
	import classes.project.views.components.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ClipView extends ContainerPanel  {
		
		[Inject] private var testControl:GuiControl;
		[Inject] private var _save_btn:GuiControl;
		
		private var _clip:MovieClip;
		
		private var _currentChapter:Chapter;
		private var _currentSection:Section;
		private var _currentClip:Clip;
		private var _currentSegment:Segment;
		
		private var _updateClip:Boolean;
		
		public function ClipView(sName:String, mc:MovieClip)  {
			trace("Creating new ClipView -- " + this + " : " + sName);
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			trace("ClipView initializing...");
			this._updateClip = false;
			addChild(this.mcContent);
			
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			update();
			
			this.addChild(this.mcContent);
			
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
		
		public function update():void  {
			[Inject] this._currentSegment = Structure.getSegmentByIndex(State.nAbsoluteIndex);
			
			this._currentChapter = this._currentSegment.chapter;
			this._currentSection = this._currentSegment.section;
			
			if(this._currentClip == null || this._currentClip.index != this._currentSegment.clip.index)  {
				trace("Need to load new clip!!");
				this._currentClip = this._currentSegment.clip;
				this._updateClip = true;
				[Inject] if(Server.getAsset(this._currentClip.link) == null)  {
					//need to load the clip
					[Inject] Server.queueSWF(this._currentClip.url);
					[Inject] Server.loadSWFQueue();
					[Inject] Preloader.runQueue();
					 
				 } else  {
					 startSegment();
				 }
			} else  {
				startSegment();
			}
		}
		
		public function startSegment():void  {
			if(this._updateClip || this._clip == null)  {
				if(this._clip != null && this.mcContent.contains(this._clip))  {
					this.mcContent.removeChild(this._clip);
				}
				this._clip = MovieClip(Server.getAsset(this._currentClip.link));
				this._updateClip = false;
				this.mcContent.addChild(this._clip);
				
			}
			this._clip.gotoAndPlay(this._currentSegment.id);
			
		}
		
		
		
	}
}