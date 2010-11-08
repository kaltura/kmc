package com.kaltura.kmc.business
{
	/**
	 * This class will apply all permission to the UI by receiving a target screen to work with, 
	 * and a list of PermissionVos. 
	 * @author Eitan
	 * 
	 */
	public class PermissionManager
	{
		
		private var _permissions:Array;

		/**
		 * An array of instructions  
		 * @param value
		 * 
		 */
		public function set permissions(value:Array):void
		{
			_permissions = value;
		}
		
		public function applyPermissions(target:Object):void
		{
			
		}
		
		
		//singleton code
		/**
		 * singleton instance 
		 */		
		private static var _instance:PermissionManager;

		/**
		 * @param enforcer	singleton garantee
		 */		
		public function PermissionManager(enforcer:Enforcer) 
		{
			
		}
		
		/**
		 * singleton means of retreiving an instance of the 
		 * <code>PermissionManager</code> class.
		 */		
		public static function getInstance():PermissionManager {
			if (_instance == null) {
				_instance = new PermissionManager(new Enforcer());
			}
			return _instance;
		}

	}
}

class Enforcer {
	
}