package com.kaltura.analytics
{
//	import com.adobe.crypto.MD5;
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.stats.StatsCollect;
	import com.kaltura.commands.stats.StatsKmcCollect;
	import com.kaltura.vo.KalturaStatsKmcEvent;
	
	import flash.net.URLRequestMethod;
	
	public class KAnalyticsTracker
	{
		private static var _instance:KAnalyticsTracker;
		private var _kc:KalturaClient;
	//	private var _sessionId:String;   - No need for it, the server will use the KS of the user.
		private var _clientVersion:String;
		private var _swfName:String;
		private var _userId:String;
		
		public function KAnalyticsTracker(enforcer:Enforcer){}
		
		public static function getInstance():KAnalyticsTracker
		{
			if(_instance == null)
			{
				_instance = new KAnalyticsTracker(new Enforcer());
			}
			
			return _instance;
		}
        
        public function init(kc:KalturaClient, swfName:String, clientVersion:String, userId:String):void
        {
        	_kc = kc;
 //       	_sessionId = MD5.hash(_kc.ks);
        	_clientVersion = clientVersion;
        	_userId = userId;
        	_swfName = swfName;
        }
        
        public function sendEvent(eventCode:int, eventPath:String, entryId:String=null, uiconfId:int=int.MIN_VALUE, widgetId:String=null):void
        {
        	var analyticsEvent:KalturaStatsKmcEvent = new KalturaStatsKmcEvent();
        	analyticsEvent.kmcEventType = eventCode;
        	analyticsEvent.kmcEventActionPath = eventPath;
//        	analyticsEvent.sessionId = _sessionId;
        	analyticsEvent.partnerId = int(_kc.partnerId);
        	analyticsEvent.clientVer = "1.0:" + _swfName + ":" + _clientVersion;
        	analyticsEvent.userId = _userId;
        	analyticsEvent.eventTimestamp = (new Date().time)/1000;
        	analyticsEvent.uiconfId = uiconfId; // when manipulating uiconfs
        	analyticsEvent.entryId = entryId;  // when manipulating entries
 //       	analyticsEvent.userIp  - server side, no need to send
        	analyticsEvent.widgetId = widgetId;// when manipulating widgets (relevant for the embed code)
        	
        	
        	var statsKmcCall:StatsKmcCollect = new StatsKmcCollect(analyticsEvent);
        	statsKmcCall.method = URLRequestMethod.GET;
        	_kc.post(statsKmcCall);
        }
        
       
	}
}
	
class Enforcer
{

}