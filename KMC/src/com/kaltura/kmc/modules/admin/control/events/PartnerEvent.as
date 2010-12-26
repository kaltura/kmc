package com.kaltura.kmc.modules.admin.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class PartnerEvent extends CairngormEvent {
		
		
		public static const GET_PARTNER_DATA:String = "admin_getParnterData";
		
		public function PartnerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}