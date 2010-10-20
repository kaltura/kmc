package com.kaltura.resources
{
	import mx.resources.ResourceManager;

	public class ResourcesUtils
	{
		/**
		 * Gets the values of a sepcified resource using modifiers for this resource varaitions
		 * @example, A resource with few versions like: plural, singular and inline can be retrieved in one qeury:
		 * <listing version="3.0">ResourcesUtils.getMultipleString('lang', 'USERNAME', '_', "PLURAL", "SINGULAR", "SINGULAR_INLINE")</listing>
		 *
		 * @param bundleName The name of a resource bundle.
		 * @param partialResourceName The partial name of a resource within the resource bundle. Partial means without modifiers (e.g. "PLURAL").
		 * @param seperator A separator to be concatenated between the partialResourceName and a value from the modifiers Array
		 * @param modifiers A list of options that together with the partialResourceName and the separator makes a resource name that is a key for the bundleName.
		 * If a modifier can be evaluated to false, the partialResourceName itself is used as a key to the resource bundle
		 * @return An Array of i18n values composed of the concatenation of partialResourceName, seperator & modifiers.
		 *
		 */
		public static function getMultipleString(bundleName:String, partialResourceName:String, seperator:String, modifiers:Array):Array
		{
			return modifiers.map(
				function(option:Object, index:int, params:Array):String
				{
					var resourceName:String = option ?
						partialResourceName + seperator + option :
						partialResourceName; //if option is evaluated to false, let it be the partialResourceName
					return ResourceManager.getInstance().getString(bundleName, resourceName);
				}
			);
		}
	}
}