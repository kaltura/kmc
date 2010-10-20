package com.kaltura.analytics
{
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import flash.display.DisplayObject;
	///avi test this///
	public class GoogleAnalyticsTracker
	{
		private var tracker:AnalyticsTracker;
		private var _urchinNumber:String = "";//here the Urchin Number, take it from the partner UrchinNumber
		private var _partnerId:String;
		private var _userId:String;
		private var _kmcVersion:String;
		
		private static var _instance:GoogleAnalyticsTracker;
		
		public function GoogleAnalyticsTracker(enforcer:Enforcer)
		{
			//tracker = new GATracker( this, UrchinNumber, "AS3", false );
		}
		
		public static function getInstance():GoogleAnalyticsTracker
		{
			if(_instance == null)
			{
				_instance = new GoogleAnalyticsTracker(new Enforcer());
			}
			
			return _instance;
		}
        
        public function init(partnerId:String, userId:String, parentDisplayObject:DisplayObject,kmcVersion:String,urchinNumber:String, langCode:String, debug:Boolean):void
        {
        	_kmcVersion=kmcVersion;
        	_urchinNumber = urchinNumber;
        	_partnerId = partnerId;
        	_userId = userId;
        	tracker = new GATracker( parentDisplayObject, _urchinNumber, langCode, debug );
        }
        
        public function sendToGA(eventTracked:String):void
        {
        	tracker.trackPageview(_kmcVersion+"/"+ eventTracked+"/"+"partner_id=" + _partnerId + "/user_id=" + _userId );
        }
	}
}
	
class Enforcer
{

}
