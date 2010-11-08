package com.kaltura.kmc.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.google.analytics.core.ga_internal;
	import com.kaltura.KalturaClient;
	import com.kaltura.kmc.business.PermissionManager;
	
	import flash.events.EventDispatcher;

	[Bindable]
	public class KmcModelLocator extends EventDispatcher implements IModelLocator {

		///////////////////////////////////////////
		//singleton methods
		/**
		 * singleton instance 
		 */		
		private static var _instance:KmcModelLocator;


		/**
		 * Kaltura Client. This should be the instance that every module will get and use
		 */		
		public var kalturaClient:KalturaClient;
		
		/**
		 * The instance of a PermissionManager. 
		 */		
		public var permissionManager:PermissionManager = PermissionManager.getInstance();
		
		/**
		 * Flashvars of the main app wrapped in one object. The items are  
		 */		
		public var flashvars:Object;
		
		
		/**
		 * singleton means of retreiving an instance of the 
		 * <code>KmcModelLocator</code> class.
		 */		
		public static function getInstance():KmcModelLocator {
			if (_instance == null) {
				_instance = new KmcModelLocator(new Enforcer());
			}
			return _instance;
		}


		/**
		 * initialize parameters and sub-models. 
		 * @param enforcer	singleton garantee
		 */		
		public function KmcModelLocator(enforcer:Enforcer) 
		{

		}


	}
}

class Enforcer {

}