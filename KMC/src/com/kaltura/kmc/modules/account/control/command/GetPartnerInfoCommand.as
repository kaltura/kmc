package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerGetInfo;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.business.PartnerInfoUtil;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.NotificationVO;
	import com.kaltura.kmc.modules.account.vo.PartnerVO;
	import com.kaltura.vo.KalturaPartner;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetPartnerInfoCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			//we only load the partner info 1 time in this app
			if (_model.partnerInfoLoaded)
				return;

			_model.loadingFlag = true;

			var getPartnerInfo:PartnerGetInfo = new PartnerGetInfo();
			getPartnerInfo.addEventListener(KalturaEvent.COMPLETE, result);
			getPartnerInfo.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getPartnerInfo);
		}


		public function result(data:Object):void {
			_model.loadingFlag = false;
			if (data.data is KalturaPartner) {
				var resultKp:KalturaPartner = data.data as KalturaPartner;
				var pvo:PartnerVO = new PartnerVO;
				pvo.partner = resultKp;

				pvo.partnerId = _model.context.kc.partnerId;
				pvo.subPId = _model.context.subpId;

				PartnerInfoUtil.createNotificationArray(resultKp.notificationsConfig, pvo.notifications);

				_model.partnerData = pvo;
			}
			_model.partnerInfoLoaded = true;
		}


		public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				JSGate.expired();
				return;
			}
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadPartnerData'), ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}


	}
}
