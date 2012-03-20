package com.kaltura.edw.components.fltr.panels
{
	import com.kaltura.base.types.MetadataCustomFieldTypes;
	import com.kaltura.edw.components.fltr.IAdvancedSearchFilterComponent;
	import com.kaltura.types.KalturaSearchOperatorType;
	import com.kaltura.vo.KalturaMetadataSearchItem;
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class MetadataProfileFilter extends AdditionalFilter implements IAdvancedSearchFilterComponent {
		
		
		/**
		 * filter is KalturaMetadataSearchItem whose items are KalturaMetadataSearchItems
		 */
		override public function set filter(value:Object):void {
			//TODO implement
		}
		
		override public function get filter():Object {
			// create search item for the profile:
			var profileSearchItem:KalturaMetadataSearchItem = new KalturaMetadataSearchItem();
			profileSearchItem.type = KalturaSearchOperatorType.SEARCH_AND;
			profileSearchItem.metadataProfileId = parseInt(id); // EntriesFilter sets this attribute to the profile id
			profileSearchItem.items = [];
			
			// for each of the relevant fields/filters:
			for (var i:int = 0; i<numChildren; i++) {
				var metadataFilter:MetadataFilter = getChildAt(i) as MetadataFilter;
				var searchItem:KalturaMetadataSearchItem = metadataFilter.filter as KalturaMetadataSearchItem;
				if (searchItem) {
					profileSearchItem.items.push(searchItem);
				}
			}
			
			return profileSearchItem;
		}
		
		override public function set dataProvider(value:ArrayCollection):void {
			// dp items are MetadataFieldVO
			_dataProvider = value;
			buildFilters();
		}
		
		/**
		 * build MetadataFilters for the searchable fields 
		 * in the dataProvider
		 */		
		protected function buildFilters():void {
			var metadataFilter:MetadataFilter;
			for each (var mfvo:MetadataFieldVO in _dataProvider) {
				if (mfvo.appearInSearch && mfvo.type == MetadataCustomFieldTypes.LIST) {
					metadataFilter = new MetadataFilter();
					metadataFilter.addEventListener("changed", updateFilterValue, false, 0, true);
					metadataFilter.data = mfvo;
					metadataFilter.attribute = mfvo.id;
					metadataFilter.mainButtonTitle = mfvo.displayedLabel;
					metadataFilter.dataProvider = new ArrayCollection(mfvo.optionalValues);
					addChild(metadataFilter);
				}
			}
		}
		
		private function updateFilterValue(e:Event):void {
			e.stopImmediatePropagation();
			// need to have this item as event.target..
			dispatchChange();
		}
	}
}