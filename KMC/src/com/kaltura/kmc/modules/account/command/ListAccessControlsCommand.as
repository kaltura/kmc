package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaBaseRestriction;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListAccessControlsCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			if (_model.filterPager) {
				var getListAccessControlProfiles:AccessControlList = new AccessControlList(_model.acpFilter, _model.filterPager);
				getListAccessControlProfiles.addEventListener(KalturaEvent.COMPLETE, result);
				getListAccessControlProfiles.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(getListAccessControlProfiles);
			}
		}


		public function result(data:Object):void {
			_model.loadingFlag = false;

			if (data.success) {
				var tempArr:ArrayCollection = new ArrayCollection();
				var response:KalturaAccessControlListResponse = data.data as KalturaAccessControlListResponse;
				_model.accessControlProfilesTotalCount = response.totalCount;
				_model.accessControls = new ArrayCollection();
				for each (var kac:KalturaAccessControl in response.objects) {
					var acVo:AccessControlProfileVO = new AccessControlProfileVO();
					acVo.profile = kac;
					acVo.id = kac.id.toString();
					if (kac.restrictions) {
						// remove unknown objects
						// if any restriction is unknown, we remove it from the list.
						// this means access control profiles with unknown restrictions CANNOT be edited in KMC,
						// as editing hem will delete the unknown restriction.
						for (var i:int = 0; i < kac.restrictions.length; i++) {
							if (!(kac.restrictions[i] is KalturaBaseRestriction)) {
								kac.restrictions.splice(i, 1);
							}
						}
					}
					if (acVo.profile.isDefault) {
						tempArr.addItemAt(acVo, 0);
					}
					else {
						tempArr.addItem(acVo);
					}
				}
				_model.accessControls = tempArr;
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('account', 'error'));
			}

			//_model.partnerInfoLoaded = true;
		}


		public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadAccessControl') + "\n\t" + info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}


	}
}
