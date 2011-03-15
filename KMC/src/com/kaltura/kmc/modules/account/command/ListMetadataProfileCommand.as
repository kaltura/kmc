package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.utils.ListMetadataProfileUtil;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	/**
	 * This class is used for sending MetadataProfileList requests 
	 * @author Michal
	 * 
	 */	
	public class ListMetadataProfileCommand implements ICommand, IResponder {
	
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		

		/**
		 * This function sends a MetadataProfileList request, with filter and pager
		 * that will make it recieve only the last created profile 
		 * @param event the event that triggered this command
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			var filter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, _model.metadataFilterPager);
			listMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
			listMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listMetadataProfile);
		}
		
		/**
		 * This function handles the response from the server
		 * @param data the data returned from the server
		 * 
		 */		
		public function result(data:Object):void
		{
			//last request is always the list request
			var listResult:KalturaMetadataProfileListResponse  = data.data as KalturaMetadataProfileListResponse;
			_model.metadataProfilesTotalCount = listResult.totalCount;
			_model.metadataProfilesArray = ListMetadataProfileUtil.handleListMetadataResult(listResult, _model.context);
		}
		
		/**
		 * This function handles errors from the server 
		 * @param info the error from the server
		 * 
		 */		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));

		}
		
	}
}
