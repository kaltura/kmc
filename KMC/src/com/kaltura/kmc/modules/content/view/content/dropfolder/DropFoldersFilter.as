package com.kaltura.kmc.modules.content.view.content.dropfolder
{
	import com.kaltura.vo.KalturaDropFolder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.events.FlexEvent;
	import com.kaltura.edw.components.fltr.panels.AdditionalFilter;

	public class DropFoldersFilter extends AdditionalFilter {
		
		/**
		 * container for initial filter if buttons not created yet 
		 */
		protected var _initialFilter:String;
		
		public function DropFoldersFilter() {
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler, false, 0, true);
		}
		
		
		override public function set filter(value:Object):void {
			if (!_buttons) {
				_initialFilter = value.toString();
			}
			else {
				var i:int;
				// buttons are created and can be marked
				if (!value) {
					// select "all" button only
					_buttons[0].selected = true;
					for (i = 1; i < _buttons.length; i++) {
						_buttons[i].selected = false;
					}
				}
				else {
					_buttons[0].selected = false;
					var profids:Array = value.split(',');
					for each (var profid:int in profids) {
						// find a matching checkbox and mark it
						for (i = 1; i < _buttons.length; i++) {
							if ((_buttons[i].data as KalturaDropFolder).id == profid) {
								_buttons[i].selected = true;
								break;
							}
						}
					}
				}
			}
		}
		
		override public function get filter():Object {
			if (!_buttons || _buttons[0].selected)
				return null;
			var idsArr:Array = new Array();
			for (var i:int = 1; i < _buttons.length; i++) {
				if ((_buttons[i] as Button).selected) {
					idsArr.push(_buttons[i].data.id);
				}
			}
			
			return idsArr.join(',');
		}
		
		/**
		 * set the labelField and re-set dp if required
		 * @param event
		 * 
		 */
		protected function creationCompleteHandler(event:FlexEvent):void {
			friendlyName = resourceManager.getString('filter', 'dropFoldersTitle');
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			labelField = "name";
			if (_dataProvider) {
				dataProvider = _dataProvider;
			}
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
	}
}