package com.kaltura.kmc.modules.account.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.kmc.modules.account.model.Notifications;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaPartner;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PartnerVO implements IValueObject {
		/**
		 * partner ID
		 */
		public var partnerId:String = "";


		/**
		 * sub-partner ID
		 */
		public var subPId:String = "";


		/**
		 * KalturaPartner object with relevant data
		 */
		public var partner:KalturaPartner;

		/**
		 * NotificationVO objects
		 */
		public var notifications:ArrayCollection = new ArrayCollection();


		public function PartnerVO() {
			for (var key:String in Notifications.notificationMap) {
				var noti:NotificationVO = new NotificationVO();
				noti.nId = key;
				noti.name = Notifications.notificationMap[key].name;
				noti.clientEnabled = Notifications.notificationMap[key].clientEnabled;
				this.notifications.addItem(noti);
			}
		}


		public function clone():PartnerVO {
			var newPVo:PartnerVO = new PartnerVO();
			newPVo.partnerId = this.partnerId;
			
			newPVo.partner = new KalturaPartner();
			ObjectUtil.copyObject(partner, newPVo.partner);
			
			newPVo.notifications = new ArrayCollection(new Array(int(this.notifications.length)));
			for (var i:int = 0; i < this.notifications.length; i++) {
				newPVo.notifications[i] = new NotificationVO();
				newPVo.notifications[i].availableInClient = this.notifications[i].availableInClient;
				newPVo.notifications[i].availableInServer = this.notifications[i].availableInServer;
				newPVo.notifications[i].nId = this.notifications[i].nId;
				newPVo.notifications[i].name = this.notifications[i].name;
				newPVo.notifications[i].clientEnabled != this.notifications[i].clientEnabled;
			}

			return newPVo;
		}


		public function equals(newPVo:PartnerVO):Boolean {
			if (!newPVo)
				return false;

			var isIt:Boolean = true;
			if (newPVo.partnerId != this.partnerId)
				isIt = false;

			if (!ObjectUtil.compareObjects(this.partner, newPVo.partner)) {
				isIt = false;
			}
			
			for (var i:int = 0; i < this.notifications.length; i++) {
				if (newPVo.notifications[i].availableInClient != this.notifications[i].availableInClient)
					isIt = false;
				if (newPVo.notifications[i].availableInServer != this.notifications[i].availableInServer)
					isIt = false;
				if (newPVo.notifications[i].nId != this.notifications[i].nId)
					isIt = false;
				if (newPVo.notifications[i].name != this.notifications[i].name)
					isIt = false;
			}

			return isIt;
		}
	}
}
