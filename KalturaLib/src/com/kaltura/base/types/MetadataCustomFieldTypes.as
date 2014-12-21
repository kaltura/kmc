package com.kaltura.base.types
{
	public class MetadataCustomFieldTypes
	{
		static public const TEXT:int = 0;
		static public const DATE:int = 1;
		static public const LIST:int = 2;
		static public const OBJECT:int = 3;
		
		/**
		 * no type in xsd, and has child fields.
		 * this const doesn't have a match in server consts. 
		 */
		static public const CONTAINER:int = 44;
		
		
	}
}