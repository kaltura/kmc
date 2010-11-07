package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	/**
	 * This class is used for sending MetadataProfileList requests 
	 * @author Michal
	 * 
	 */	
	public class ListMetadataProfileCommand implements ICommand, IResponder {
	
		private var _model:KMCModelLocator = KMCModelLocator.getInstance();
		

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
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = 1;
			pager.pageIndex = 1;
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, pager);
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
			var response:KalturaMetadataProfileListResponse =  KalturaMetadataProfileListResponse(data.data);
			var recievedProfile:KalturaMetadataProfile = response.objects[0];
			if (recievedProfile) {
				//display only profiles that were created from KMC
				if (recievedProfile.name == _model.context.metadataProfileName) {
					var metadataProfile : KMCMetadataProfileVO = new KMCMetadataProfileVO();
					metadataProfile.profile = recievedProfile;
					metadataProfile.xsd = new XML(recievedProfile.xsd);
					metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);

					_model.metadataProfile = metadataProfile;
				}
			} 
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
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));

		}
		
	}
}
