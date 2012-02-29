package com.kaltura.edw.business
{
	import com.kaltura.base.types.MetadataCustomFieldMaxOcuursTypes;
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.model.MetadataDataObject;
	import com.kaltura.edw.vo.EntryMetadataDataVO;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DateField;
	
	/**
	 * This static class provides different functionalities to handle metadataDataObject  
	 * @author Michal
	 * 
	 */	
	public class MetadataDataParser
	{
		public static const METADATA_ROOT:String = "<metadata/>";
		
		
		/**
		 * This function transforms a given metadataDataObject to a valid metadataData XML
		 * by handling different cases for different field types. 
		 * if a field in the profile has no value, the function will create an 
		 * empty node for it only if previously there was one.   
		 * @param entryMetadata		entry metadata with new values to transform to XML and old saved data
		 * @param metadataProfile	the profile this metadata matches
		 * @return a valid metadataData XML
		 */		
		public static function toMetadataXML(entryMetadata:EntryMetadataDataVO, metadataProfile:KMCMetadataProfileVO):XML {
			var result:XML = new XML(METADATA_ROOT);
			var metadataObject:MetadataDataObject = entryMetadata.metadataDataObject;
			
			for each (var curField:MetadataFieldVO in metadataProfile.metadataFieldVOArray) {
				var attr:String = curField.name;
				if (metadataObject[attr]) {
					// nodes with value
					addNode(attr, metadataObject, curField, result);
				}
				else if (entryMetadata.metadata && entryMetadata.metadata.xml){
					// add empty nodes only if previously saved data contained empty nodes.
					// look for node of same name in old data:
					var oldNode:XMLList = XML(entryMetadata.metadata.xml).descendants(attr); 
					if (oldNode.length() == 1 && oldNode[0].children().length() == 0) {
						// the old node was empty, create empty node:
						var valueNode:XML = getNode(attr, null);
						result.appendChild(valueNode);
					}
				}
			}
			
			return result;
		}
		
		
		/**
		 * This function sorts the attributes from the given metadataDataObject and returns the sorted attributes 
		 * @param metadataObject hte object to sort its' attributes
		 * @return the sorted attributes in an array
		 * 
		 */		
		public static function sortAttributes(metadataObject:MetadataDataObject):Array {
			var attributes:Array = new Array();
			for (var attr:String in metadataObject) {
				attributes.push(attr);
			}
			return attributes.sort();
		}
		
		/**
		 * This function adds the suitable node to the given parent 
		 * @param attr the attribute to add its' value to the XML
		 * @param metadataObject the current metadataDataObject
		 * @param parent the XML to add the new node to
		 * @param parentAttr if not null, this will be the name of the new child node,
		 * 	 otherwise the name will be the attribute name
		 * 
		 */		
		private static function addNode(attr:String ,metadataObject:MetadataDataObject, currField:MetadataFieldVO, result:XML,parentAttr:String=null):void {
			var node:XML;
			
			if (currField.type == MetadataCustomFieldTypes.OBJECT)
			{
				handleEntryIdList(attr, metadataObject[attr], result);
			}
			else if (metadataObject[attr] is MetadataDataObject) {
				var nestedMetadata:MetadataDataObject = MetadataDataObject(metadataObject[attr]);
				var attributes:Array = sortAttributes(nestedMetadata);
				
				if (currField.nestedFieldsArray && currField.nestedFieldsArray.length>0) {
					if (currField.maxNumberOfValues == MetadataCustomFieldMaxOcuursTypes.UNBOUND) {
						for each (var attribute:String in attributes) {
							node = getNode(attr, parentAttr);	
							result.appendChild(node);
							setNodesForFieldsArray(attribute, nestedMetadata[attribute], currField.nestedFieldsArray, node);
							if (node.children().length()==0) {
								var indexToDelete:int = node.childIndex();
								delete (result.children()[indexToDelete]);
							}
						}
					}
					else {
						node = getNode(attr, parentAttr);	
						result.appendChild(node);
						setNodesForFieldsArray(attr, nestedMetadata, currField.nestedFieldsArray, node);
						if (node.children().length()==0) {
							var index:int = node.childIndex();
							delete (result.children()[index]);
						}
					}
					
				}
				else
				{				
					for each (var nestedAttr:String in attributes) {
						addNode(nestedAttr, nestedMetadata, currField, result, attr);
					}
				}
			}
			else 
			{
				var valueNode:XML= getNode(attr, parentAttr);
				var value:String = getSuitableString(metadataObject[attr], attr);
				//empty field won't be added
				if (!value)
					return;
				else 
					valueNode.appendChild(value);
				
				result.appendChild(valueNode);
			}
			
		}
		
		private static function getNode(attribute:String, parentAttribute:String):XML {
			var nodeName:String = parentAttribute ? parentAttribute : attribute;
			var xml:XML =  new XML("<"+nodeName+"/>");
			return xml;
		}
		
		private static function setNodesForFieldsArray(attributeName:String, metadataObject:MetadataDataObject, fieldsArray:ArrayCollection, result:XML):void {	
			for each (var nestedField:MetadataFieldVO in fieldsArray) {
				var nestedAttribute:String = nestedField.name;
				
				if (metadataObject[nestedAttribute]) {
					addNode(nestedAttribute, metadataObject, nestedField, result);
				}
			}
		}
		
		/**
		 * handles the special case of an Object type metadata entry:
		 * takes the given entries arrayCollection ans splits it to the entry id values
		 * @param name the name of the field
		 * @param input the value that should be transformed
		 * @param parent the XML that will be returned eventually
		 * 
		 */		
		private static function handleEntryIdList(name:String, input:Object, parent:XML):void {
			var array:ArrayCollection = input as ArrayCollection;
			for each (var entry:Object in array) {
				var node:XML = new XML("<"+name+"/>");
				var id:String = (entry as KalturaBaseEntry).id;
				node.appendChild(id);
				parent.appendChild(node);
			}
		}
		
		/**
		 * returns the suitable string represantation for the given metadata input 
		 * @param input the given metadata input
		 * @param arr the splited field's name
		 * @return the suitable string to be added to the metadataData XML
		 * 
		 */		
		private static function getSuitableString(input:Object, attrName:String):String {
			var validString:String;
			if (input is Date) {
				//gets the time and moves it to seconds
				var time:Number =  (input.time)/1000;
				validString = time.toString();
			}
				//list of checkBoxes
			else if (input is Boolean){
				//will add only if value was true
				if (input) {
					//	validString = HtmlEncodeDecode.encode(attrName);
					validString = attrName;
				}
			}
			else if (input is String) {
				//var check:String = escape(input as String);
				//	validString = HtmlEncodeDecode.encode(input as String);
				validString = (input as String);
			}
			
			return validString;
		}
		
		/**
		 * convert metadata XML data to hashmaps, including nesting support
		 * @param metadataXml	metadata values in XML form
		 * @return HashMap where for each field name there is a list of field values (as Strings)
		 */		
		public static function getMetadataDataValues(metadataXml:XML):HashMap 
		{
			var dataValues:HashMap = new HashMap();
			for each (var node:XML in metadataXml.children()) 
			{
				var fieldName:String = node.localName();
				var updatedArray:Array;
				
				if (dataValues.containsKey(fieldName)) 
				{
					updatedArray = dataValues.getValue(fieldName);
				}	
				else {
					updatedArray = new Array();
				}
				
				var value:String = node.text().toString();
				
				//case of nested metadata
				if (value=="" && node.children().length()>0) {
					updatedArray.push(getMetadataDataValues(node));
				}
				else /*if (value!="")*/	{
					updatedArray.push(value);
				}
				
				dataValues.put(fieldName, updatedArray);
			}
			
			return dataValues;
		}
		
		/**
		 * compares between two xmls, first translates them to hashmaps 
		 * (if there are childs with identical names, collects all their values) 
		 * @param xml1
		 * @param xml2
		 * @return true if identical, otherwise false 
		 * 
		 */		
		public static function compareMetadata(xml1:XML,xml2:XML):Boolean
		{
			var data1:HashMap = getMetadataDataValues(xml1);
			var data2:HashMap = getMetadataDataValues(xml2);
			
			return compareMetadataHashMaps(data1, data2);
		}
		
		/**
		 * this function compares between two given hashmaps. also compares complex hashmaps, i.e nested hashmaps 
		 * @param data1 the first hashmap to compare
		 * @param data2 the second hashmap to compare
		 * @return true if the two are identical, otherwhise false
		 * 
		 */		
		private static function compareMetadataHashMaps(data1:HashMap, data2:HashMap):Boolean {
			//run on obj1, check if the value exist in ob2 and check its value
			for (var o:String in data1)
			{
				if (data2.containsKey(o))
				{	
					var arr1:ArrayCollection = new ArrayCollection(data1.getValue(o));
					var arr2:ArrayCollection = new ArrayCollection(data2.getValue(o));
					for each (var val:Object in arr1) {
						//nested metadata
						if (val is HashMap) {
							if (!compareNestedHashMaps((val as HashMap), arr2))
								return false;
						}
						else if (!arr2.contains(val))
							return false;
					}
					
					for each (var val2:Object in arr2) {
						//nested metadata
						if (val2 is HashMap) {
							if (!compareNestedHashMaps((val2 as HashMap), arr1))
								return false;
						}
						else if (!arr1.contains(val2))
							return false;
					}	
				}
				else 
				{
					return false;
				}
			} 
			//run on obj2, check if the value exist in ob1 and check its value
			for (var p:String in data2)
			{
				if (!data1.containsKey(p))
				{
					return false;	
				}
				
			} 
			
			return true;
		}
		
		/**
		 * This function checks if the given hashmap exists in the given array
		 * @param value the given hashmap to check
		 * @param arrayToSearch the given array to look for the hashmap in
		 * @return true if exists, otherwhise false
		 * 
		 */		
		private static function compareNestedHashMaps(value:HashMap, arrayToSearch:ArrayCollection):Boolean {
			for each (var hashMapVal:Object in arrayToSearch) {
				if ((hashMapVal is HashMap) && compareMetadataHashMaps(value, (hashMapVal as HashMap))) {
					return true;
				}
				
			}
			
			return false;
		}
	}	
	
}