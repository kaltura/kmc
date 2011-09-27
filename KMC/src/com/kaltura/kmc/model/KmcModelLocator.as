package com.kaltura.kmc.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.kmc.vo.UserVO;
	import com.kaltura.types.KalturaPermissionStatus;
	import com.kaltura.types.KalturaPermissionType;
	import com.kaltura.vo.KalturaPermission;
	import com.kaltura.vo.KalturaPermissionFilter;

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
		public var permissionManager:PermissionManager;

		/**
		 * Flashvars of the main app wrapped in one object. The items are
		 */
		public var flashvars:Object;

		public var userInfo:UserVO;

		public var permissionsListFilter:KalturaPermissionFilter;


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
		public function KmcModelLocator(enforcer:Enforcer) {
			permissionManager = PermissionManager.getInstance();

			permissionsListFilter = new KalturaPermissionFilter();
			permissionsListFilter.typeIn = KalturaPermissionType.SPECIAL_FEATURE + ',' + KalturaPermissionType.PLUGIN;
			permissionsListFilter.statusEqual = KalturaPermissionStatus.ACTIVE;
		}


	}
}

class Enforcer {

}