package com.kaltura.base.types
{
	/**
	 * This class represents all constants related to the building of an XSD file 
	 * @author Michal
	 * 
	 */	
	public class XSDConstants
	{
		public static const XSD_STRING_TYPE:String = "xsd:string";
		public static const XSD_LONG_TYPE:String = "xsd:long";
		
		public static const TEXT_TYPE:String = "textType";
		public static const DATE_TYPE:String = "dateType";
		public static const LIST_TYPE:String = "listType";
		public static const OBJECT_TYPE:String = "objectType";
		
		public static const EMPTY_XSD:String = '<?xml version="1.0" ?>' + 
				'<schema>' + 
				'</schema>';
		public static const MAIN_ELEMENT:String = '<element name="metadata">' + 
				 '<complexType>'+
				 '<sequence>'+
				 '</sequence>'+
				 '</complexType>'+
				'</element>' ;
		public static const XSD_ELEMENT:String = '<element id="" name="name" minOccurs="0" maxOccurs="">' + 
				'<annotation>' + 
				'<documentation></documentation>'+
				'<appinfo>' + 
				'<label></label>' + 
				'<key></key>' + 
				'<searchable></searchable>' + 
				'<description></description>' + 
				'</appinfo>' +
				'</annotation>' + 
				'</element>';
				
		public static const COMPLEX_TYPE_STRUCTURE:String = '<complexType name="">' + 
				'<simpleContent>' + 
				'<extension base="" />' + 
				'</simpleContent>' + 
				'</complexType>';
				
		public static const SIMPLE_TYPE_STRUCTURE:String = '<simpleType>' + 
				'<restriction base=""/>' + 
				'</simpleType>';
		
		public static const ENUMERATION:String = '<enumeration value=""/>';
				
		public static const NAMESPACE:Namespace = new Namespace("xsd", "http://www.w3.org/2001/XMLSchema");
		
		public static const MAX_OCCURS_SINGLE:String = "1";
		public static const MAX_OCCURS_UNBOUNDED:String = "unbounded";
		
		public static const X_PATH_PREFIX:String = "/*[local-name()='";
		public static const X_PATH_SUFFIX:String = "']";

	}
}