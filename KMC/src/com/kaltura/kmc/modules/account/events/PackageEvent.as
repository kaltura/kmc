package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PackageEvent extends CairngormEvent
	{
		public static const LIST_PARTNER_PACKAGE : String = "listPartnerPackage";
		public static const PURCHASE_PARTNER_PACKAGE : String = "purchasePartnerPackage";
		public function PackageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}