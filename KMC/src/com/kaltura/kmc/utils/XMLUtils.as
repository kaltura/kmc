package com.kaltura.kmc.utils
{
	public class XMLUtils {
		
		/**
		 * get a node from an xml file that matches the given path. 
		 * @param xml	xml to search
		 * @param chain	path to desired element
		 * @return 	(hopefully) the desired element
		 */		
		public static function getElement(xml:XML, chain:Array):XML {
			// remove the first element - it directs to the module and isn't relevant anymore.
			chain.shift();
			var lst:XMLList = XMLList(xml);
			
			// get the following node
			for (var i:int = 0; i<chain.length; i++) {
				if (lst) {
					lst = lst.child(chain[i]);
				}
			}
			xml = lst[0];
			return xml;
		}
		
		/**
		 * add all the xml attributes of the given xml as object attributes of the given object. 
		 * @param obj
		 * @param xml
		 */		
		public static function objectAttsFromXML(obj:Object, xml:XML):void {
			var attributes:XMLList = xml.attributes();
			if (!attributes.length())
				return;
			
			for (var i:uint = 0; i < attributes.length(); i++) {
				obj[(attributes[i] as XML).localName()] = (attributes[i] as XML).toString();
			}
		}
	}
}