package com.kaltura.analytics {
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import flash.display.DisplayObject;

	public class GoogleAnalyticsTracker {
		
		private var _tracker:AnalyticsTracker;

		/**
		 * the urchin number to use for tracking
		 */
		private var _urchinNumber:String = "";

		/**
		 * current partner being tracked
		 */
		private var _partnerId:String;

		/**
		 * current user being tracked
		 */
		private var _userId:String;

		/**
		 * used as module path if one is not given
		 */
		private var _kmcVersion:String;

		/**
		 * should events be tracked 
		 */
		private var _enabled:Boolean = true;
		
		/**
		 * singleton instance 
		 */
		private static var _instance:GoogleAnalyticsTracker;
		
		
		/**
		 * constructor 
		 * 
		 * @param enforcer
		 */		
		public function GoogleAnalyticsTracker(enforcer:Enforcer) {

		}


		public static function getInstance():GoogleAnalyticsTracker {
			if (_instance == null) {
				_instance = new GoogleAnalyticsTracker(new Enforcer());
			}

			return _instance;
		}


		/**
		 * save session parameters 
		 * 
		 * @param partnerId		partner in current session
		 * @param userId		user in current session
		 * @param parentDisplayObject	to be used in tracker debug mode
		 * @param kmcVersion	current kmc version, used as default value when 
		 * 		no module path is given for events
		 * @param urchinNumber	google analytics account to use for tracking
		 * @param langCode		language version code (AS3)
		 * @param debug			should the tracker run in debug mode
		 * 
		 */
		public function init(partnerId:String, userId:String, parentDisplayObject:DisplayObject, kmcVersion:String, urchinNumber:String, langCode:String, debug:Boolean):void {
			_kmcVersion = kmcVersion;
			_urchinNumber = urchinNumber;
			_partnerId = partnerId;
			_userId = userId;
			_tracker = new GATracker(parentDisplayObject, _urchinNumber, langCode, debug);
		}
		
		/**
		 * set the default value used for base track path 
		 * @param path	new path
		 */		
		public function setBasePath(path:String):void {
			_kmcVersion = path;
		}


		/**
		 * send tracking event to Google Analytics
		 * 		 
		 * @param eventTracked	the event being tracked
		 * @param modulePath	the module that dispatched this event
		 */		
		public function sendToGA(eventTracked:String, modulePath:String):void {
			if (!_enabled || !_urchinNumber) {
				return;
			} 
			if (!modulePath) {
				modulePath = _kmcVersion;
			}
			_tracker.trackPageview(modulePath + "/" + eventTracked + "/" + "partner_id=" + _partnerId);
		}
		
		
		public function set enabled(value:Boolean):void {
			_enabled = value;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}

	}
}

class Enforcer {

}
