package com.kaltura.edw.components.filter
{
	import com.kaltura.edw.components.filter.events.FilterEvent;
	import com.kaltura.vo.KalturaBaseEntryFilter;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.DateField;
	import mx.core.Container;
	import mx.styles.StyleManager;

	/**
	 * This class contains basic Filter operations 
	 * @author Michal
	 * 
	 */	
	public class BaseFilter extends VBox
	{		
		private const checkedImg:* = StyleManager.getStyleDeclaration(".imageBank").getStyle("checkedImg");
		private const emptyImg:* = StyleManager.getStyleDeclaration(".imageBank").getStyle("emptyImg");
		
		/**
		 * value of the type property of the filterChanged event dispatched by inner tabs.
		 * */
		public static const FILTER_CHANGED:String = "filterChanged";
		
		/**
		 * value of the type property of the newSearch event dispatched by filter
		 * */
		public static const NEW_SEARCH:String = "newSearch";
		
		[Bindable]
		/**
		 * indicates header buttons should be visible
		 * */
		public var showAccordionHeaderButtons:Boolean = false;

		
		/**
		 * when changing dates of search range, saves the old starting
		 * date so we can revert if new value is invalid
		 * */
		private var _currentStartOld:Date = null;
		
		/**
		 * when changing dates of search range, saves the old ending
		 * date so we can revert if new value is invalid
		 * */
		private var _currentEndOld:Date = null;
		
		/**
		 * A complex object with button lists.
		 * The keys are group names and values are arrays with references
		 * to actual buttons. Each button group is a search filter.
		 * */
		protected var dynamicFilterData:Object = new Object();
		
		/**
		 * show correct button icon (image)
		 * */
		public function updateImageButton(btnsList:Array):void {
			for each (var btn:Button in btnsList) {
				btn.setStyle('icon', btn.selected ? checkedImg : emptyImg);
			}
		}

		/**
		 * first validate the search text and only if valid will call sendNewSearch
		 * */
		public function preformNewSearch():void {
			dispatchEvent(new FilterEvent(NEW_SEARCH));
		}

		public function clearGivenDates(fromDate:DateField, toDate:DateField):void {
			fromDate.selectedDate = null;
			toDate.selectedDate = null;
			fromDate.selectedItem = new Date();
			toDate.selectedItem = new Date();
			
			preformNewSearch();
		}
		
		/**
		 * validate start date is before end date.
		 * @param fromDate	starting date
		 * @param toDate	end date
		 * @return true if dates are valid, false otherwise.
		 * */
		private function validateDates(fromDate:DateField, toDate:DateField):Boolean {
			var isDatesOk:Boolean = true;
			if ((fromDate.selectedDate != null) && (toDate.selectedDate != null)) {
				// starting date is after ending date.
				if (fromDate.selectedDate.time >= toDate.selectedDate.time) {
					isDatesOk = false;
				}
			}
			return isDatesOk;
		}	
		
		public function currentGivenDatesChange(fromDate:DateField, toDate:DateField):void {
			if (validateDates(fromDate, toDate)) {
				_currentStartOld = (fromDate.selectedDate != null) ? new Date((fromDate.selectedDate as Date).time) : null;
				_currentEndOld = (toDate.selectedDate != null) ? new Date((toDate.selectedDate as Date).time) : null;
			}
			else {
				Alert.show(resourceManager.getString('cms', 'fromToDateAlert'));
				toDate.selectedDate = _currentEndOld;
				fromDate.selectedDate = _currentStartOld;
				toDate.validateNow();
				fromDate.validateNow();
			}
			preformNewSearch();
		}
		
		/**
		 * return an array of X buttons and a title button (select all)
		 * all buttons are toggle buttons. click on any non titled button will deselect the title.
		 * Clicking on the title will deselect all other buttons. clicking on the last button
		 * in the group will deselect it and highlight the title button.
		 * @param titleLabel
		 * @param groupName
		 * @param buttonsData - data provider for the buttons
		 * @param buttonsLabels
		 * @param titleClickFunc - the function to be called when the title filter is clicked
		 * @param memberClickFunc - the function to be called when the title filter is clicked
		 * @param dynamicBtnsAC - Array collection containing dynamic buttons. Every new button will be added to it.
		 *
		 * @return Array - return the Array of Buttons
		 */
		public function createButtonsGroup(titleLabel:String, groupName:String, buttonsData:Array, buttonLabelField:String, titleClickFunc:Function, memberClickFunc:Function, dynamicBtnsAC:ArrayCollection=null):Array {
			var btn:Button;
			var array:Array = new Array();
			//select all button
			btn = new Button();
			btn.toggle = true;
			btn.percentWidth = 100;
			btn.label = titleLabel;
			btn.data = groupName + ' - ' + -1;
			btn.id = groupName;
			btn.selected = true;
			btn.styleName = "mainFilterGroupButton";
			btn.setStyle('icon', checkedImg);
			btn.addEventListener(MouseEvent.CLICK, titleClickFunc);
			array.push(btn);
			// rest of buttons
			for (var i:uint = 0; i < buttonsData.length; i++) {
				btn = new Button();
				btn.toggle = true;
				btn.percentWidth = 100;
				btn.label = buttonsData[i][buttonLabelField];
				btn.data = groupName + ' - ' + buttonsData[i]['id'];
				btn.selected = false;
				btn.setStyle('icon', emptyImg);
				btn.styleName = "innerFilterGroupButton";
				btn.id = groupName + "_" + buttonsData[i][buttonLabelField];
				btn.addEventListener(MouseEvent.CLICK, memberClickFunc);
				array.push(btn);
			}			
			if (dynamicBtnsAC) {
				dynamicBtnsAC.source = dynamicBtnsAC.source.concat(array);
			}
			dynamicFilterData[groupName] = array;
			return array;
		}
		
		/**
		 * Add a title button and group of buttons to conainer
		 * 1st button in array is the title button.
		 */
		public function injectGroupToContainer(container:Container, buttons:Array):void {
			for (var i:uint = 0; i < buttons.length; i++) {
				container.addChild((buttons[i] as Button));
			}
		}
		
		/**
		 * handle the top button click. disable all in case it is selected now
		 */
		public function onAutoTitleClick(evt:MouseEvent):void {
			var groupName:String = ((evt.target as Button).data as String).split(' - ')[0];
			var arr:Array = dynamicFilterData[groupName] as Array;
			var newValue:Boolean = (evt.target as Button).selected;
			if (newValue) {
				//top title was selected - unselect all other buttons
				for (var i:uint = 1; i < arr.length; i++) {
					(arr[i] as Button).selected = false;
				}
				updateImageButton(arr);
				preformNewSearch();
			}
			else {
				(evt.target as Button).selected = true;
			}
		}
		
		/**
		 * handle a group button click
		 */
		public function onAutoMemberClick(evt:MouseEvent):void {
			// target button:
			var btn:Button = evt.target as Button;
			
			// name of relevant button group
			var groupName:String = (btn.data as String).split(' - ')[0];
			
			// all the buttons in the group
			var arr:Array = dynamicFilterData[groupName] as Array;
			if (btn.selected) {
				// deselect the all title button
				(arr[0] as Button).selected = false;
				updateImageButton(arr);
				preformNewSearch();
			}
			else {
				//check if this unselect it the last one on the group. if so - select the title
				var counter:Number = 0;
				for (var i:uint = 1; i < arr.length; i++) {
					if ((arr[i] as Button) != btn && (arr[i] as Button).selected) {
						counter++;
					}
				}
				if (counter == 0) {
					//this is the last button unselected - turn on the title button 
					(arr[0] as Button).selected = true;
				}
				updateImageButton(arr);
				preformNewSearch();
			}
		}
		
		/**
		 * filter by given key, for the dynamic filters.
		 * @param key	the key to get the filter by
		 * @return a string representing the filter
		 * */
		protected function getFilter(key:String):String {
			var fd:Array = dynamicFilterData[key];
			var ids:Array = new Array();
			for each (var btn:Button in fd) {
				if (btn.selected) {
					var iid:String = (btn.data as String).split(' - ')[1];
					if (iid == '-1') {
						ids = new Array();
						break;
					}
					else {
						ids.push(iid);
					}
				}
			}
			return ids.join(',');
		}
		

	}
}