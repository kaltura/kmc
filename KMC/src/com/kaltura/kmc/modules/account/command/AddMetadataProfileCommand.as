package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.metadataProfile.MetadataProfileAdd;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.utils.ListMetadataProfileUtil;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.types.KalturaMetadataProfileCreateMode;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	/**
	 * This class handles the addition of a new profile to the current partner 
	 * @author Michal
	 * 
	 */	
	public class AddMetadataProfileCommand implements ICommand, IResponder {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		/**
		 * Will send a MetadataProfileAdd request with the current XSD. 
		 * @param event the event that triggered this command.
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			
			var mr:MultiRequest = new MultiRequest();
			
			_model.selectedMetadataProfile.profile.metadataObjectType = KalturaMetadataObjectType.ENTRY;		
			_model.selectedMetadataProfile.profile.createMode = KalturaMetadataProfileCreateMode.KMC;		
			var addMetadataProfile:MetadataProfileAdd = new MetadataProfileAdd(_model.selectedMetadataProfile.profile, _model.selectedMetadataProfile.xsd.toXMLString());
			mr.addAction(addMetadataProfile);
			
			//list the latest metadata profiles (after all deletion is done)s
			var filter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			filter.metadataObjectTypeEqual = KalturaMetadataObjectType.ENTRY;
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, _model.metadataFilterPager);
			mr.addAction(listMetadataProfile);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}
		
		/**
		 * Will be called when the result from the server returns 
		 * @param data the data recieved from the server
		 * 
		 */		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			var responseArray:Array = data.data as Array;
			if (responseArray[0].error != null){
				Alert.show(responseArray[0].error.message, ResourceManager.getInstance().getString('account', 'error'));
			} else {
				_model.selectedMetadataProfile.isCurrentlyEdited = false;
			}
			//last request is always the list request
			var listResult:KalturaMetadataProfileListResponse  = responseArray[1]as KalturaMetadataProfileListResponse;
			_model.metadataProfilesTotalCount = listResult.totalCount;
			_model.metadataProfilesArray = ListMetadataProfileUtil.handleListMetadataResult(listResult, _model.context);
		}
		
		/**
		 * Will be called when the request fails 
		 * @param info the info from the server
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