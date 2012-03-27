package com.kaltura.edw.components.fltr.panels
{
	import com.kaltura.edw.components.fltr.IAdvancedSearchFilterComponent;
	import com.kaltura.types.KalturaSearchOperatorType;
	import com.kaltura.vo.KalturaContentDistributionSearchItem;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaSearchOperator;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;

	public class DistributionFilter extends AdditionalFilter implements IAdvancedSearchFilterComponent {
		
		public function DistributionFilter()
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler, false, 0, true);
		}
		
		/**
		 * container for initial filter if buttons not created yet 
		 */
		protected var _initialFilter:KalturaSearchOperator;
		
		
		override public function set filter(value:Object):void {
			if (_dataProvider) {
				var i:int;
				// if there is a dp, we assume buttons are created and can be marked
				if (!value) {
					// select "all" button only
					_buttons[0].selected = true;
					for (i = 1; i < _buttons.length; i++) {
						_buttons[i].selected = false;
					}
				}
				else {
					_buttons[0].selected = false;
					var profiles:Array = (value as KalturaSearchOperator).items;
					for each (var searchItem:KalturaContentDistributionSearchItem in profiles) {
						// find a matching checkbox and mark it
						for (i = 1; i < _buttons.length; i++) {
							if ((_buttons[i].data as KalturaDistributionProfile).id == searchItem.distributionProfileId) {
								_buttons[i].selected = true;
								break;
							}
						}
					}
				}
			}
			else {
				_initialFilter = value as KalturaSearchOperator;
			}
		}
		
		
		override public function get filter():Object {
			if (_buttons) {
				var searchItem:KalturaContentDistributionSearchItem;
				var distributionSearchOperator:KalturaSearchOperator = new KalturaSearchOperator();
				distributionSearchOperator.type = KalturaSearchOperatorType.SEARCH_OR;
				distributionSearchOperator.items = new Array();
				for (var i:int = 1; i < _buttons.length; i++) {
					if (_buttons[i].selected) {
						searchItem = new KalturaContentDistributionSearchItem();
						searchItem.distributionProfileId = (_buttons[i].data as KalturaDistributionProfile).id;
						distributionSearchOperator.items.push(searchItem);
					}
				}
				
				if (distributionSearchOperator.items.length > 0) {
					return distributionSearchOperator;
				}
			}
			// if no buttons or no selected buttons, return null
			return null;
		}
		
		
		/**
		 * override set of dp to display initial filter
		 */
		override public function set dataProvider(value:ArrayCollection):void {
			super.dataProvider = value;
			if (_initialFilter) {
				filter = _initialFilter;
				_initialFilter = null;
			}
		}
		
		/**
		 * override the attribute setter so it can't be changed.
		 * this value is used in BaseFilter.updateFilterValue() to recognize the distribution filter. 
		 * @param value
		 */
		override public function set attribute(value:String):void {
			// do nothing
		}
		
		/**
		 * set the labelField and re-set dp if required
		 * @param event
		 * 
		 */
		protected function creationCompleteHandler(event:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			_attribute = "distributionProfiles";
			labelField = "name";
			friendlyName = resourceManager.getString('filter', 'distributionTooltip');
			if (_dataProvider) {
				dataProvider = _dataProvider;
			}
		}
	}
}