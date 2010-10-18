/**
 * classes.project.model.ControlGroup
 * @version 1.0.0
 * @author andrew page
 */
package classes.project.model {
	import classes.project.model.GuiControl;
	
	public class ControlGroup {
		private var sName:String;
		private var _controls:Array;
		/**
		 * Constructor
		 */
		public function ControlGroup(sName:String)  {
			trace("Creating new ControlGroup -- " + this + " : " + sName);
			
			this.sName = sName;
			this._controls = new Array();
			
			this.init();
		}
		
		private function init():void  {
			
			
		}
		
		public function addControl(control:GuiControl):void  {
			//trace("Control added to Control group: "+control.getName() + " -- " + this.sName);
			this._controls.push(control);
		}
		public function removeControl(sName:String):void  {
			for(var i:int = 0; i < this._controls.length; i++)  {
				if(this._controls[i].getName() == sName)  {
					this._controls.splice(i, 1);
				}
			}
		}
		public function hasControl(sName:String):Boolean  {
			for(var i:int = 0; i < this._controls.length; i++)  {
				if(this._controls[i].getName() == sName)  {
					return true;
				}
			}
			return false;
		}
		public function getControl(sName:String):GuiControl  {
			for(var i:int = 0; i < this._controls.length; i++)  {
				if(this._controls[i].getName() == sName)  {
					return this._controls[i];
				}
			}
			return null;
		}
		
		public function enable():void  {
			for(var i:int = 0; i < this._controls.length; i++)  {
				this._controls[i].enable();
			}
		}
		public function disable():void  {
			for(var i:int = 0; i < this._controls.length; i++)  {
				this._controls[i].disable();
			}
		}
		public function getName():String  {
			return this.sName;
		}
		
	}
}