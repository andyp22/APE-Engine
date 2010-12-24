/**
 * classes.project.model.grid.HexGrid
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model.grid {
	
	import classes.project.core.LibFactory;
	import classes.project.model.grid.HexTile;
	import classes.project.model.grid.IGrid;
	import classes.project.model.grid.ITile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	public class HexGrid extends Sprite implements IGrid {
		
		private var _clip:MovieClip;
		private var _noiseMap:Bitmap;
		private var _id:String;
		private var _gridData:Array;
		private var _tiles:Array;
		
		private var ROWS:uint;
		private var COLS:uint;
		private var STARTX:Number;
		private var STARTY:Number;
		
		private var XDIFF:Number = 0;
		private var YDIFF:Number = 0;
		
		private var _TINY_MAP:Array = [22, 36];
		private var _SMALL_MAP:Array = [26, 42];
		private var _STANDARD_MAP:Array = [30, 48];
		private var _LARGE_MAP:Array = [34, 54];
		private var _HUGE_MAP:Array = [38, 60];
		private var _CURRENT_MAP:Array = new Array();
		
		private var bRandomizeMap:Boolean = false;
		
		
		/**
		 * Constructor
		 */
		public function HexGrid(sID:String, startX:Number = 0, startY:Number = 0, mapSize:String = "")  {
			trace("Creating new HexGrid...");
			this._id = sID;
			this.STARTX = startX;
			this.STARTY = startY;
			
			this._CURRENT_MAP = this.getMapSize(mapSize);
			
		}
		private function init():void  {
			this._clip = new MovieClip();
			addChild(this._clip);
			
			this.initTiles(this.STARTX, this.STARTY);
			
		}
		public function setGridData(gridData:Array):void  {
			this._gridData = gridData;
			this.init();
		}
		private function initTiles(nX, nY):void  {
			// init the array which will hold our tiles
			// this is a 2-level array with the first level
			// representing the rows in our grid
			var counter:Number = 0;
			this._tiles = new Array();
			
			if(this.bRandomizeMap)  {
				this.ROWS = this._CURRENT_MAP[0];
				this.COLS = this._CURRENT_MAP[1];
				this.createNoiseMap();
			} else  {
				this.ROWS = this._gridData.length;
				this.COLS = this._gridData[0].length;
			}
			
			for(var i:int = 0; i < this.ROWS; i++)  {
				// the second level represents the columns 
				// in our grid
				this._tiles[i] = new Array();
				for(var j:int = 0; j < this.COLS; j++)  {
					//trace("row "+i+" col "+j+": "+nX+" -- "+nY);
					var tile_id:String = i +"|"+j;
					[Inject] var mcTile:HexTile;
					var bWalkable:Boolean = true;
					
					if(this.bRandomizeMap)  {
						
						var tileHeight:uint = this.getMapHeight(j, i);
						var sType:String = "empty";
						
						if(tileHeight < 33000)  {
							sType = "water";
							//bWalkable = false;
						}
						if(tileHeight >= 33000 && tileHeight < 38000)  {
							sType = "dirt";
						}
						if(tileHeight >= 38000 && tileHeight < 46000)  {
							sType = "grass";
						}
						if(tileHeight >= 46000 && tileHeight < 50500)  {
							sType = "hills";
						}
						if(tileHeight >= 50500 && tileHeight < 51500)  {
							sType = "stone";
						}
						if(tileHeight >= 51500)  {
							sType = "tops";
							//bWalkable = false;
						}
						
						mcTile = new HexTile(tile_id, LibFactory.createMovieClip("HexTile_MC"), sType);
					} else  {
						mcTile = new HexTile(tile_id, LibFactory.createMovieClip("HexTile_MC"), this._gridData[i][j]["type"]);
						if(this._gridData[i][j]["bWalkable"] != null && this._gridData[i][j]["bWalkable"] == "false")  {
							bWalkable = false;
						}
					}
					
					mcTile.setPos(nX, nY);
					mcTile.setWalkable(bWalkable);
					
					this._clip.addChild(mcTile);
					this._tiles[i][j] = mcTile;
					counter++;
					// update the position vars
					// if this is an even numbered column, 
					// increase y by half the height of the tile
					if((j%2) == 0)  {
						nY += mcTile.getHeight()/2;
					} else  {
						// if this is an odd numbered column and this
						// isn't the last column decrease y by half 
						// the height of the tile
						if((j+1) < this.COLS)  {
							nY -= mcTile.getHeight()/2;
						}
					}
					// increase x by 3/4 of the width of a tile
					nX += mcTile.getWidth()*(3/4);
				}
				// for each new row we need to reset the x
				// position and increment the y position by
				// half the height of a tile
				nX = mcTile.getWidth()/2;
				nY += mcTile.getHeight()/2;
			}
			
		}
		
		public function getID():String  {
			return this._id;
		}
		public function getHeight():Number  {
			return this._clip.height;
		}
		public function getWidth():Number  {
			return this._clip.width;
		}
		public function getMask():Sprite  {
			return Sprite(this.mask);
		}
		public function xPos():Number  {
			return this._clip.x;
		}
		public function yPos():Number  {
			return this._clip.y;
		}
		public function updatePosition(nX:Number, nY:Number):void  {
			this._clip.x += nX;
			XDIFF += nX;
			this._clip.y += nY;
			YDIFF += nY;
		}
		
		public function getTileByLocation(xPos:Number, yPos:Number):ITile  {
			//trace("getTileByLocation("+xPos+", "+yPos+")");
			// find the current column by dividing the X position by 3/4 of the tile width
			var nCol:Number = Math.floor((xPos - XDIFF)/(this._tiles[0][0].getWidth()*(3/4)));
			// find the current row by dividing the Y position by the tile height and then 
			// subtracting one if the column number is odd
			var nRow:Number = Math.floor((yPos - YDIFF)/this._tiles[0][0].getHeight()) - (nCol%2);
			// return  the tile at that location if it is a valid array loacation
			// this is mostly here to prevent warnings
			if((nRow >= 0) && (nCol >= 0) && (nRow <= (this._tiles.length - 1)) && (nCol <= (this._tiles[nRow].length - 1)))  {
				return this._tiles[nRow][nCol];
			}
			return null;
		}
		
		
		public function createNoiseMap():void  {
			var bmd:BitmapData = new BitmapData(this.COLS, this.ROWS, false, 0x00CCCCCC);
			var _date:Date = new Date();
			var seed:Number = Math.floor(Math.random()*(_date.getTime()%1371));
			var channels:uint = BitmapDataChannel.GREEN;
			bmd.perlinNoise(this.COLS, this.ROWS, 12, seed, true, true, channels, false, null);
			
			this._noiseMap = new Bitmap(bmd);
		}
		
		private function getMapHeight(xPos:Number, yPos:Number):uint  {
			var _bitmapData:BitmapData = this._noiseMap.bitmapData;
			var _pixel:uint = _bitmapData.getPixel(xPos, yPos);
			
			return _pixel;
		}
		private function getMapSize(sizeName:String):Array  {
			var aTemp:Array = new Array();
			trace("Creating "+sizeName+" size map...");
			switch(sizeName)  {
				case "tiny":
					aTemp = this._TINY_MAP;
					break;
				case "small":
					aTemp = this._SMALL_MAP;
					break;
				case "large":
					aTemp = this._LARGE_MAP;
					break;
				case "huge":
					aTemp = this._HUGE_MAP;
					break;
				default:
					aTemp = this._STANDARD_MAP;
			}
			return aTemp;
		}
		
		
		
		
	}
}