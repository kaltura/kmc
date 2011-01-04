package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerGetInfo;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.utils.KSUtil;
	import com.kaltura.vo.KalturaPartner;

	public class GetPartnerInfoCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var getPartnerInfo:PartnerGetInfo = new PartnerGetInfo();
			getPartnerInfo.addEventListener(KalturaEvent.COMPLETE, result);
			getPartnerInfo.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(getPartnerInfo);	
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.loginUsersQuota = (data.data as KalturaPartner).adminLoginUsersQuota;
				_model.usersModel.adminUserId = (data.data as KalturaPartner).adminUserId;
				_model.usersModel.crippledUsers = [(data.data as KalturaPartner).adminUserId, KSUtil.getUserId(_model.kc.ks)]; 
			}
			_model.decreaseLoadCounter();
		}
		
	}
}