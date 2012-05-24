package com.kaltura.edw.components.fltr.panels {
	import com.kaltura.edw.components.fltr.FilterComponentEvent;
	import com.kaltura.edw.components.fltr.IFilterComponent;
	import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.core.ScrollPolicy;

	/**
	 * dispatched when the value of the component have changed
	 */
	[Event(name="valueChange", type="com.kaltura.edw.components.fltr.FilterComponentEvent")]

	public class AdditionalFilter extends VBox implements IFilterComponent {

		
		public function AdditionalFilter() {
			
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
		}
		

		/**
		 * the name of the field on the objects in the list to use as button label
		 */
		public var labelField:String;
		
		public var labelFunction:Function;
		
		
		/**
		 * the text that is displayed in the indicators on tooltip with current value 
		 */
		public var friendlyName:String;


		protected var _mainButtonTitle:String;


		/**
		 * main button label
		 */
		public function get mainButtonTitle():String {
			return _mainButtonTitle;
		}


		/**
		 * @private
		 */
		public function set mainButtonTitle(value:String):void {
			_mainButtonTitle = value;
			if (_dataProvider) {
				createButtons();
			}
		}




		protected var _dataProvider:ArrayCollection;


		/**
		 * list of objects from which the rest of the buttons will be derived
		 */
		public function get dataProvider():ArrayCollection {
			return _dataProvider;
		}


		/**
		 * @private
		 */
		public function set dataProvider(value:ArrayCollection):void {
			_dataProvider = value;
			if (_mainButtonTitle) {
				createButtons();
			}
		}

		/**
		 * create checkboxes and a title checkbox (select all) according to dataProvider. <br/>
		 * 
		 * click on any non-title button will deselect the title.
		 * Clicking on the title will deselect all other buttons. clicking on the last button
		 * in the group will deselect it and highlight the title button. 
		 */
		protected function createButtons():void {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			_buttons = new Array();
			var btn:CheckBox = new CheckBox();
			btn.percentWidth = 100;
			btn.label = _mainButtonTitle;
			btn.selected = true;
			btn.styleName = "mainFilterGroupButton";
			btn.addEventListener(MouseEvent.CLICK, onDynamicTitleClicked, false, 0, true);
			addChild(btn);
			_buttons.push(btn);
			// rest of buttons
			for (var i:int = 0; i < _dataProvider.length; i++) {
				btn = new CheckBox();
				btn.percentWidth = 100;
				btn.data = _dataProvider.getItemAt(i);
				if (labelFunction != null) {
					btn.label = labelFunction.apply(null,[_dataProvider.getItemAt(i)]);
				}
				else if (labelField) {
					btn.label = _dataProvider.getItemAt(i)[labelField];
				}
				else {
					btn.label = _dataProvider.getItemAt(i).toString();
				}
				btn.selected = false;
				btn.styleName = "innerFilterGroupButton";
				btn.addEventListener(MouseEvent.CLICK, onDynamicMemberClicked, false, 0, true);
				addChild(btn);
				_buttons.push(btn);
			}
		}


		protected function dispatchChange(vo:IndicatorVo, kind:String):void {
			dispatchEvent(new FilterComponentEvent(FilterComponentEvent.VALUE_CHANGE, vo, kind));
		}



		// --------------------
		// IFilterComponent
		// --------------------


		protected var _attribute:String;


		/**
		 * Name of the <code>KalturaFilter</code> attribute this component handles
		 */
		public function set attribute(value:String):void {
			_attribute = value;
		}


		public function get attribute():String {
			return _attribute;
		}


		/**
		 * Value for the relevant attribute on <code>KalturaFilter</code>.
		 */
		public function set filter(value:Object):void {
			throw new Error("Method set filter() must be implemented");
		}


		public function get filter():Object {
			throw new Error("Method get filter() must be implemented");
			return null;
		}
		
		public function removeItem(item:IndicatorVo):void {
			// item.value is button.data
			// find correct button, set "selected", dispatch change
			// basically - dispatch a "click" from the matching button
			for each (var btn:Button in _buttons) {
				if (btn.data) {
				 	if (btn.data == item.value) {
						btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true));
					}
				}
				else {
					// if no data, we use label
				 	if (btn.label == item.value) {
						btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true));
					}
				}
			}
			
		} 

		// --------------------
		// buttons
		// --------------------

		/**
		 * a list of buttons, the first one is the "all". <br>
		 * make sure to assign value in concrete panel (sub-class)
		 */
		protected var _buttons:Array;


		/**
		 * Handler for clicking on the button group title.
		 * */
		protected function onDynamicTitleClicked(event:MouseEvent):void {
			var titleBtn:Button = event.target as Button;

			//if the title is selected unselect all the 
			if (titleBtn.selected) {
				for (var i:int = 1; i < _buttons.length; i++) {
					_buttons[i].selected = false;
				}
				var vo:IndicatorVo = new IndicatorVo();
				vo.attribute = attribute;
				dispatchChange(vo, FilterComponentEvent.EVENT_KIND_REMOVE_ALL);
			}
			else {
				//the title can't be unselected if it was selected before
				titleBtn.selected = true;
			}
		}


		/**
		 * Handler for clicking an individual member of a button group.
		 * */
		protected function onDynamicMemberClicked(event:MouseEvent):void {
			var btn:Button = event.target as Button; 
			var i:int;
			var selectTheTitle:Boolean = true;
			var eventKind:String;
			//if we unselected a member we should go over and see if we need to select the title 
			if (!btn.selected) {
				eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
				for (i = 1; i < _buttons.length; i++) {
					if (_buttons[i].selected)
						selectTheTitle = false;
				}

				if (selectTheTitle) {
					_buttons[0].selected = true;
					eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;	
				}
			}
			else {
				// if any of the members has been selected shut down the title
				_buttons[0].selected = false;
				eventKind = FilterComponentEvent.EVENT_KIND_ADD;
			}
			var vo:IndicatorVo = new IndicatorVo();
			vo.label = btn.label;
			if (friendlyName) {
				vo.tooltip = friendlyName + ":" + btn.label;
			}
			vo.attribute = attribute;
			vo.value = btn.data ? btn.data : btn.label;
			dispatchChange(vo, eventKind);
		}
	}
}
