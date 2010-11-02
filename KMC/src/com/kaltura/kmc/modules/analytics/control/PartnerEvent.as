package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PartnerEvent extends CairngormEvent
	{
		public static const UPDATE_PARTNER : String = "updatePartner";
		public static const GET_PARTNER_INFO : String = "getPartnerInfo";
		
		public function PartnerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}