package com.kaltura.kmc.modules.analytics.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;

	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	[Bindable]
	public class KMCModelLocator implements IModelLocator {


		/**
		 * API v3 client
		 */
		public var kc:KalturaClient;

		/**
		 * singleton instance
		 * */
		private static var _modelLocator:KMCModelLocator;


		/**
		 * retreives an instance of the KMCModelLocator class
		 */
		public static function getInstance():KMCModelLocator {
			if (_modelLocator == null) {
				_modelLocator = new KMCModelLocator(new Enforcer());
			}
			return _modelLocator;
		}


		/**
		 * Disabled singleton constructor.
		 */
		public function KMCModelLocator(enforcer:Enforcer) {
		}
	}
}

class Enforcer {}