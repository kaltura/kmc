package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaBaseRestriction;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListAccessControlsCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAccessControlFilter = new KalturaAccessControlFilter();
			filter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = 1000;
			var getListAccessControlProfiles:AccessControlList = new AccessControlList(filter, pager);
			getListAccessControlProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			getListAccessControlProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListAccessControlProfiles);
		}


		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				var response:KalturaAccessControlListResponse = data.data as KalturaAccessControlListResponse;
				var tempArrCol:ArrayCollection = new ArrayCollection();
				for each (var kac:KalturaAccessControl in response.objects) {
					var acVo:AccessControlProfileVO = new AccessControlProfileVO();
					acVo.profile = kac;
					// remove unknown objects
					// if any restriction is unknown, we remove it from the list.
					// this means it is not supported in KMC at the moment
					for (var i:int = 0; i<kac.restrictions.length; i++) {
						if (! (kac.restrictions[i] is KalturaBaseRestriction)) {
							kac.restrictions.splice(i, 1);
						}
					}
					tempArrCol.addItem(acVo);
				}
				_model.filterModel.accessControlProfiles = tempArrCol;
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('cms', 'error'));
			}

			_model.decreaseLoadCounter();
		}
	}
}