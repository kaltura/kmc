package com.kaltura.utils
{
	import mx.resources.IResourceBundle;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;

	[ResourceBundle("kplayer")]
	[ResourceBundle("kplayerelements")]
	public class KPlayerUtil
	{
		/**
		 * add attributes on the given objects so when used as player flashvars, will override strings 
		 * @param obj
		 * @return 
		 * 
		 */
		public static function overrideStrings(obj:Object) :Object
		{
			// get the kplayer resource bundle
			var rm:IResourceManager = ResourceManager.getInstance();
			var bundle:IResourceBundle = rm.getResourceBundle(rm.localeChain[0], 'kplayer'); 
			if (bundle) {
				// get all the available strings
				for (var key:String in bundle.content) {
					// put them on the object with correct format: strings.ENTRY_CONVERTING
					obj["strings." + key] = bundle.content[key]; 
				}
			}
			return obj;
		}
		
		public static function overrideElementStrings(obj:Object) :Object {
			// get the kplayer resource bundle
			var rm:IResourceManager = ResourceManager.getInstance();
			var bundle:IResourceBundle = rm.getResourceBundle(rm.localeChain[0], 'kplayerelements'); 
			if (bundle) {
				// get all the available strings
				for (var key:String in bundle.content) {
					// put them on the object with correct format: strings.ENTRY_CONVERTING
					obj[key] = bundle.content[key]; 
				}
			}
			return obj;
		}
	}
}