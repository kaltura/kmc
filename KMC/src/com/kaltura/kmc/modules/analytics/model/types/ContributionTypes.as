package com.kaltura.kmc.modules.analytics.model.types
{
	import com.kaltura.types.KalturaSearchProviderType;
	import com.kaltura.types.KalturaSourceType;
	
	import mx.resources.ResourceManager;

	public class ContributionTypes
	{
		public static function getContributionType(type:int):String
		{
			switch (type)
			{
				// mix entries have no source attribute in DB, so we get -1 for them.
				case -1:
					return ResourceManager.getInstance().getString('sourceTypes', 'UNKNOWN');
					break;
				case int(KalturaSourceType.FILE):
					return ResourceManager.getInstance().getString('sourceTypes', 'FILE');
					break;
				case int(KalturaSourceType.SEARCH_PROVIDER):
					return ResourceManager.getInstance().getString('sourceTypes', 'SEARCH_PROVIDER');
					break;
				case int(KalturaSourceType.URL):
					return ResourceManager.getInstance().getString('sourceTypes', 'URL');
					break;
				case int(KalturaSourceType.WEBCAM):
					return ResourceManager.getInstance().getString('sourceTypes', 'WEBCAM');
					break;
				case KalturaSearchProviderType.FLICKR:
					return ResourceManager.getInstance().getString('sourceTypes', 'FLICKR');
					break;
				case KalturaSearchProviderType.ARCHIVE_ORG:
					return ResourceManager.getInstance().getString('sourceTypes', 'ARCHIVE_ORG');
					break;
				case KalturaSearchProviderType.CCMIXTER:
					return ResourceManager.getInstance().getString('sourceTypes', 'CCMIXTER');
					break;
				case KalturaSearchProviderType.CURRENT:
					return ResourceManager.getInstance().getString('sourceTypes', 'CURRENT');
					break;
				case KalturaSearchProviderType.JAMENDO:
					return ResourceManager.getInstance().getString('sourceTypes', 'JAMENDO');
					break;
				case KalturaSearchProviderType.KALTURA:
					return ResourceManager.getInstance().getString('sourceTypes', 'KALTURA');
					break;
				case KalturaSearchProviderType.KALTURA_PARTNER:
					return ResourceManager.getInstance().getString('sourceTypes', 'KALTURA_PARTNER');
					break;
				case KalturaSearchProviderType.KALTURA_USER_CLIPS:
					return ResourceManager.getInstance().getString('sourceTypes', 'KALTURA_USER_CLIPS');
					break;
				case KalturaSearchProviderType.MEDIA_COMMONS:
					return ResourceManager.getInstance().getString('sourceTypes', 'MEDIA_COMMONS');
					break;
				case KalturaSearchProviderType.METACAFE:
					return ResourceManager.getInstance().getString('sourceTypes', 'METACAFE');
					break;
				case KalturaSearchProviderType.MYSPACE:
					return ResourceManager.getInstance().getString('sourceTypes', 'MYSPACE');
					break;
				case KalturaSearchProviderType.NYPL:
					return ResourceManager.getInstance().getString('sourceTypes', 'NYPL');
					break;
				case KalturaSearchProviderType.PHOTOBUCKET:
					return ResourceManager.getInstance().getString('sourceTypes', 'PHOTOBUCKET');
					break;
				case KalturaSearchProviderType.YOUTUBE:
					return ResourceManager.getInstance().getString('sourceTypes', 'YOUTUBE');
					break;
				case KalturaSearchProviderType.SEARCH_PROXY:
					return ResourceManager.getInstance().getString('sourceTypes', 'SEARCH_PROXY');
					break;
			}

			return "";
		}
	}
}