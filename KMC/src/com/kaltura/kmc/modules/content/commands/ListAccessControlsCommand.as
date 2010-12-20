package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListAccessControlsCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
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
		
		override public function result(data:Object):void
		{
			super.result(data);
			if(data.success)
			{
			//	_model.accessControlData.removeAll();
				var response:KalturaAccessControlListResponse = data.data as KalturaAccessControlListResponse;
				var tempArrCol:ArrayCollection = new ArrayCollection();
				for each(var kac:KalturaAccessControl in response.objects)
				{
					var acVo:AccessControlProfileVO = new AccessControlProfileVO();
					acVo.profile = kac;
					tempArrCol.addItem(acVo);
				}
				_model.filterModel.accessControlProfiles = tempArrCol;
			}
			else
			{
				Alert.show(data.error, ResourceManager.getInstance().getString('cms','error'));
			}

			_model.decreaseLoadCounter();
		}
		
		override public function fault(info:Object):void
		{
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('cms', 'accessControlLoadErrorMsg') , ResourceManager.getInstance().getString('cms','error'));
		}
		

	}
}