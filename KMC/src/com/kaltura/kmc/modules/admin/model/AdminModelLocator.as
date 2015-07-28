package com.kaltura.kmc.modules.admin.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;
	import com.kaltura.kmc.modules.admin.model.UsersModel;
	
	import flash.events.EventDispatcher;
	
	import modules.Management;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	[Bindable]
	public class AdminModelLocator extends EventDispatcher implements IModelLocator {

		/**
		 * defines the value of the type property of the loadingFlagChanged event 
		 */		
		public static const LOADING_FLAG_CHANGED:String = "loadingFlagChanged";
		
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
		public var app:Management;
		
		
		[Bindable(event="loadingFlagChanged")]
		/**
		 * is the module currently loading data
		 */		
		public function get isLoading():Boolean {
			return _loadingCounter != 0;
		}
		
		/**
		 * number of ongoing load calls 
		 */		
		private var _loadingCounter:int;
		
		/**
		 * increase number of load calls 
		 */		
		public function increaseLoadCounter():void {
			_loadingCounter ++;
			if (_loadingCounter == 1) {
				dispatchEvent(new Event(AdminModelLocator.LOADING_FLAG_CHANGED));
			}
		}
		
		/**
		 * decrease number of load calls 
		 */		
		public function decreaseLoadCounter():void {
			if (_loadingCounter <= 0) {
				trace("trying to reduce load calls under 0 - something is rotten in the state of Management (Administration)");
			}
			else {
				_loadingCounter--;
				if (_loadingCounter == 0) {
					dispatchEvent(new Event(AdminModelLocator.LOADING_FLAG_CHANGED));
				}
			}
		}
		
		
		
		// ==================================================
		// initialization
		// ==================================================
		
		/**
		 * initialize the different models
		 * */
		private function initModel():void {
			_loadingCounter = 0;
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