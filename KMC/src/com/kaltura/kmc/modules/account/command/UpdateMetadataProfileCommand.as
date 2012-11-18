package com.kaltura.kmc.modules.account.command
{	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.base.types.XSDConstants;
	import com.kaltura.commands.metadataProfile.MetadataProfileUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.business.CustomDataStringUtil;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KalturaMetadataProfile;
	
	import flash.profiler.profile;
	
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
		 * This function will send an update profile request to the server, 
		 * with the current profile id and the current XSD 
		 * @param event the event that triggered this command
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			_model.selectedMetadataProfile.profile.setUpdatedFieldsOnly(true);
			// before sending the xsd to the server, handle "&" in fields of type "list".
			var ns:Namespace = XSDConstants.NAMESPACE; 
			var xsd:XML = _model.selectedMetadataProfile.xsd;
			var enumerations:XMLList = xsd..ns::enumeration;
			/*	<xsd:enumeration value="I"/>
			<xsd:enumeration value="Me"/>
			<xsd:enumeration value="Myself"/>	*/
			var val:String;
			for each (var enum:XML in enumerations) {
				val = enum.@value;
				val = CustomDataStringUtil.escapeAmps(val);
				enum.@value = val;
			}
			
			var updateMetadataProfle:MetadataProfileUpdate = new MetadataProfileUpdate(_model.selectedMetadataProfile.profile.id, _model.selectedMetadataProfile.profile, xsd.toString());
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
			_model.selectedMetadataProfile.isCurrentlyEdited = false;
			if (recievedProfile) {
				_model.selectedMetadataProfile.profile = recievedProfile;
				_model.selectedMetadataProfile.xsd = new XML(recievedProfile.xsd);
				_model.selectedMetadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(_model.selectedMetadataProfile.xsd);
				_model.selectedMetadataProfile.metadataProfileChanged = false;
				_model.selectedMetadataProfile.metadataProfileReordered = false;
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