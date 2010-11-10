package com.kaltura.kmc.modules.content.utils
{
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.model.MetadataDataObject;
	import com.kaltura.dataStructures.HashMap;
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
		/**
		 * This function transforms a given metadataDataObject to a valid metadataData XML
		 * by handling different cases for different field types 
		 * @param metadataObject the given MetadataDataObject
		 * @return a vaid metadataData XML
		 * 
		 */		
		public static function toMetadataXML(metadataObject:MetadataDataObject, metadataProfile:KMCMetadataProfileVO):XML {
			var result:XML = new XML("<metadata/>");

			for each (var curField:MetadataFieldVO in metadataProfile.metadataFieldVOArray) {
				var attr:String = curField.name;
				if (metadataObject[attr]) {
					if (metadataObject[attr] is MetadataDataObject) {
						var nestedMetadata:MetadataDataObject = MetadataDataObject(metadataObject[attr]);
						var attributes:Array = sortAttributes(nestedMetadata);
						for each (var nestedAttr:String in attributes) {
							addNode(nestedAttr, nestedMetadata, result, attr);
						}
					}
					
					else if (curField.type == MetadataCustomFieldTypes.OBJECT)
					{
						handleEntryIdList(attr, metadataObject[attr], result);
					}
					else 
					{
						addNode(attr, metadataObject, result);
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
		private static function sortAttributes(metadataObject:MetadataDataObject):Array {
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
		private static function addNode(attr:String ,metadataObject:MetadataDataObject, parent:XML, parentAttr:String = null):void {
			var node:XML;
			if (parentAttr)
				node= new XML("<"+parentAttr+"/>");
			else 
				node= new XML("<"+attr+"/>");
			var value:String = getSuitableString(metadataObject[attr], attr);
			//empty field won't be added
			if (!value)
				return;
			else 
				node.appendChild(value);
			parent.appendChild(node);
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
		 * This function recieves metadata data in XML form 
		 * and returns an arrayCollection, with the values from the XML represented by MetadataDataVO objects
		 * */
		public static function getMetadataDataValues(metadataXml:XML):HashMap 
		{
			var dataValues:HashMap = new HashMap();
			for each (var node:XML in metadataXml.children()) 
			{
				var currentField:String = node.localName();
				var updatedArray:Array = new Array();
				if (dataValues.containsKey(currentField)) 
				{
					updatedArray = dataValues.getValue(currentField);
				}			
				updatedArray.push(node.text().toString());
				dataValues.put(currentField, updatedArray);
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
			
			//run on obj1, check if the value exist in ob2 and check its value
			for (var o:String in data1)
			{
				if (data2.containsKey(o))
				{	
					var arr1:ArrayCollection = new ArrayCollection(data1.getValue(o));
					var arr2:ArrayCollection = new ArrayCollection(data2.getValue(o));
					for each (var val:String in arr1) {
						if (!arr2.contains(val))
							return false;
					}
					for each (var val2:String in arr2) {
						if (!arr1.contains(val2))
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
		

	}
}