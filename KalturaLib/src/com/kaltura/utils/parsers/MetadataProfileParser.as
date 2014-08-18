package com.kaltura.utils.parsers
{
	import com.kaltura.base.types.MetadataCustomFieldMaxOccursTypes;
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.base.types.XSDConstants;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import mx.utils.UIDUtil;
	
	/**
	 * This class represents an XSD-MetadataFieldVO-Parser. 
	 * The parser can translate from MetadataFieldVO to XSD and vice versa. 
	 * @author Michal
	 * 
	 */		
	public class MetadataProfileParser
	{	
		/**
		 * Creates a new empty XSD object, containing the four types: textType, dateType, objectType and listType. 
		 * @return the new XSD
		 * 
		 */		
		public static function createNewXSD():XML {
			var xsd:XML = new XML(XSDConstants.EMPTY_XSD);
			xsd.setNamespace(XSDConstants.NAMESPACE);
			var mainElement:XML = createXSDObject(XSDConstants.MAIN_ELEMENT);
			xsd.appendChild(mainElement);
			setXSDTypes(xsd);
			
			return xsd;
		}
		
		/**
		 * adds a given field to a given XSD object 
		 * @param fieldToAdd the field to add
		 * @param xsd the xsd that the field will be added to.
		 * 
		 */		
		public static function addToXSD(fieldToAdd:MetadataFieldVO, xsd:XML):void {
				var newNode:XML = new XML(XSDConstants.XSD_ELEMENT);
				newNode.setNamespace(XSDConstants.NAMESPACE);
				
				newNode.@id = fieldToAdd.id;
				newNode.@name = fieldToAdd.name;
				newNode.@maxOccurs = fieldToAdd.maxNumberOfValues == MetadataCustomFieldMaxOccursTypes.SINGLE ?
				 XSDConstants.MAX_OCCURS_SINGLE : XSDConstants.MAX_OCCURS_UNBOUNDED;
				updateXMLfromField(fieldToAdd, newNode);
				if (fieldToAdd.type != MetadataCustomFieldTypes.LIST)
					newNode.@type = getTypeString(fieldToAdd.type);
				
				//adds under the "element" child
				returnElementNode(xsd).children()[0].children()[0].appendChild(newNode);
		}
		
		/**
		 * Deletes the given field from the xsd 
		 * @param fieldToDelete the field to delete
		 * @param xsd the xsd that the field will be deleted from
		 * 
		 */		
		public static function deleteFieldFromXSD(fieldToDelete:MetadataFieldVO, xsd:XML):void {
			var elements:XMLList = returnElementNode(xsd).children()[0].children()[0].children();
			for each (var element:XML in elements) {
				if (element.@id == fieldToDelete.id) {
					delete element.parent().children()[ element.childIndex() ];
					break;
				}
			}
		}
		
		/**
		 * Updates the given XSD with the values in the MetadataFieldVO 
		 * @param fieldToUpdate the field containing the new values
		 * @param xsd the XSD that will be updated
		 * 
		 */		
		public static function updateFieldOnXSD(fieldToUpdate:MetadataFieldVO, xsd:XML):void {
			var elements:XMLList = returnElementNode(xsd).children()[0].children()[0].children();
			for each (var element:XML in elements) {
				if (element.@id == fieldToUpdate.id) {
					//clean old content
					for each (var info:XML in element.children()[0].children()){
						if (info.localName() =="documentation") 
						{
							delete info.*;
						}
						else
						{
							//all the "appinfo" children
							for each (var node:XML in info.children())
								delete node.*;
						}
					}
					if ((fieldToUpdate.type == MetadataCustomFieldTypes.LIST)
							&& (element.children().length() > 1)) {
						//remove previous optional values
						delete element.children()[1];
					}
					updateXMLfromField(fieldToUpdate, element);
					break;
				}
			}
		}
		
		/**
		 * This function recieves a field and an XSD and will update the
		 * XSD according to the fields params 
		 * @param fieldToUpdate the field containing the new values
		 * @param xml the xml that will be updated
		 * 
		 */		
		private static function updateXMLfromField(fieldToUpdate:MetadataFieldVO, xml:XML):void {
			//sets the appinfo data
			var annotation:XML = xml.children()[0];
			annotation.setNamespace(XSDConstants.NAMESPACE);
			var appInfo:XMLList = annotation.children();
			for each (var info:XML in appInfo) {
				if (info.localName() == "documentation") {
					info.appendChild(fieldToUpdate.fullDescription);
				}
				else {
					for each (var node:XML in info.children()) {
						var name:String = node.localName();
						switch (name) {
							case "label":
								node.appendChild(fieldToUpdate.displayedLabel);
								break;
							case "key":
								node.appendChild(fieldToUpdate.defaultLabel);
								break;
							case "searchable":
								node.appendChild(fieldToUpdate.appearInSearch);
								break;
							case "timeControl":
								node.appendChild(fieldToUpdate.timeControl);
								break;
							case "description":
								node.appendChild(fieldToUpdate.description);
								break;
						}
					}
				}
				
				info.setNamespace(XSDConstants.NAMESPACE);
			}
			
			// in list case- sets the optional values
			if(fieldToUpdate.type == MetadataCustomFieldTypes.LIST) {
				var listValues:XML = createXSDObject(XSDConstants.SIMPLE_TYPE_STRUCTURE);
				var restriction:XML = listValues.children()[0];
				restriction.@base = XSDConstants.LIST_TYPE;
				
				
				for each (var option:String in fieldToUpdate.optionalValues) {
					var enumeration:XML = createXSDObject(XSDConstants.ENUMERATION);
					enumeration.@value = option;
					restriction.appendChild(enumeration);
				}
				xml.appendChild(listValues);
			}
		}
		
		/** 
		 * @param name a given element name
		 * @return valid string to represent the element XPath
		 * 
		 */		
		
		private static function buildXpath(name:String):String {
			var xPathString:String = XSDConstants.X_PATH_PREFIX + name + XSDConstants.X_PATH_SUFFIX;
			return xPathString;
		}

		
		/**
		 * this function gets an XML object an returns a MetadataFieldVO array
		 * that contains an object represantation for this XML 
		 * @param xsd the given XML
		 * @return an ArrayCollection contains MetadataFieldVO objects
		 * 
		 */		
		public static function fromXSDtoArray(xsd:XML):ArrayCollection {
			var fieldsArray:ArrayCollection = new ArrayCollection();
			var root:XML = returnElementNode(xsd);
			if (root && root.children() && root.children().length() )
			{
				var xPathRoot:String = buildXpath(root.@name);
				var	elements:XMLList = root.children()[0].children()[0].children();
				for each (var element:XML in elements) {
					fieldsArray.addItem(fromXSDToField(element, xPathRoot));	
				}
			}
			return fieldsArray;
		}
		
		private static function fromXSDToField(element:XML, xPathRoot:String):MetadataFieldVO {
			
			var field:MetadataFieldVO = new MetadataFieldVO(element.@id);
			field.name = element.@name;
			field.maxNumberOfValues = element.@maxOccurs == XSDConstants.MAX_OCCURS_SINGLE? 
				MetadataCustomFieldMaxOccursTypes.SINGLE : MetadataCustomFieldMaxOccursTypes.UNBOUND;
			field.type = setFieldType(element);
			field.xpath = xPathRoot + buildXpath(element.@name); 
			
			var appInfo:XMLList = element.children()[0].children();
			
			for each (var info:XML in appInfo) {
				var childsName:String = info.localName();
				if (childsName =="documentation") {
					field.fullDescription = info.text();
				}
				else {
					for each (var node:XML in info.children()) {
						var name:String = node.name();
						switch (name) {
							case "label":
								field.displayedLabel = node.text();
							case "key":
								field.defaultLabel = node.text();
								break;
							case "searchable":
								field.appearInSearch = node.text() == "true";
								break;
							case "timeControl":
								field.timeControl = node.text() == "true";
								break;
							case "description":
								field.description = node.text();
								break;
						}
					}
				}
			}
			var children:XMLList = element.children();
			if (children.length()>1) {
				//nested elements
				if (XML(children[1]).name().localName == XSDConstants.COMPLEX_TYPE) {
					var sequence:XML = children[1].children()[0];
					if (sequence.name().localName == XSDConstants.SEQUENCE_TYPE) {
						for each (var nestedElement:XML in sequence.children()) {
							var nestedField:MetadataFieldVO = fromXSDToField(nestedElement, field.xpath);
							// if any of the nested fields are searchable, make the parent field searcheable too
							if (nestedField.appearInSearch) {
								field.appearInSearch = true;
							}
							field.nestedFieldsArray.addItem(nestedField);
						}
					}
				}
				else if (field.type == MetadataCustomFieldTypes.LIST) {
					var enumerations:XMLList = children[1].children()[0].children();
					for each (var enum:XML in enumerations) {
						var newEnum:String = enum.@value;
						field.optionalValues.push(newEnum);
					}
				}
				
			}
			
			return field;
		}
		
		/**
		 * This function gets a MetadataFieldVO arrayCollection and returns
		 * an XML represnets the suitable XSD for this array 
		 * @param array contains MetadataFieldVO objects
		 * @return XML represents the suitable XSD
		 * 
		 */		
		public static function fromArrayToXSD(array:ArrayCollection):XML {
			var xsd:XML = new XML(XSDConstants.EMPTY_XSD);
			xsd.setNamespace(XSDConstants.NAMESPACE);
			var mainElement:XML = createXSDObject(XSDConstants.MAIN_ELEMENT);
			xsd.appendChild(mainElement);
			
			for each (var item:Object in array) {
				addToXSD(MetadataFieldVO(item), xsd);
			}
			
			setXSDTypes(xsd);
			
			return xsd;
		}
		
		/**
		 * This function recieves an XSD object and inserts 4 types to it:
		 * textType, dateType, listType and objectType 
		 * @param xsd the given xsd to update
		 * 
		 */		
		private static function setXSDTypes(xsd:XML):void {
			//textType
			var textTypeXML:XML = createXSDObject(XSDConstants.COMPLEX_TYPE_STRUCTURE);
			textTypeXML.@name = XSDConstants.TEXT_TYPE;
			textTypeXML.children()[0].children()[0].@base = XSDConstants.XSD_STRING_TYPE;
			//dateType
			var dateTypeXML:XML = createXSDObject(XSDConstants.COMPLEX_TYPE_STRUCTURE);
			dateTypeXML.@name = XSDConstants.DATE_TYPE;
			dateTypeXML.children()[0].children()[0].@base = XSDConstants.XSD_LONG_TYPE;
			//objectType
			var objectTypeXML:XML = createXSDObject(XSDConstants.COMPLEX_TYPE_STRUCTURE);
			objectTypeXML.@name = XSDConstants.OBJECT_TYPE;
			objectTypeXML.children()[0].children()[0].@base = XSDConstants.XSD_STRING_TYPE;
			//listType
			var listTypeXML:XML = createXSDObject(XSDConstants.SIMPLE_TYPE_STRUCTURE);
			listTypeXML.@name = XSDConstants.LIST_TYPE;
			listTypeXML.children()[0].@base = XSDConstants.XSD_STRING_TYPE;
			
			xsd.appendChild(textTypeXML);
			xsd.appendChild(dateTypeXML);
			xsd.appendChild(objectTypeXML);
			xsd.appendChild(listTypeXML);
		}
		
		
		/**
		 * this function creates a valid xsd object from an input string -->adds the "xsd:" namespace to all nodes
		 * */
		private static function createXSDObject(inputString:String):XML {
			var xml:XML = new XML(inputString);
			xml.setNamespace(XSDConstants.NAMESPACE);
			var node:XML = xml;
			while (node.children().length() > 0) {
				node = node.children()[0];
				node.setNamespace(XSDConstants.NAMESPACE);
			}
			
			return xml;
		}
		
		
		/**
		 * This function returns a string representation that will describe the 
		 * field's type in the XSD 
		 * @param type the given type
		 * @return a string representation for this type
		 * 
		 */		
		private static function getTypeString(type:int):String {
			var typeString:String;
			
			switch (type) {
				case MetadataCustomFieldTypes.TEXT:
					typeString = XSDConstants.TEXT_TYPE;
					break;
				case MetadataCustomFieldTypes.DATE:
					typeString = XSDConstants.DATE_TYPE;
					break;
				case MetadataCustomFieldTypes.OBJECT:
					typeString = XSDConstants.OBJECT_TYPE;
					break;
				case MetadataCustomFieldTypes.LIST:
					typeString = XSDConstants.LIST_TYPE;
					break;
			}
			
			return typeString;
		}
		
		/**
		 * returns the suitable MetadataCustomFieldsType 
		 * @param type the string that represents the type
		 * @return the type
		 * 
		 */		
		private static function setFieldType(element:XML):int {
			var typeResult:int;
			var type:String = element.@type;
			switch (type) {
				case XSDConstants.TEXT_TYPE:
					typeResult = MetadataCustomFieldTypes.TEXT
					break;
				case XSDConstants.DATE_TYPE: 
					typeResult = MetadataCustomFieldTypes.DATE;
					break;
				case XSDConstants.OBJECT_TYPE: 
					typeResult = MetadataCustomFieldTypes.OBJECT;
					break;
				case XSDConstants.LIST_TYPE:
					typeResult = MetadataCustomFieldTypes.LIST;
					break;
				default:
					// no type, if has children it's a container, otherwise set to list for BW compat.
					typeResult = MetadataCustomFieldTypes.LIST;
					var children:XMLList = element.children(); 
					if (children.length() > 1) {
						if (XML(children[1]).name().localName == XSDConstants.COMPLEX_TYPE) {
							typeResult = MetadataCustomFieldTypes.CONTAINER;		
						}
					}
					break;
			}
			
			return typeResult;
		}
		
		/**
		 * returns the element node
		 * */
		private static function returnElementNode(input:XML):XML {
			//first searches the "element" node index
			var elementIndex:int = -1;
			for each (var node:XML in input.children()) {
				var nodeName:String = node.localName();
				if (nodeName == "element") {
					elementIndex = node.childIndex();
					break
				}
			}
			return (input.children()[elementIndex] && input.children()[elementIndex] is XML) ? input.children()[elementIndex] : new XML();
		}

	}
	
}