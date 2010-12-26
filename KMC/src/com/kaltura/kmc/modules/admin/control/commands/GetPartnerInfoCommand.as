package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerGetInfo;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaPartner;

	public class GetPartnerInfoCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var getPartnerInfo:PartnerGetInfo = new PartnerGetInfo();
			getPartnerInfo.addEventListener(KalturaEvent.COMPLETE, result);
			getPartnerInfo.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(getPartnerInfo);	
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.loginUsersQuota = (data.data as KalturaPartner).adminLoginUsersQuota;
			}
			_model.decreaseLoadCounter();
		}
	}
}