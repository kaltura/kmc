package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PartnerEvent extends CairngormEvent
	{
		public static const UPDATE_PARTNER : String = "analytics_updatePartner";
		public static const GET_PARTNER_INFO : String = "analytics_getPartnerInfo";
		public static const GET_PARTNER_APPLICATIONS : String = "analytics_getPartnerApplications";
		
		public function PartnerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}