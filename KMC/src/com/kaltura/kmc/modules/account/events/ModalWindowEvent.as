package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ModalWindowEvent extends CairngormEvent
	{
		public static const OPEN_PAYPAL_WINDOW : String = "openPayPalWindow";
		public var openWin : Boolean;
		public var windowState : String;
		
		public function ModalWindowEvent( type:String, 
										  openWin:Boolean , 
										  windowState : String , 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.openWin = openWin;
			this.data = data;
			this.windowState = windowState;
		}
	}
}