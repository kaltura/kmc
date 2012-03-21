package com.kaltura.edw.components.fltr.panels
{
	import com.kaltura.edw.components.fltr.IAdvancedSearchFilterComponent;
	import com.kaltura.types.KalturaSearchOperatorType;
	import com.kaltura.vo.KalturaMetadataSearchItem;
	import com.kaltura.vo.KalturaSearchCondition;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	
	public class MetadataFilter extends AdditionalFilter implements IAdvancedSearchFilterComponent {
		
		private var _initialFilter:KalturaMetadataSearchItem;
		
		override public function set filter(value:Object):void {
			if (!value) {
				_buttons[0].selected = true;
				for (var i:int = 1; i<_buttons.length; i++) {
					_buttons[i].selected = false;
				}
			}
			
			if (_buttons) {
				// scan the fields (filter.items)
				for each (var field:KalturaSearchCondition in value.items) {
					// for each field, find a matching button and select it
					for each (var cb:CheckBox in _buttons) {
						if (cb.data == field.value) {
							cb.selected = true;
						}
					}
				}
			}
			else {
				// keep the value for later
				_initialFilter = value as KalturaMetadataSearchItem;
			}
		}
		
		/**
		 * filter is KalturaMetadataSearchItem whose items are KalturaSearchCondition 
		 */
		override public function get filter():Object {
			if (_buttons) {
				var fieldValueSearchCondition:KalturaSearchCondition;
				var fieldKalturaMetadataSearchItem:KalturaMetadataSearchItem = new KalturaMetadataSearchItem();
				fieldKalturaMetadataSearchItem.type = KalturaSearchOperatorType.SEARCH_OR;
				fieldKalturaMetadataSearchItem.metadataProfileId = parseInt((parent as MetadataProfileFilter).id); // value set by EntriesFilter
				fieldKalturaMetadataSearchItem.items = new Array();
				for (var i:int = 1; i < _buttons.length; i++) {
					if (_buttons[i].selected) {
						fieldValueSearchCondition = new KalturaSearchCondition();
						fieldValueSearchCondition.field = (data as MetadataFieldVO).xpath;
						fieldValueSearchCondition.value = _buttons[i].data;
						fieldKalturaMetadataSearchItem.items.push(fieldValueSearchCondition);
					}
				}
				
				if (fieldKalturaMetadataSearchItem.items.length > 0) {
					return fieldKalturaMetadataSearchItem;
				}
			}
			// if no buttons or no selected buttons, return null
			return null;
		}
		
		override public function set dataProvider(value:ArrayCollection):void {
			super.dataProvider = value;
			if (_initialFilter) {
				filter = _initialFilter;
			}
		}
	
	}
}