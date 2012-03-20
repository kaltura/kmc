package com.kaltura.edw.components.fltr
{
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.types.KalturaSearchOperatorType;
	import com.kaltura.vo.KalturaContentDistributionSearchItem;
	import com.kaltura.vo.KalturaFilter;
	import com.kaltura.vo.KalturaMetadataSearchItem;
	import com.kaltura.vo.KalturaSearchItem;
	import com.kaltura.vo.KalturaSearchOperator;
	
	import flash.events.Event;
	
	import mx.containers.VBox;
	
	[ResourceBundle("filter")]
	
	/**
	 * dispatched when the contents of the filter have changed 
	 */	
	[Event(name="filterChanged", type="flash.events.Event")]
	
	
	/**
	 * Base class for Filter classes 
	 * @author Atar
	 * 
	 */
	public class BaseFilter extends VBox {
		
		/**
		 * @internal
		 * public because used in different panels
		 * */
		public static const DATE_FIELD_WIDTH:Number = 80;
		
		/**
		 * set new value on the changed panel's attribute 
		 * @param event	change event of an IFilterComponent
		 * 
		 */
		protected function updateFilterValue(event:Event):void {
			if (event.target is IMultiAttributeFilterComponent) {
				var atts:Array = (event.target as IMultiAttributeFilterComponent).attributes;
				var fltrs:Array = (event.target as IMultiAttributeFilterComponent).kfilters;
				for (var i:int = 0; i<atts.length; i++) {
					_kalturaFilter[atts[i]] = fltrs[i];
				}
			}
			else if (event.target is IAdvancedSearchFilterComponent) {
				handelAdvancedSearchComponent((event.target as IAdvancedSearchFilterComponent).filter as KalturaSearchItem,
					(event.target as IAdvancedSearchFilterComponent).attribute);
			}
			else if (event.target is IFilterComponent) {
				var tgt:IFilterComponent = event.target as IFilterComponent;
				_kalturaFilter[tgt.attribute] = tgt.filter;
			}
			dispatchEvent(new Event("filterChanged"));
		}
		 
		
		/**
		 * remove relevant searchItem according to filterType, then add the given one 
		 * @param searchItem	search item to add to filter
		 * @param filterType	search item identifier
		 */
		protected function handelAdvancedSearchComponent(searchItem:KalturaSearchItem, filterId:String):void {
			// create advanced search item if required:
			if (!_kalturaFilter.advancedSearch) {
				_kalturaFilter.advancedSearch = new KalturaSearchOperator();
				(_kalturaFilter.advancedSearch as KalturaSearchOperator).type = KalturaSearchOperatorType.SEARCH_AND;
				(_kalturaFilter.advancedSearch as KalturaSearchOperator).items = [];
			}
			var items:Array = (_kalturaFilter.advancedSearch as KalturaSearchOperator).items;
			var i:int;
			// if distribution filter:
			if (filterId == "distributionProfiles") {
				// find the distribtion search item and remove it.
				// there is only one distribution item, and we recognise it by the contents of its items.
				for (i = 0; i<items.length; i++) {
					var ksi:KalturaSearchOperator = items[i] as KalturaSearchOperator; 
					if (ksi) { // SearchItems which are not SearchOpreators will fall here
						if (ksi.items && ksi.items[0] is KalturaContentDistributionSearchItem) {
							(_kalturaFilter.advancedSearch as KalturaSearchOperator).items.splice(i, 1);
							break;
						}
					} 
				} 
			}
			else {
				// otherwise, metadataProfiles:
				// remove search item for this profile if exists.
				// there is only one item which matches the profile (filterType is profile id).
				for (i = 0; i<items.length; i++) {
					var msi:KalturaMetadataSearchItem = items[i] as KalturaMetadataSearchItem; 
					if (msi) { // SearchItems which are not KalturaMetadataSearchItem will fall here
						if (msi.metadataProfileId.toString() == filterId) {
							(_kalturaFilter.advancedSearch as KalturaSearchOperator).items.splice(i, 1);
							break;
						}
					} 
				}
			}
			
			// add new 
			if (searchItem) {
				(_kalturaFilter.advancedSearch as KalturaSearchOperator).items.push(searchItem);	
			}
		}
		
		// --------------------
		// free text search
		// --------------------
		
		private var _freeTextSearch:IFilterComponent;

		public function get freeTextSearch():IFilterComponent {
			return _freeTextSearch;
		}

		public function set freeTextSearch(value:IFilterComponent):void {
			_freeTextSearch = value;
			_freeTextSearch.addEventListener("changed", updateFilterValue, false, 0, true);
		}
		
		
		
		// --------------------
		// additional filters
		// --------------------
		
		/**
		 * @copy #additionalFiltersIds 
		 */		
		protected var _additionalFiltersIds:String;

		
		public function get additionalFiltersIds():String {
			return _additionalFiltersIds;
		}

		/**
		 * list of additional filters to show.
		 * if null, all available panels will be shown.
		 */		
		public function set additionalFiltersIds(value:String):void {
			_additionalFiltersIds = value;
		}
		
		
		// --------------------
		// model
		// --------------------
		
		/**
		 * @copy #filterModel 
		 */		
		protected var _filterModel:FilterModel;

		
		public function get filterModel():FilterModel {
			return _filterModel;
		}

		[Bindable]
		/**
		 * the model on which to store API calls results for reuse 
		 * (possibly by other parts of the application)
		 */		
		public function set filterModel(value:FilterModel):void {
			_filterModel = value;
		}
		
		
		// --------------------
		// KalturaFilter VO
		// --------------------
		/**
		 * @copy #kalturaFilter 
		 */		
		protected var _kalturaFilter:KalturaFilter;
		
		public function get kalturaFilter():KalturaFilter {
			return _kalturaFilter;
		}
		
		[Bindable]
		/**
		 * the Kaltura API filter object being manipulated by this component 
		 */		
		public function set kalturaFilter(value:KalturaFilter):void {
			_kalturaFilter = value;
		}
		
	}
}