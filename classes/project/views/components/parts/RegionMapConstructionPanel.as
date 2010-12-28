/**
 * classes.project.views.components.parts.RegionMapConstructionPanel
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.views.components.parts  {
	
	import classes.project.core.Configs;
	import classes.project.core.LibFactory;
	import classes.project.core.Server;
	import classes.project.events.GuiControlEvent;
	import classes.project.events.GameControlEvent;
	import classes.project.events.PanelEvent;
	import classes.project.model.ContainerPanel;
	import classes.project.model.GuiControl;
	import classes.project.model.controls.GameMenuControl;
	import classes.project.views.components.parts.MiniMap;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RegionMapConstructionPanel extends ContainerPanel  {
		
		
		
		public function RegionMapConstructionPanel(sName:String, mc:MovieClip)  {
			trace("Creating new RegionMapConstructionPanel -- " + this + " : " + sName);
			super(sName, mc);
			this.init();
		}
		
		private function init():void  {
			trace("RegionMapConstructionPanel initializing...");
			addChild(this.mcContent);
			
			this.setHeader("Construction");
			this.createContentContainer(new MovieClip());
			this.sizeToContents();
		}
		
		override public function createContentContainer(mc:DisplayObject):void  {
			removeChild(this.mcContent);
			
			this.mcContent = MovieClip(mc);
			var nPadding:int = 5;
			this.mcContent.x = nPadding;
			this.mcContent.y = this.mcHeader.height + nPadding;
			
			var BG:MovieClip = LibFactory.createMovieClip("Empty_BG");
			this.mcContent.addChild(BG);
			
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
		
	}
}