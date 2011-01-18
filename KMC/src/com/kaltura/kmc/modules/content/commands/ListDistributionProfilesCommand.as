package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.distributionProfile.DistributionProfileList;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.model.DistributionProfileInfo;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaDistributionProfileFilter;
	import com.kaltura.vo.KalturaDistributionProfileListResponse;
	
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.xml.SimpleXMLEncoder;

	public class ListDistributionProfilesCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var listDistributionProfile:DistributionProfileList = new DistributionProfileList();
			listDistributionProfile.addEventListener(KalturaEvent.COMPLETE, result);
			listDistributionProfile.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listDistributionProfile);
		}
		
		override public function result(data:Object):void {
			if (data.error) {
				var er:KalturaError = data.error as KalturaError;
				if (er) {
					// ignore service forbidden
					if (er.errorCode != APIErrorCode.SERVICE_FORBIDDEN) {
						Alert.show(er.errorMsg, "Error");
					}
				}
			}
			else {
				handleListDistributionProfileResult(data.data as KalturaDistributionProfileListResponse);
			}
			_model.decreaseLoadCounter();
		}
		
		public function handleListDistributionProfileResult(profilesResult:KalturaDistributionProfileListResponse) : void {
			var profilesArray:Array = new Array();
			//as3flexClient can't generate these objects since we don't include them in the swf 
			for each (var profile:Object in profilesResult.objects) {
				var newProfile:KalturaDistributionProfile = new KClassFactory( KalturaDistributionProfile ).newInstanceFromXML( XMLList(objectToXML(profile)));		
				//fix bug: simpleXmlEncoder not working properly for nested objects
				if (profile.requiredThumbDimensions is Array)
					newProfile.requiredThumbDimensions = profile.requiredThumbDimensions;
				
				profilesArray.push(newProfile);
			}
			_model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray = profilesArray;
		}
		
		/**
		 * This function will convert a given object to an XML 
		 * @param obj
		 * @return 
		 * 
		 */		
		private function objectToXML(obj:Object):XML {
			var qName:QName = new QName("root");
			var xmlDocument:XMLDocument = new XMLDocument();
			var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
			var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
			var xml:XML = new XML(xmlDocument.toString());
			return xml;
		}
		
//		/**
//		 * This function will be called if the request failed
//		 * @param info the info returned from the server
//		 * 
//		 */		
//		override public function fault(info:Object):void
//		{
//			if(info && info.error && info.error.errorMsg && info.error.errorCode != APIErrorCode.SERVICE_FORBIDDEN)
//			{
//				Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//			}
//			_model.decreaseLoadCounter();
//		}
	}
}