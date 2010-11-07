package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]  	
	public class PaymentDetailsVO implements IValueObject
	{
		public var packageId : String = "";
		public var customerFirstName : String = "";  
		public var customerLastName : String = "";  
		public var customerCcType : String = ""; 
		public var customerCcNumber : String = "";   
		public var ccExpirationMonth : String = "";  
		public var ccExpirationYear : String = "";
		public var ccCvv2Number : String = "";  
		public var customerAddress1 : String = "";  
		public var customerAddress2 : String = ""; 
		public var customerCity : String = "";  
		public var customerState : String = "";  
		public var customerZip : String = ""; 
		public var customerCountry : String = "";
	}
}