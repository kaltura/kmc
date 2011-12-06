package com.kaltura.edw.business {
	import com.kaltura.base.types.MetadataCustomFieldMaxOcuursTypes;
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.commands.uiConf.UiConfGet;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.business.KedJSGate;
	import com.kaltura.edw.business.MetadataDataParser;
	import com.kaltura.edw.model.DummyModelLocator;
	import com.kaltura.edw.model.MetadataDataObject;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.CustomDataDataPack;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.model.types.CustomMetadataConstantTypes;
	import com.kaltura.edw.view.customData.DateFieldWithTime;
	import com.kaltura.edw.view.customData.EntryIDLinkTable;
	import com.kaltura.edw.view.customData.MultiComponent;
	import com.kaltura.edw.vo.EntryMetadataDataVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.customDataComponents.ConsistentDateField;
	import com.kaltura.kmvc.model.KMvCModel;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaUiConf;
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.UIDUtil;
	import mx.utils.object_proxy;

	/**
	 * This class is used for building UI components according to a given
	 * metadata profile and a view XML.
	 */
	[Bindable]
	public class FormBuilder {
		//spacer height between container fields
		private static const FIELDS_GAP:int = 4;
		//padding left for each hierarich level
		private static const FIELD_INDENT:int = 12;
		
		private var _model:KMvCModel = KMvCModel.getInstance();
		
		private var _isInvalidView:Boolean = false;

		private var _metadataProfile:KMCMetadataProfileVO;
		private var _metadataInfo:EntryMetadataDataVO = new EntryMetadataDataVO();
			
		/**
		 * map of objects that will be bound to others
		 * */
		private var _objectsHM:HashMap;
		/**
		 * Regular expressions that matches binding syntax
		 * */
		private static const BINDING_REGEXP:RegExp = /\{.*?\}/;

		/**
		 * The metadataProfile which according to it the builder will
		 * build the ui components
		 * @return the used metadataProfile
		 *
		 */
		public function get metadataProfile():KMCMetadataProfileVO {
			return _metadataProfile;
		}


		public function set metadataProfile(value:KMCMetadataProfileVO):void {
			_metadataProfile = value;
		}


		/**
		 *  The metadata info, containing the data that was inserted to the current metadata profile
		 * @return the used metadataInfo
		 *
		 */
		public function get metadataInfo():EntryMetadataDataVO {
			return _metadataInfo;
		}


		public function set metadataInfo(value:EntryMetadataDataVO):void {
			_metadataInfo = value;
		}


		/**
		 * Builds a new FormBuilder instance
		 * @param metadataProfile the metadata profile which will be used to build the proper
		 * UI components
		 *
		 */
		public function FormBuilder(metadataProfile:KMCMetadataProfileVO) {
			_metadataProfile = metadataProfile;
			_objectsHM = new HashMap();
		}


		/**
		 * go through the view xml and duplicates fields if neccessary, according to metadata data
		 * @param mxml the fields mxml view
		 * @param metadataData the existing data of current entry
		 * @return a new mxml with the existing data in the fields nodes, under the "text" property
		 *
		 */
		public function updateMultiTags():void {
			//var metadataInfo:EntryMetadataDataVO = _model.entryDetailsModel.metadataInfo;
			if (!_metadataInfo)
				return;
			if (!_metadataProfile.viewXML) {
				Alert.show(ResourceManager.getInstance().getString('drilldown', 'metadataInvalidView', [_metadataProfile.profile.name]), 
					ResourceManager.getInstance().getString('drilldown', 'error'));
				return;
			}
			if (!_metadataInfo.metadata) {
				_metadataInfo.finalViewMxml = _metadataProfile.viewXML.copy();
				return;
			}

			var mxml:XML = _metadataProfile.viewXML.copy();
			var metadataData:XML = new XML(_metadataInfo.metadata.xml);

			var dataMap:HashMap = MetadataDataParser.getMetadataDataValues(metadataData);
			for each (var field:XML in mxml.children())
				setFieldData(field, dataMap);

			_metadataInfo.finalViewMxml = mxml;
		}


		/**
		 * this function recieves xml represents a field, and sets it's values, if exist, according to a
		 * given values hash map
		 * @param field the given field to set
		 * @param valuesHashMap hash map containing data the fields should contain
		 *
		 */
		private function setFieldData(field:XML, valuesHashMap:HashMap):void {
			//represents which property in the component saves the metadata data
			var metadataDataAttribute:String;

			if (field.@id == CustomMetadataConstantTypes.MULTI) {
				if (field.children() && valuesHashMap.containsKey(field.children()[0].@name)) {
					var valuesArr:Array = valuesHashMap.getValue(field.children()[0].@name);
					if (valuesArr && valuesArr.length > 0) {
						//nested fields- nested metadata
						if ((valuesArr[0] is HashMap) && (field.children()[0].@id == CustomMetadataConstantTypes.CONTAINER)) {
							for (var j:int = 1; j < valuesArr.length; j++) {
								var newComplexChild:XML = field.children()[0].copy();
								setFieldData(newComplexChild, valuesArr[j]);
								field.appendChild(newComplexChild);
							}
							//!do it last because all other children copy it as base xml
							setFieldData(field.children()[0], valuesArr[0]);
						}
						else {
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
			}

			//cmoplex field
			else if (field.@id == CustomMetadataConstantTypes.CONTAINER) {
				var arr:Array = valuesHashMap.getValue(field.@name.toString());
				//if the container is used inside multi - we don't have nested hashmap
				var hashmap:HashMap = (arr) ? arr[0] : valuesHashMap;
				for each (var nestedField:XML in field.children()) {
					setFieldData(nestedField, hashmap);
				}
			}

			else if (valuesHashMap.containsKey(field.@name) && valuesHashMap.getValue(field.@name) && valuesHashMap.getValue(field.@name).length > 0) {
				var arrayOfValues:Array = valuesHashMap.getValue(field.@name);
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
						field.@[metadataDataAttribute] = valuesHashMap.getValue(field.@name);
					else
						field.@[metadataDataAttribute] = valuesHashMap.getValue(field.@name)[0];
				}
			}
		}



		/**
		 * sets in viewXml the suitable mxml for the ui represantation.
		 * It is done according to the default view xml and the fieldsArray.
		 * */
		public function buildInitialMxml():void {
			var fieldsArray:ArrayCollection = _metadataProfile.metadataFieldVOArray;
			var viewXml:XML = _metadataProfile.viewXML;
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
					if (field.type != MetadataCustomFieldTypes.LIST && field.type != MetadataCustomFieldTypes.OBJECT) {
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
						if (field.timeControl)
							fieldNode = XML(componentsMap.getValue(CustomMetadataConstantTypes.DATE_FIELD_WITH_TIME)).copy();
						else
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

			_metadataProfile.viewXML = mxml;
		}

		/**
		 * Builds the suitable component, according to its XML description
		 * @param component the XML description of the component to build
		 * @param boundModel the MetadataDataObject that will be bound to the correct property,
		 * 			we will use it to save the inserted metadata
		 * @param nestedFields is the array of the nested fields inside current component that will be build
		 * @return the built component
		 */
		public function buildComponent(component:XML, boundModel:MetadataDataObject, nestedFieldsArray:ArrayCollection):UIComponent {
			var compInstance:UIComponent;
			
			// Specific handling for date- prevents issues with the DateField's auto correction (Mantis 11155)
			if (component.localName() == "DateField"){
				compInstance = new ConsistentDateField();
			} else {
				var componentName:String = component.@compPackage + component.localName();
				var ClassReference:Class = getDefinitionByName(componentName) as Class;
				compInstance = new ClassReference();
			}
			//!setting the context param should be here, we will need it to set the dataArray property
			if (component.@id == CustomMetadataConstantTypes.ENTRY_LINK_TABLE) {
				//TODO make sure the type of the context attribute was changed to match datapack
				compInstance["context"] = _model.getDataPack(ContextDataPack);
				compInstance["profileName"] = metadataProfile.profile.name;
			}

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
					//if the attribute should be bound to another component
					if (BINDING_REGEXP.test(attrValue)) {
						//remove brackets and split to object and property
						var chainArray:Array = attrValue.substring(1, attrValue.length -1).split(".");
						BindingUtils.bindProperty(compInstance, attrName, _objectsHM.getValue(chainArray[0]), chainArray[1]);
					}
					else {
						compInstance.setStyle(attrName, attrValue); // try to set the property as a style
						var processedValue:Object = (attrValue == "true") ? true : ((attrValue == "false") ? false : attrValue);
						// if the style value is null the propery is not a style
						try {
							compInstance[attrName] = processedValue;
						}
						catch (e:Error) {
							//this case is ok, we have a few attributes that are only used for the building of the view
							//trace("could not push", attrName, "=", attrValue, "to", compInstance);
						}
						
					}
				}
			}

			//if this suppose to be a unique id field and it wasn't initialized yet, we will generate id now
			if ((component.@id == CustomMetadataConstantTypes.UNIQUE_ID) && (component.@text.toString() == "")) {
				compInstance["text"] = UIDUtil.createUID();
			}

			//the key of this object in the metadataDataObject
			var newProperty:String = component.@name;
			//if we have nested uiComponents
			if (component.@id == CustomMetadataConstantTypes.MULTI || component.@id == CustomMetadataConstantTypes.VBox || component.@id == CustomMetadataConstantTypes.CONTAINER) {
				boundModel[newProperty] = new MetadataDataObject();
				if (compInstance is MultiComponent) {
					if (component.children().length() > 0) {
						//this is the child that will be added with every click on the "add" button
						(compInstance as MultiComponent).childXML = XML(component.children()[0]).copy();
						(compInstance as MultiComponent).nestedFieldsArray = nestedFieldsArray;
						(compInstance as MultiComponent).formBuilder = this;
					}
					(compInstance as MultiComponent).metadataObject = boundModel[newProperty];
				}

				return buildComplexComponent(component, compInstance, boundModel[newProperty], nestedFieldsArray);
			}

			if (component.@id == CustomMetadataConstantTypes.ENTRY_LINK_TABLE) {
				compInstance.id = component.@name;
				compInstance["metadataObject"] = boundModel;
				// pass relevant model parts:
				compInstance["filterModel"] = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
//				compInstance["distributionProfilesArr"] = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray;
				compInstance["distributionProfilesArr"] = (_model.getDataPack(DistributionDataPack) as DistributionDataPack).distributionProfileInfo.kalturaDistributionProfilesArray;
				compInstance["selectedEntry"] = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry;
//				compInstance["selectedEntry"] = _model.entryDetailsModel.selectedEntry;

			}
			else {
				var metadataProperty:String = component.@metadataData;
				boundModel[newProperty] = "";
				BindingUtils.bindProperty(boundModel, newProperty, compInstance, metadataProperty);
			}

			//if this object will be used for binding
			if (component.@linkage) {
				_objectsHM.put(component.@linkage, compInstance);	
			}
			return compInstance;
		}


		/**
		 * This function will go over all components in the given container and disable them
		 * @param container the container of the components to disable
		 *
		 */
		public function disableComponents(container:Container):void {
			for (var i:int = 0; i < container.numChildren; i++) {
				var child:DisplayObject = container.getChildAt(i);
				if (child is Container) {
					disableComponents(child as Container)
				}
				else if (!(child is Label) && (child is UIComponent)) {
					(child as UIComponent).enabled = false;
				}
			}
		}


		/**
		 * Builds a form with all fields as detailed in the given XML
		 * @param mxml	form description
		 * @return	a form
		 * */
		public function buildLayout(mxml:XML):UIComponent {
			//TODO load these classes from module 
			//In order to have a class definition it should compile, so we point to it
			var dummyTable:EntryIDLinkTable;
			var dummyMulti:MultiComponent;
			var dummyDateFieldWithTime:DateFieldWithTime;

			var newLayout:VBox = new VBox();
			var fieldsArray:ArrayCollection = _metadataProfile.metadataFieldVOArray;

			for each (var field:XML in mxml.children()) {
				var child:UIComponent = buildLayoutItem(field, fieldsArray);
				if (child)
					newLayout.addChild(child);
				else if (_isInvalidView)
					break;

				var spacer:Spacer = new Spacer();
				spacer.height = FIELDS_GAP;
				newLayout.addChild(spacer);
			}

			return newLayout;
		}


		private function buildLayoutItem(field:XML, fieldsArray:ArrayCollection, metadataObject:MetadataDataObject = null):UIComponent {
			if (!fieldsArray)
				return null;

			var item:Container;

			//VBox for nested fields, HBox for flat field
			if (field.@id == CustomMetadataConstantTypes.CONTAINER) {
				item = new VBox();
			}
			else if ((field.@id == CustomMetadataConstantTypes.MULTI) && (field.children()[0].@id == CustomMetadataConstantTypes.CONTAINER)) {
				item = new VBox();
			}
			else {
				item = new HBox();
			}

			for each (var fieldVo:MetadataFieldVO in fieldsArray) {
				if (fieldVo.name == field.@name) {
					var label:Label = new Label();
					label.text = fieldVo.displayedLabel + ":";
					label.setStyle("styleName", "metadataFormLabel");
					label.width = 150;
					item.addChild(label);
					item.toolTip = fieldVo.description;
					break;
				}
			}

			//if it's a nested component we will recieve the bound metadata object. otherwhise use the one from the model
			var boundObject:MetadataDataObject = metadataObject ? metadataObject : _metadataInfo.metadataDataObject;
			try {
				var child:UIComponent = buildComponent(field, boundObject, fieldsArray);
			}
			catch (e:Error) {
				if (!_isInvalidView) {
					var rm:IResourceManager = ResourceManager.getInstance(); 
					Alert.show(rm.getString('drilldown', 'metadataInvalidViewComponents', [_metadataProfile.profile.name]), 
						rm.getString('drilldown', 'error'));
					_isInvalidView = true;
				}
				return null;
			}

			if (child) {
				item.addChild(child);
				if (item is VBox) {
					child.setStyle("paddingLeft", FIELD_INDENT);
					var spacer:Spacer = new Spacer();
					spacer.height = FIELDS_GAP;
					item.addChild(spacer);
				}
				BindingUtils.bindProperty(item, "visible", child, "visible");
				BindingUtils.bindProperty(item, "includeInLayout", child, "visible");
			}

			return item;
		}


		/**
		 * this function returns a suitable value according to the given type
		 * @param input the value to convert
		 * @param valueType the type to return
		 * @return the correct form of the value
		 */
		private function getSuitableValue(input:String, valueType:String):Object {
			switch (valueType) {
				case "int":
					return parseInt(input);
				case "Date":
					//translate to milliseconds
					var timeStamp:Number = Number(input) * 1000;
					var date:Date = new Date();
					date.time = timeStamp;
					return date;
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
		private function getValuesFromView(metadataViewXml:XML):HashMap {
			var values:HashMap = new HashMap();
			for each (var node:XML in metadataViewXml.children().children()) {
				values.put(node.@id, node);
			}

			return values;
		}



		/**
		 * builds a complex uicomponent
		 * @param field the XML description of the uicomponent we wish to create
		 * @param fieldInstance the instance to add the new component to
		 * @param boundObject the MetadataDataObject that will be bound to the new component
		 * @param fieldsVoArray is the array of fields where current component exist in
		 * @return the new uicomponent
		 */
		private function buildComplexComponent(field:XML, fieldInstance:UIComponent,
			boundObject:MetadataDataObject, fieldsVoArray:ArrayCollection = null):UIComponent {


			for each (var nestedField:XML in field.children()) {
				var nestedChild:UIComponent;

				//nested items
				if (field.@id == CustomMetadataConstantTypes.CONTAINER) {
					var currentField:MetadataFieldVO;
					var fieldIdentifier:String = (field.attribute("parentName").length() > 0) ? field.@parentName : field.@name;
					for each (var fieldVO:MetadataFieldVO in fieldsVoArray) {
						if (fieldVO.name == fieldIdentifier) {
							currentField = fieldVO;
							break;
						}
					}
					nestedChild = buildLayoutItem(nestedField, currentField.nestedFieldsArray, boundObject);
					if (_isInvalidView)
						break;
				}
				else {
					nestedField.@parentName = field.@name;
					//list of checkboxes
					if (field.@id == CustomMetadataConstantTypes.VBox)
						nestedField.@name = nestedField.@label;
					else if (field.@id == CustomMetadataConstantTypes.MULTI) {
						nestedField.@name = field.@name + nestedField.childIndex();
					}

					nestedChild = buildComponent(nestedField, boundObject, fieldsVoArray);
				}

				if (fieldInstance && nestedChild) {
					fieldInstance.addChild(nestedChild);
				}

			}

			return fieldInstance;
		}

	}
}