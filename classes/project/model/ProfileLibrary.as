/**
 * classes.project.model.ProfileLibrary
 * @version 1.0.0
 * @author andrew page
 */
 package classes.project.model  {
	
	import classes.project.model.IProfile;
	
	public class ProfileLibrary  {
		private var _sName:String;
		private var _profiles:Array;
		
		
		public function ProfileLibrary(sName:String)  {
			trace("Creating a new ProfileLibrary... "+ this +" -- "+ sName);
			this._sName = sName;
			this._profiles = new Array();
			
		}
		
		public function addProfile(profile:IProfile):void  {
			trace("adding Profile -- "+ profile.getName());
			this._profiles[profile.getName()] = profile;
		}
		public function getProfile(sName:String):IProfile  {
			return this._profiles[sName];
		}
		public function hasProfile(sName:String):Boolean  {
			if(this._profiles[sName] != undefined)  {
				return true;
			}
			return false;
		}
		
		
	}
 }