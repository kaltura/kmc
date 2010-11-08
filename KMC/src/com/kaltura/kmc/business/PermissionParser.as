package com.kaltura.kmc.business
{
	/**
	 * This parser receives an XML and knows to build instructions. 
	 * also the parser knows to provide a list of tabs and sub-tabs to hide.
	 * @author Eitan
	 * 
	 */
	public class PermissionParser
	{
		
		private var _permissionXml:XML;
		
		public function PermissionParser()
		{
		}
		
		public function parsePermission(xml:XML):Array
		{
			_permissionXml = xml;
			var array: Array = new Array();
			var allPermissions:XMLList = _permissionXml..permission;
			for each (var permission:XML in allPermissions )
			{
				array = array.concat(permissionInstruction(permission));
			}
			return array;
		}
		
		/**
		 * The function receives an XML, parse it and build an array of object 
		 * where the id relevant objects and the id is the key  
		 * @param permissionXml
		 * 
		 */
		public function permissionInstruction(permissionXml:XML ):Array
		{
			var arr:Array = new Array();
			// parse and build the instructions  
			var uiXmls:XMLList = permissionXml.children();
			for each (var uiXml:XML in uiXmls)
			{
				var uiPath:String = uiXml.@id;
				delete uiXml.@id ; 
				var attributes:XMLList = uiXml.attributes();
				if (! attributes.length())
					break;
				var attributesObject:Object = new Object();
				for (var i:uint = 0 ; i< attributes.length() ; i++)
				{
					attributesObject[(attributes[i] as XML).localName()] = (attributes[i] as XML).toString();
				}
				arr.push({id:uiPath,attributes:attributesObject});
			}
			return arr;
		}
	}
}