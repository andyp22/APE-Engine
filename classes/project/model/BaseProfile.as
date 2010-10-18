/**
 * classes.project.model.BaseProfile
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model  {
	
	[Inject] import classes.project.model.IProfile;
	
	public class BaseProfile implements IProfile  {
		private var _sName:String;
		private var _configs:Array;
		private var _bInit:Boolean;
		
		public function BaseProfile(sName:String)  {
			trace("Creating new BaseProfile -- " + this + " : " + sName);
			this._sName = sName;
			this.init();
		}
		private function init():void  {
			this._configs = new Array();
			this._bInit = true;
			
		}
		/*
		*	Interface Methods
		*/
		public function getName():String  {
			return this._sName;
		}
		/*
		*	Class Methods
		*/
		/*
		*	initProfileConfigs(aConfigs:Array):Array
		*
		*	Takes an array of configs (a config group) which consist 
		*	of sId:value pairs and converts it into a single array of 
		*	values in the form:
		*					aTemp[sId] = dataType(value)
		*	where dataType() represents a recoginzed datatype. Default  
		*	datatype for value is returned as a String.
		*
		*	Possible data types:
		*		a - Array
		*		b - Boolean
		*		n - Number
		*		s - String
		*	(Please add further data types in alphabetical order for
		*	 easier maintenance)
		*/
		public function initProfileConfigs(aConfigs:Array):void  {
			//trace("initProfileConfigs() -- " + this + " : " + this._sName);
			if(!this._bInit)  {
				trace("\n\tCannot initialize a profile's configs more than once.\n\n");
				return;
			}
			//trace("Running...");
			for(var elm in aConfigs)  {
				var config:Array = aConfigs[elm];
				var type:String = config["sId"].substr(0,1);
				switch(type)  {
					case "a":
						this._configs[config["sId"]] = config["value"].split(",");
						break;
					case "b":
						this._configs[config["sId"]] = Boolean(config["value"]);
						break;
					case "n":
						this._configs[config["sId"]] = (!isNaN(Number(config["value"]))) ? Number(config["value"]): 0;
						break;
					case "s":
						this._configs[config["sId"]] = String(config["value"]);
						break;
					default:
						this._configs[config["sId"]] = String(config["value"]);
				}
			}
			this._bInit = false;
			
			/*for(var elm1 in this._configs)  {
				trace(elm1 + " -- "+ typeof(this._configs[elm1]) + " : " + this._configs[elm1]);
			}*/
		}
		public function get config():Array  {
			return this._configs;
		}
		
		public function toString():String  {
			return "classes.project.model.BaseProfile -- "+ this._sName;
		}
	}
 }