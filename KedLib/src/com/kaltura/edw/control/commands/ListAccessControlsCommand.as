package com.kaltura.edw.control.commands {
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
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

	public class ListAccessControlsCommand extends KedCommand {

		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAccessControlFilter = new KalturaAccessControlFilter();
			filter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = 1000;
			var listAcp:AccessControlList = new AccessControlList(filter, pager);
			listAcp.addEventListener(KalturaEvent.COMPLETE, result);
			listAcp.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(listAcp);
		}


		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				var response:KalturaAccessControlListResponse = data.data as KalturaAccessControlListResponse;
				var tempArrCol:ArrayCollection = new ArrayCollection();
				for each (var kac:KalturaAccessControl in response.objects) {
					var acVo:AccessControlProfileVO = new AccessControlProfileVO();
					acVo.profile = kac;
					if (kac.restrictions ) {
						// remove unknown objects
						// if any restriction is unknown, we remove it from the list.
						// this means it is not supported in KMC at the moment
						for (var i:int = 0; i<kac.restrictions.length; i++) {
							if (! (kac.restrictions[i] is KalturaBaseRestriction)) {
								kac.restrictions.splice(i, 1);
							}
						}
					}
					tempArrCol.addItem(acVo);
				}
				(_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel.accessControlProfiles = tempArrCol;
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('cms', 'error'));
			}

			_model.decreaseLoadCounter();
		}
	}
}