package com.kaltura.edw.business
{
	import com.kaltura.core.KClassFactory;
	
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.rpc.xml.SimpleXMLEncoder;

	public class ClientUtil
	{
		/**
		 * create a new instance of RequiredClass with attributes values taken from sourceObj.
		 * assumption is that sourceObj is an instance of a subclass of RequiredClass which
		 *  the client failed to create because it is not compiled into KMC (ie different 
		 *  distribution profiles, storage profiles, etc)
		 * @param RequiredClass	class reference
		 * @param sourceObj	
		 * @return an instance of class RequiredClass
		 */
		public static function createClassInstanceFromObject(RequiredClass:Class, sourceObj:Object):* {
			return new KClassFactory(RequiredClass).newInstanceFromXML( XMLList(objectToXML(sourceObj)));
		}
		
		
		
		/**
		 * This function will convert a given object to an XML 
		 * @param obj
		 * @return 
		 */		
		private static function objectToXML(obj:Object):XML {
			var qName:QName = new QName("root");
			var xmlDocument:XMLDocument = new XMLDocument();
			var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
			var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
			var xml:XML = new XML(xmlDocument.toString());
			return xml;
		}
	}
}