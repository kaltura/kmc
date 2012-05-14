package com.kaltura.controls.table
{
	import com.kaltura.dataStructures.HashMap;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	/**
	 * dispatched whenever the "selectedItems" contents change
	 * */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * A DataGrid with a column of CheckBoxes for selection.
	 * it is assumed that when declaring the table columns, the selection column is there.
	 * 
	 * @author atar.shadmi
	 */	
	public class SelectionTable extends DataGrid {
		
		
		public static const ASCENDING:String = "ASC";
		public static const DESCENDING:String = "DESC";
		
		/**
		 * defines the value of the type property for the <code>selectionChanged</code> event.
		 * */
		public static const SELECTION_CHANGED:String = "selectionChanged";
		
		
		protected var columnsSortMap:HashMap = new HashMap();
		
		public function SelectionTable() {
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler, false, 0, true);
			selectable = false;
		}
		
		private function creationCompleteHandler(e:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			addEventListener(SelectionRenderer.SELECTION_CHANGED, handleSelectionChanged, false, 0, true);
		}
		
		/**
		 * if e.target.data is datagridcolumn:
		 * select / deselect all
		 * 
		 * else 
		 * set new selection value to the vo
		 * add/remove the vo to the selected items
		 * */
		protected function handleSelectionChanged(e:Event):void {
			e.stopImmediatePropagation();
			if (e.target.data is DataGridColumn) {
				// the click was on the headerRenderer
				if (selectedItems.length) {
					// select none
					selectedItems = [];
					e.target.cb.selected = false;
				}
				else {
					// select all
					selectedItems = (dataProvider as ArrayCollection).source;
					e.target.cb.selected = true;
				}
			}
			else {
				// set value on data
				var item:Object = e.target.data;
				
				// the click was inside the table
				var oldVal:Boolean = item[SelectionRenderer.SELECTION_ATTRIBUTE]; 
				item[SelectionRenderer.SELECTION_ATTRIBUTE] = !oldVal;
				item.dispatchEvent(PropertyChangeEvent.createUpdateEvent(item, SelectionRenderer.SELECTION_ATTRIBUTE, oldVal, !oldVal));
				// set value on selectedItems array
				var si:Array = selectedItems;
				if (oldVal) {
					// the entry was in the selectedItems array
					for (var i:int = 0; i<si.length; i++) {
						if (si[i].id == item.id) {
							si.splice(i, 1);
							break;
						}
					}
				}
				else {
					si.push(item);
				}
				selectedItems = si;
			}
			dispatchEvent(new Event("change"));	
		}
		
		
		/**
		 * selection or deselection was made
		 */
		private function setSelection():void {
			var e:Event = new Event(SELECTION_CHANGED);
			dispatchEvent(e);
		}
		
		
		override public function set selectedItem(item:Object):void {
			setSelectedItems([item]);
		}
		
		
		override public function set selectedItems(items:Array):void {
			setSelectedItems(items);
		}
		
		/**
		 * set the SELECTION_ATTRIBUTE on the given objects to true, 
		 * then set them as selected items
		 * */
		protected function setSelectedItems(items:Array):void {
			var oItem:Object;
			var si:Array = super.selectedItems; // currently selected items
			// mark all currently selected items as not selected
			for (var i:int = si.length-1; i>=0; i--) {
				oItem = si[i];
				oItem[SelectionRenderer.SELECTION_ATTRIBUTE] = false;
				oItem.dispatchEvent(PropertyChangeEvent.createUpdateEvent(oItem, SelectionRenderer.SELECTION_ATTRIBUTE, true, false));
			}
			if (items == null) {
				super.selectedItems = null;
			}
			else {
				si = [];
				// find selectedItems in the DP and add them to the selected list
				for each (var nItem:Object in items) {
					for each (oItem in dataProvider) {
						if (nItem.id == oItem.id) {
							// add the item that was in the dataprovider to start with
							si.push(oItem);
							oItem[SelectionRenderer.SELECTION_ATTRIBUTE] = true;
							oItem.dispatchEvent(PropertyChangeEvent.createUpdateEvent(oItem, SelectionRenderer.SELECTION_ATTRIBUTE, false, true));
							break;
						}
					}
				}
				super.selectedItems = si;
			}
			setSelection();
			
		}
		
		/**
		 * the current sort index
		 * */
		protected var _sortIndex:int = 5;
		
		[Bindable]
		/**
		 * the current sort direction
		 * */
		protected var _sortDirection:String = "DESC";
		
		protected function setSortIndicator():void {
			this.mx_internal::sortIndex = _sortIndex;
			this.mx_internal::sortDirection = _sortDirection;
		}

	}
}