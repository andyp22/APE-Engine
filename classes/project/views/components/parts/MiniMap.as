/**
 * classes.project.views.components.parts.MiniMap
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.views.components.parts  {
	
	import classes.project.core.Server;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class MiniMap extends Sprite  {
		
		private var _displayMap:Bitmap;
		private var _viewWindow:Sprite;
		
		private var _mapWidth:Number;
		private var _mapHeight:Number;
		private var _scale:Number;
		
		/**
		 * Constructor
		 */
		public function MiniMap(map:Bitmap, nW:Number, nH:Number)  {
			super();
			trace("Creating new MiniMap...");
			
			this._displayMap = map;
			this._mapWidth = nW;
			this._mapHeight = nH;
			
			this.init();
		}
		
		private function init():void  {
			this.createBaseMap();
			
			
		}
		private function createBaseMap():void  {
			var wS:Number = this._mapWidth/this._displayMap.width;
			var hS:Number = this._mapHeight/this._displayMap.height;
			this._scale = (wS <= hS) ? wS: hS;
			this._displayMap.scaleX = this._scale;
			this._displayMap.scaleY = this._scale;
			this.addChild(this._displayMap);
		}
		public function createViewWindow(stageW:Number, stageH:Number):void  {
			this._viewWindow = new Sprite;
			
			this._viewWindow.graphics.moveTo(0, 0);
			this._viewWindow.graphics.lineStyle(1, 0xffffff);
			this._viewWindow.graphics.lineTo(stageW, 0);
			this._viewWindow.graphics.lineTo(stageW, stageH);
			this._viewWindow.graphics.lineTo(0, stageH);
			this._viewWindow.graphics.lineTo(0, 0);
			this._viewWindow.scaleX = this._scale;
			this._viewWindow.scaleY = this._scale;
			
			this.addChild(this._viewWindow);
		}
		public function updateViewWindowPosition(nX:Number, nY:Number):void  {
			var newX:Number = (nX * -1) * this._scale;
			var newY:Number = (nY * -1) * this._scale;
			this._viewWindow.x = Math.floor(newX);
			this._viewWindow.y = Math.floor(newY);
		}
		public function handleClick(clickX:Number, clickY:Number):void  {
			var newX:Number = clickX - this._viewWindow.width/2;
			var newY:Number = clickY - this._viewWindow.height/2;
			if(newX < 0)  {
				newX = 0;
			} else if((newX + this._viewWindow.width) > this._displayMap.width)  {
				newX = this._displayMap.width - this._viewWindow.width;
			}
			if(newY < 0)  {
				newY = 0;
			} else if((newY + this._viewWindow.height) > this._displayMap.height)  {
				newY = this._displayMap.height - this._viewWindow.height;
			}
			this._viewWindow.x = newX;
			this._viewWindow.y = newY;
		}
		public function get coords():Array  {
			var temp:Array = new Array();
			temp["x"] = Math.floor(this._viewWindow.x/this._scale);
			temp["y"] = Math.floor(this._viewWindow.y/this._scale);
			return temp;
		}
		
	}
}