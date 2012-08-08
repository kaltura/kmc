package com.kaltura.edw.components.fltr.panels {
	import com.kaltura.vo.AccessControlProfileVO;

	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.events.FlexEvent;

	public class AccessControlFilter extends AdditionalFilter {

		public function AccessControlFilter() {
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler, false, 0, true);
		}



		/**
		 * function used to retreive the correct button label
		 * @param data the ACPVO represented by a single button
		 * @return profile name
		 * */
		protected function getAcpName(data:AccessControlProfileVO):String {
			return data.profile.name;
		}

		
		/**
		 * container for initial filter if buttons not created yet 
		 */
		protected var _initialFilter:String;


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
					var profids:Array = value.split(',');
					for each (var profid:int in profids) {
						// find a matching checkbox and mark it
						for (i = 1; i < _buttons.length; i++) {
							if ((_buttons[i].data as AccessControlProfileVO).profile.id == profid) {
								_buttons[i].selected = true;
								break;
							}
						}
					}
				}
			}
			else {
				_initialFilter = value.toString();
			}
		}


		override public function get filter():Object {
			var str:String = '';
			for each (var cb:CheckBox in _buttons) {
				if (cb.selected && cb.data) {
					str += (cb.data as AccessControlProfileVO).profile.id + ",";
				}
			}
			if (str) {
				str = str.substr(0, str.length - 1);
				// remember current state so we can re-set if profiles are re-loaded
				_initialFilter = str;
				return str;
			}
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
		 * set the labelFunction and re-set dp if required
		 * @param event
		 * 
		 */
		protected function creationCompleteHandler(event:FlexEvent):void {
			friendlyName = resourceManager.getString('filter', 'acessControlToolTip');
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			labelFunction = getAcpName;
			if (_dataProvider) {
				dataProvider = _dataProvider;
			}
		}
	}
}
