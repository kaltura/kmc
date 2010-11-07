package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KalturaMetadataProfile;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	/**
	 * This class handles the addition of a new profile to the current partner 
	 * @author Michal
	 * 
	 */	
	public class AddMetadataProfileCommand implements ICommand, IResponder {
		
		private var _model:KMCModelLocator = KMCModelLocator.getInstance();
		
		/**
		 * Will send a MetadataProfileAdd request with the current XSD. 
		 * @param event the event that triggered this command.
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			//creates a new metadataProfile
			var profile:KalturaMetadataProfile = new KalturaMetadataProfile();
			profile.metadataObjectType = KalturaMetadataObjectType.ENTRY;
			profile.name = _model.context.metadataProfileName;
			
			var addMetadataProfile:MetadataProfileAdd = new MetadataProfileAdd(profile, _model.metadataProfile.xsd.toXMLString());
			addMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
			addMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addMetadataProfile);
		}
		
		/**
		 * Will be called when the result from the server returns 
		 * @param data the data recieved from the server
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
		 * Will be called when the request fails 
		 * @param info the info from the server
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
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('kmc', 'error'));

		}
	
	}
}