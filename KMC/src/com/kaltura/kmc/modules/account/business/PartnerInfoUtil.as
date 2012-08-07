package com.kaltura.kmc.modules.account.business
{
	import com.kaltura.kmc.modules.account.vo.NotificationVO;
	
	import mx.collections.ArrayCollection;

	/**
	 * methods for manipulating partner data (KalturaPartner / PartnerVO)  
	 * @author atar.shadmi
	 * 
	 */	
	public class PartnerInfoUtil
	{
		
		/**
		 * create notification config string from the given array collection 
		 * @param notifications (NotificationVO objects)
		 * @return string representation of the partner's notifications config
		 */
		public static function getNotificationsConfig(notifications:ArrayCollection):String {
			var str:String = "*=0;"
			for (var i:int = 0; i < notifications.length; i++) {
				var nvo:NotificationVO = notifications[i] as NotificationVO;
				var res:int = 0;
				
				if (nvo.availableInServer && nvo.availableInClient && nvo.clientEnabled)
					res = 3;
				else if (nvo.availableInClient && nvo.clientEnabled)
					res = 2;
				else if (nvo.availableInServer)
					res = 1;
				else
					res = 0;
				
				str += nvo.nId + "=" + res + ";";
			}
			return str;
		}
		
		
		
		public static function createNotificationArray(str:String, arrCol:ArrayCollection):void {
			if (str == null) {
				return;
			}
			
			str = (str == null) ? '' : str;
			
			var tempNotiArray:Array = str.split(";");
			var i:int = 0;
			//set the notification to *=0 and make the changes needed
			switch (tempNotiArray[0]) {
				case "*=0": //all off
					for (i = 0; i < arrCol.length; i++) {
						(arrCol[i] as NotificationVO).availableInClient = false;
						(arrCol[i] as NotificationVO).availableInServer = false;
					}
					break;
				case "*=1": //all server on
					for (i = 0; i < arrCol.length; i++) {
						(arrCol[i] as NotificationVO).availableInClient = false;
						(arrCol[i] as NotificationVO).availableInServer = true;
					}
					break;
				case "*=2": //all client on
					for (i = 0; i < arrCol.length; i++) {
						(arrCol[i] as NotificationVO).availableInClient = true;
						(arrCol[i] as NotificationVO).availableInServer = false;
					}
					break;
				case "*=3": //all on
					for (i = 0; i < arrCol.length; i++) {
						(arrCol[i] as NotificationVO).availableInClient = true;
						(arrCol[i] as NotificationVO).availableInServer = true;
					}
					break;
			}
			
			for (i = 1; i < tempNotiArray.length; i++) {
				var keyValArr:Array = tempNotiArray[i].split("=");
				for (var j:int = 0; j < arrCol.length; j++) {
					if ((arrCol[j] as NotificationVO).nId == keyValArr[0]) {
						switch (keyValArr[1]) {
							case "0":
								(arrCol[j] as NotificationVO).availableInClient = false;
								(arrCol[j] as NotificationVO).availableInServer = false;
								break;
							case "1":
								(arrCol[j] as NotificationVO).availableInClient = false;
								(arrCol[j] as NotificationVO).availableInServer = true;
								break;
							case "2":
								(arrCol[j] as NotificationVO).availableInClient = true;
								(arrCol[j] as NotificationVO).availableInServer = false;
								break;
							case "3":
								(arrCol[j] as NotificationVO).availableInClient = true;
								(arrCol[j] as NotificationVO).availableInServer = true;
								break;
						}
					}
				}
			}
		}
	}
}