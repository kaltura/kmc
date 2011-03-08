package com.kaltura.kmc.utils
{
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
		 * @param kmc_name - only if the profile will have the same name it will be enabled in the kmc settings tab
		 * @return arrayCollection
		 */		
		public static function handleListMetadataResult(response:KalturaMetadataProfileListResponse, kmc_name:String) : ArrayCollection 
		{
			var profilesArray:ArrayCollection = new ArrayCollection();
		
			for (var i:int = 0; i< response.objects.length; i++ ) {
				var recievedProfile:KalturaMetadataProfile = response.objects[i] as KalturaMetadataProfile;
				var metadataProfile : KMCMetadataProfileVO = new KMCMetadataProfileVO();
				metadataProfile.profile = recievedProfile;
				//parses only profiles that were created from KMC
				// !!!! Change later to be according to a flag Tantan will add!!!!!!!!
				if (recievedProfile.name == kmc_name) {
					metadataProfile.xsd = new XML(recievedProfile.xsd);
					metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);
				}
					//custom profile
				else {
					metadataProfile.profileDisabled = true;
				}
				
				profilesArray.addItem(metadataProfile);
			}
			
			return profilesArray;
		}
	}
}