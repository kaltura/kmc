package com.kaltura.kmc.modules.content.utils {
	import com.kaltura.base.types.MetadataCustomFieldMaxOcuursTypes;
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.model.MetadataDataObject;
	import com.kaltura.kmc.modules.content.model.types.CustomMetadataConstantTypes;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.customDataComponents.EntryIDLinkTable;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.customDataComponents.MultiComponent;
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.commands.uiConf.UiConfGet;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaUiConf;
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.controls.Alert;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.resources.ResourceManager;

	public class FormBuilder {
		private static const FIELDS_GAP:int = 10;

		private static var _model:CmsModelLocator = CmsModelLocator.getInstance();


		/**
		 *
		 * @param mxml the fields mxml view
		 * @param metadataData the existing data of current entry
		 * @return a new mxml with the existing data in the fields nodes, under the "text" property
		 *
		 */
		public static function updateMultiTags():void {
			var metadataInfo:EntryMetadataDataVO = _model.entryDetailsModel.metadataInfo;
			if (!metadataInfo)
				return;
			if (!metadataInfo.metadata) {
				metadataInfo.finalViewMxml = _model.filterModel.metadataProfile.viewXML.copy();
				return;
			}

			var mxml:XML = _model.filterModel.metadataProfile.viewXML.copy();
			var metadataData:XML = new XML(metadataInfo.metadata.xml);

			var dataMap:HashMap = MetadataDataParser.getMetadataDataValues(metadataData);
			//represent which property in the component saves the metadata data
			var metadataDataAttribute:String;
			for each (var field:XML in mxml.children()) {
				if (field.@id == CustomMetadataConstantTypes.MULTI) {
					if (field.children() && dataMap.containsKey(field.children()[0].@name)) {
						var valuesArr:Array = dataMap.getValue(field.children()[0].@name);
						if (valuesArr && valuesArr.length > 0) {
							metadataDataAttribute = field.children()[0].@metadataData;
							field.children()[0].@[metadataDataAttribute] = valuesArr[0];
							//adds more fields according to data values
							for (var i:int = 1; i < valuesArr.length; i++) {
								var newChild:XML = field.children()[0].copy();
								newChild.@[metadataDataAttribute] = valuesArr[i];
								field.appendChild(newChild);
							}
						}
					}
				}
				else if (dataMap.containsKey(field.@name) && dataMap.getValue(field.@name) &&
					dataMap.getValue(field.@name).length > 0) {
					var arrayOfValues:Array = dataMap.getValue(field.@name);
					//searches for all selected check boxes and marks them as selected
					if (field.@id == CustomMetadataConstantTypes.VBox) {
						for each (var option:XML in field.children()) {
							for each (var selectedVals:Object in arrayOfValues) {
								if (selectedVals.toString() == option.@label) {
									option.@selected = "true";
									break;
								}
							}
						}
					}
					else {
						metadataDataAttribute = field.@metadataData;
						//in linked entry we want all the values array
						if (field.@id == CustomMetadataConstantTypes.ENTRY_LINK_TABLE)
							field.@[metadataDataAttribute] = dataMap.getValue(field.@name);
						else
							field.@[metadataDataAttribute] = dataMap.getValue(field.@name)[0];
					}
				}
			}

			metadataInfo.finalViewMxml = mxml;
		}


		/**
		 * will set the viewXML in the model
		 * @param uicondId id of uiconf to get
		 *
		 */
		public static function setViewXML(uicondId:int):void {
			var uiconfRequest:UiConfGet = new UiConfGet(uicondId);
			uiconfRequest.addEventListener(KalturaEvent.COMPLETE, uiconfResult);
			uiconfRequest.addEventListener(KalturaEvent.FAILED, uiconfFault);
			_model.context.kc.post(uiconfRequest);
		}


		/**
		 * sets in the model the suitable mxml for the ui represantation.
		 * It is done according to the default view xml and the fieldsArray.
		 * */
		public static function buildInitialMxml():void {
			var fieldsArray:ArrayCollection = _model.filterModel.metadataProfile.metadataFieldVOArray;
			var viewXml:XML = _model.filterModel.metadataProfile.viewXML;
			if (!fieldsArray || !viewXml)
				return;

			var componentsMap:HashMap = getValuesFromView(viewXml);
			var mxml:XML = new XML("<layout/>");

			for each (var field:MetadataFieldVO in fieldsArray) {
				//represents the xml node that a component will be added to
				var parent:XML = mxml;
				var multi:Boolean = false;

				if (field.maxNumberOfValues == MetadataCustomFieldMaxOcuursTypes.UNBOUND) {
					multi = true;
					//List and Entry-ID linked list behaves different
					if (field.type != MetadataCustomFieldTypes.LIST &&
						field.type != MetadataCustomFieldTypes.OBJECT) {
						var multiNode:XML = XML(componentsMap.getValue(CustomMetadataConstantTypes.MULTI)).copy();
						multiNode.@name = field.name;
						multiNode.@label = field.displayedLabel;
						mxml.appendChild(multiNode);
						parent = multiNode;
					}
				}
				var fieldNode:XML;
				switch (field.type) {
					case MetadataCustomFieldTypes.TEXT:
						if (multi) {
							fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.TEXT_INPUT)).copy();
						}
						else {
							fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.TEXT_AREA)).copy();
						}
						break;
					case MetadataCustomFieldTypes.DATE:
						fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.DATE_FIELD)).copy();
						break;
					case MetadataCustomFieldTypes.OBJECT:
						fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.ENTRY_LINK_TABLE)).copy();
						if (!multi)
							fieldNode.@maxAllowedValues = "1";
						break;
					case MetadataCustomFieldTypes.LIST:
						if (multi) {
							fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.VBox)).copy();
							for each (var option:String in field.optionalValues) {
								var cb:XML = XML(componentsMap.getValue(CustomMetadataConstantTypes.CHECK_BOX)).copy();
								cb.@label = option;
								fieldNode.appendChild(cb);
							}
						}
						else {
							fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.COMBO_BOX)).copy();
							fieldNode.@dataProvider = field.optionalValues;
						}
						break;
				}
				if (fieldNode) {
					fieldNode.@name = field.name;
					fieldNode.@label = field.displayedLabel;
					parent.appendChild(fieldNode);
				}
			}

			_model.filterModel.metadataProfile.viewXML = mxml;
		}


		/**
		 * Builds the suitable component, according to its XML description
		 * @param component the XML description of the component to build
		 * @param boundModel the MetadataDataObject that will be bound to the correct property,
		 * 			we will use it to save the inserted metadata
		 * @return the built component
		 */
		public static function buildComponent(component:XML, boundModel:MetadataDataObject):UIComponent {
			var componentName:String = component.@compPackage + component.localName();
			var ClassReference:Class = getDefinitionByName(componentName) as Class;
			var compInstance:UIComponent = new ClassReference();
			if (component.@id == CustomMetadataConstantTypes.ENTRY_LINK_TABLE)
				compInstance["context"] = _model.context;

			var attributes:XMLList = component.attributes();
			for each (var attr:Object in attributes) {
				var attrName:String = attr.name().toString();
				var attrValue:String = attr.toString();

				//if this is the attribute we added, we will assign the proper object to it
				if (attrName == component.@metadataData) {
					compInstance[attrName] = getSuitableValue(attrValue, component.@dataType);
				}
				else if (attrName == "dataProvider") {
					compInstance[attrName] = attrValue.split(",");
				}
				else {
					compInstance.setStyle(attrName, attrValue); // try to set the property as a style
					// if the style value is null the propery is not a style
					try {
						compInstance[attrName] = attrValue;
					}
					catch (e:Error) {
						//this case is ok, we have a few attributes that are only used for the building of the view
						//trace("could not push", attrName, "=", attrValue, "to", compInstance);
					}
				}
			}

			//the key of this object in the metadataDataObject
			var newProperty:String = component.@name;
			//if we have nested uiComponents
			if (component.@id == CustomMetadataConstantTypes.MULTI ||
				component.@id == CustomMetadataConstantTypes.VBox) {
				boundModel[newProperty] = new MetadataDataObject();
				if (compInstance is MultiComponent) {
					if (component.children().length() > 0) {
						(compInstance as MultiComponent).childXML = XML(component.children()[0]).copy();
					}
					(compInstance as MultiComponent).metadataObject = boundModel[newProperty];
				}

				return buildComplexComponent(component, compInstance, boundModel[newProperty]);
			}

			if (component.@id == CustomMetadataConstantTypes.ENTRY_LINK_TABLE) {
				compInstance.id = component.@name;
				// in the EntryIDLinkTable case all binding logic is being handled from the component itself
				// pass relevant model parts:
				//compInstance["context"] = _model.context;
				compInstance["filterModel"] = _model.filterModel;
				compInstance["selectedEntry"] = _model.entryDetailsModel.selectedEntry;
				
			}
			else {
				var metadataProperty:String = component.@metadataData;
				boundModel[newProperty] = "";
				BindingUtils.bindProperty(boundModel, newProperty, compInstance, metadataProperty);
			}

			return compInstance;
		}


		/**
		 * Builds a form with all fields as detailed in the given XML
		 * @param mxml	form description
		 * @return	a form
		 * */
		public static function buildLayout(mxml:XML):UIComponent {
			//In order to have a class definition it should compile, so we point to it
			var dummyTable:EntryIDLinkTable;
			var dummyMulti:MultiComponent;

			var newLayout:Form = new Form();

			for each (var field:XML in mxml.children()) {
				var item:FormItem = new FormItem();
				for each (var fieldVo:MetadataFieldVO in _model.filterModel.metadataProfile.metadataFieldVOArray) {
					if (fieldVo.name == field.@name) {
						item.label = fieldVo.displayedLabel + ":";
						item.toolTip = fieldVo.description;
						break;
					}
				}
				item.setStyle("labelStyleName", "metadataFormLabel");
				var child:UIComponent = buildComponent(field, _model.entryDetailsModel.metadataInfo.metadataDataObject);
				if (child)
					item.addChild(child);
				newLayout.addChild(item);

				var spacer:Spacer = new Spacer();
				spacer.height = FIELDS_GAP;
				newLayout.addChild(spacer);
			}

			return newLayout;
		}


		/**
		 * this function returns a suitable value according to the given type
		 * @param input the value to convert
		 * @param valueType the type to return
		 * @return the correct form of the value
		 */
		private static function getSuitableValue(input:String, valueType:String):Object {
			switch (valueType) {
				case "int":
					return parseInt(input);
				case "Date":
					//moving to milliseconds
					var timeStamp:Number = Number(input) * 1000;
					return new Date(timeStamp);
				case "Boolean":
					return input == "true";
				case "Array":
					return input.split(",");
				case "String":
					return (input as String);
				default:
					return input;
			}
		}


		/**
		 * recieves an xml and maps its children to a hashmap where
		 * key=node name, value= node
		 * */
		private static function getValuesFromView(metadataViewXml:XML):HashMap {
			var values:HashMap = new HashMap();
			for each (var node:XML in metadataViewXml.children().children()) {
				values.put(node.@id, node);
			}

			return values;
		}


		/**
		 * recieve the uiconf from the server and call buildInitalMxml
		 * to build the layout according to the uiconf xml
		 * @param event
		 *
		 */
		private static function uiconfResult(event:KalturaEvent):void {
			var result:KalturaUiConf = KalturaUiConf(event.data);
			_model.filterModel.metadataProfile.viewXML = new XML(result.confFile);
			buildInitialMxml();
		}


		private static function uiconfFault(info:Object):void {
			if (info && info.error && info.error.errorMsg &&
				info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			_model.decreaseLoadCounter();
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
		}



		/**
		 * builds a complex uicomponent
		 * @param field the XML description of the uicomponent we wish to create
		 * @param fieldInstance the instance to add the new component to
		 * @param boundObject the MetadataDataObject that will be bound to the new component
		 * @return the new uicomponent
		 */
		private static function buildComplexComponent(field:XML, fieldInstance:UIComponent,
													  boundObject:MetadataDataObject):UIComponent {
			for each (var nestedField:XML in field.children()) {
				//list of checkboxes
				if (field.@id == CustomMetadataConstantTypes.VBox)
					nestedField.@name = nestedField.@label;
				else
					nestedField.@name = nestedField.childIndex();

				var nestedChild:UIComponent = buildComponent(nestedField, boundObject);
				if (fieldInstance && nestedChild)
					fieldInstance.addChild(nestedChild);
			}

			return fieldInstance;
		}

	}
}