package com.kaltura.edw.business
{
	import com.kaltura.containers.HelpTitleWindow;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.kmvc.model.KMvCModel;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaMediaEntry;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * parts of code relevant to navigation between entries / categories 
	 * @author Atar
	 * 
	 */	
	public class ChangeableDataViewer extends HelpTitleWindow {
		
		
		protected var _itemsAC:ArrayCollection;
		
		/**
		 * list of entries in current page
		 * (entries we can navigate between using the "next" and "prev" buttons)
		 * */
		public function get itemsAC():ArrayCollection {
			return _itemsAC;
		}
		
		public function set itemsAC(value:ArrayCollection):void {
			_itemsAC = value;
			setButtonsState();
		}
		
		[Bindable]
		/**
		 * whether to display the next/previous buttons
		 * */
		public var showNextPrevBtns:Boolean = true;

		
		protected var _itemIndex:int = -1;
		
		
		[Bindable]
		/**
		 * whether previous button is available
		 * */
		protected var _prevEnabled:Boolean;
		
		
		[Bindable]
		/**
		 * whether next button is available
		 * */
		protected var _nextEnabled:Boolean;
		
	
		
		[Bindable]
		/**
		 * Index of current entry within the listableVo array, or after  
		 * prev/next clicked the index of the next entry to be navigated to.
		 * */
		public function get itemIndex():int {
			return _itemIndex;
		} 
		
		/**
		 * @private
		 * */
		public function set itemIndex(value:int):void {
			_itemIndex = value;
			setButtonsState();
		}
		
		
		/**
		 * give _prevEnabled, _nextEnabled correct values 
		 * according to entries list and entry index 
		 * */
		protected function setButtonsState():void {
			if (_itemsAC) {
				_prevEnabled = checkNavigatableItemExists(false, _itemIndex);
				_nextEnabled = checkNavigatableItemExists(true, _itemIndex);
			}
			else {
				_prevEnabled = _nextEnabled = false;
			}
		}
		
		
		protected function checkNavigatableItemExists(goForward:Boolean, itemInd:int):Boolean {
			return getNavigatableItemIndex(goForward, itemInd) != -1;
		}
		
		
		/**
		 * Gets the next entry index it's possible to navigate to,
		 * or -1 if no entry in that direction can be navigated to.
		 * */
		protected function getNavigatableItemIndex(goForward:Boolean, itemInd:int):int {
			var nextItemIndex:int = goForward ? itemInd + 1 : itemInd - 1;
			if (nextItemIndex < 0 || nextItemIndex > _itemsAC.length - 1) {
				return -1;
			}
			return nextItemIndex;
		}

	}
}