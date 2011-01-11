package com.kaltura.kmc.modules.account.command
{	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KalturaMetadataProfile;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	/**
	 * This class is used for sending requests to update metadata profile 
	 * @author Michal
	 * 
	 */	
	public class UpdateMetadataProfileCommand implements ICommand, IResponder {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		/**
		 * This function will send an update profile request to the server, with the current profile id and the current XSD 
		 * @param event the event that triggered this command
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			var updateMetadataProfle:MetadataProfileUpdate = new MetadataProfileUpdate(_model.metadataProfile.profile.id, new KalturaMetadataProfile(), _model.metadataProfile.xsd.toString());
			updateMetadataProfle.addEventListener(KalturaEvent.COMPLETE, result);
			updateMetadataProfle.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updateMetadataProfle); 
		}
		
		/**
		 * This function handles response from the server 
		 * @param data the data returned from the server
		 * 
		 */		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			var recievedProfile:KalturaMetadataProfile = KalturaMetadataProfile(data.data);
			if (recievedProfile) {
				_model.metadataProfile.profile = recievedProfile;
				_model.metadataProfile.xsd = new XML(recievedProfile.xsd);
				_model.metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(_model.metadataProfile.xsd);
			}	
		}
		
		/**
		 * This function will be called if the request had failed 
		 * @param info the info returned from the server
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