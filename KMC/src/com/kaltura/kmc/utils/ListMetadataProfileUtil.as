package com.kaltura.kmc.utils
{
	import com.kaltura.kmc.modules.account.model.Context;
	import com.kaltura.types.KalturaMetadataProfileCreateMode;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	
	import mx.collections.ArrayCollection;

	/**
	 * This class it intended for creating a "listMetadataProfile" request
	 * and handling the response. Since the "list" request is sent from various places we will handle the result in this util. 
	 * @author Michal
	 * 
	 */	
	public class ListMetadataProfileUtil
	{
		/**
		 * This function will parse the given object and return an arrayCollection of the 
		 * suitable KMCMetadataProfileVO classes 
		 * @param response is the KalturaMetadataProfileList response, returned from the server
		 * @param context is the Context that will be used for the download url
		 * @return arrayCollection
		 */		
		public static function handleListMetadataResult(response:KalturaMetadataProfileListResponse, context:Context) : ArrayCollection 
		{
			var profilesArray:ArrayCollection = new ArrayCollection();
		
			for (var i:int = 0; i< response.objects.length; i++ ) {
				var recievedProfile:KalturaMetadataProfile = response.objects[i] as KalturaMetadataProfile;
				if (!recievedProfile)
					continue;
				var metadataProfile : KMCMetadataProfileVO = new KMCMetadataProfileVO();
				metadataProfile.profile = recievedProfile;
				metadataProfile.downloadUrl = context.kc.protocol + context.kc.domain + KMCMetadataProfileVO.serveURL + "/ks/" + context.kc.ks + "/id/" + recievedProfile.id;
				//parses only profiles that were created from KMC
				//change later to refer only to creation mode=kmc
				if (!(recievedProfile.createMode) || (recievedProfile.createMode == KalturaMetadataProfileCreateMode.KMC)) {
					metadataProfile.xsd = new XML(recievedProfile.xsd);
					metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);
				}
				//none KMC profile
				else {
					metadataProfile.profileDisabled = true;
				}
				
				profilesArray.addItem(metadataProfile);
			}
			
			return profilesArray;
		}
	}
}