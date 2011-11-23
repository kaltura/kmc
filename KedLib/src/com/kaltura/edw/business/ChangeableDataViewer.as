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
	 * parts of code relevant to navigation between entries 
	 * @author Atar
	 * 
	 */	
	public class ChangeableDataViewer extends HelpTitleWindow {
		
		
		protected var _entriesAC:ArrayCollection;
		
		/**
		 * list of entries in current page
		 * (entries we can navigate between using the "next" and "prev" buttons)
		 * */
		public function get entriesAC():ArrayCollection {
			return _entriesAC;
		}
		
		public function set entriesAC(value:ArrayCollection):void {
			_entriesAC = value;
			setButtonsState();
		}
		
		[Bindable]
		/**
		 * whether to display the next/previous buttons
		 * */
		public var showNextPrevBtns:Boolean = true;

		
		protected var _entryIndex:int = -1;
		
		
		[Bindable]
		/**
		 * whether previous button is available
		 * */
		protected var _prevEnabled:Boolean;
		
		
		[Bindable]
		/**
		 * whether next button is available
		 * */
		protected var _nextEnabled:Boolean = true;
		
	
		
		[Bindable]
		/**
		 * Index of current entry within the listableVo array, or after  
		 * prev/next clicked the index of the next entry to be navigated to.
		 * */
		public function get entryIndex():int {
			return _entryIndex;
		} 
		
		/**
		 * @private
		 * */
		public function set entryIndex(value:int):void {
			_entryIndex = value;
			setButtonsState();
		}
		
		
		/**
		 * give _prevEnabled, _nextEnabled correct values 
		 * according to entries list and entry index 
		 * */
		protected function setButtonsState():void {
			if (_entriesAC) {
				_prevEnabled = checkNavigatableEntryExists(false, _entryIndex);
				_nextEnabled = checkNavigatableEntryExists(true, _entryIndex);
			}
			else {
				_prevEnabled = _nextEnabled = false;
			}
		}
		
		
		protected function checkNavigatableEntryExists(goForward:Boolean, entryInd:int):Boolean {
			return getNavigatableEntryIndex(goForward, entryInd) != -1;
		}
		
		
		/**
		 * Gets the next entry index it's possible to navigate to,
		 * or -1 if no entry in that direction can be navigated to.
		 * */
		protected function getNavigatableEntryIndex(goForward:Boolean, entryInd:int):int {
			var nextEntryIndex:int = goForward ? entryInd + 1 : entryInd - 1;
			if (nextEntryIndex < 0 || nextEntryIndex > _entriesAC.length - 1) {
				return -1;
			}
			
			var nextEntry:KalturaMediaEntry = _entriesAC.getItemAt(nextEntryIndex) as KalturaMediaEntry;
			if (nextEntry && nextEntry.mediaType == KalturaMediaType.LIVE_STREAM_FLASH && nextEntry.status != KalturaEntryStatus.READY) {
				return getNavigatableEntryIndex(goForward, nextEntryIndex);
			}
			else {
				return nextEntryIndex;
			}
		}

	}
}