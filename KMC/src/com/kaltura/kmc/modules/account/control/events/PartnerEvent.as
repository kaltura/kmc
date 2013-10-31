package com.kaltura.kmc.modules.account.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PartnerEvent extends CairngormEvent
	{
		public static const UPDATE_PARTNER : String = "account_updatePartner";
		public static const GET_PARTNER_INFO : String = "account_getPartnerInfo";
		
		public function PartnerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}