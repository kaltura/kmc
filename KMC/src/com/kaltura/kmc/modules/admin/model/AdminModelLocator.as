package com.kaltura.kmc.modules.admin.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;
	import com.kaltura.kmc.modules.admin.model.UsersModel;
	
	import modules.Administration;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	[Bindable]
	public class AdminModelLocator implements IModelLocator {

		/**
		 * data model for the users management subtab
		 * */
		public var usersModel:UsersModel;

		/**
		 * data model for the users management subtab
		 * */
		public var rolesModel:RolesModel;

		/**
		 * API v3 client
		 */
		public var kc:KalturaClient;
		
		/**
		 * reference to module
		 * */
		public var app:Administration;
		
		
		
		// ==================================================
		// initialization
		// ==================================================
		
		/**
		 * initialize the different models
		 * */
		private function initModel():void {
			usersModel = initUsersModel();
			rolesModel = initRolesModel();
		}
		
		
		/**
		 * create and initialize the roles subtab model
		 * */
		private function initRolesModel():RolesModel {
			var roles:RolesModel = new RolesModel();
			
			return roles;
		}
		
		
		/**
		 * create and initialize the users subtab model
		 * */
		private function initUsersModel():UsersModel {
			var users:UsersModel = new UsersModel();
			
			return users;
		}
		
		// ==================================================
		// singleton crap
		// ==================================================
		

		/**
		 * singleton instance
		 * */
		private static var _modelLocator:AdminModelLocator;


		/**
		 * retreives an instance of the KMCModelLocator class
		 */
		public static function getInstance():AdminModelLocator {
			if (_modelLocator == null) {
				_modelLocator = new AdminModelLocator(new Enforcer());
			}
			return _modelLocator;
		}


		/**
		 * Disabled singleton constructor.
		 */
		public function AdminModelLocator(enforcer:Enforcer) {
			initModel();
		}
	}
}

class Enforcer {}