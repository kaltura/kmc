package com.kaltura.edw.components.fltr.cat
{
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.components.TriStateCheckBox;
	import com.kaltura.edw.components.fltr.FilterComponentEvent;
	import com.kaltura.edw.components.fltr.IFilterComponent;
	import com.kaltura.edw.components.fltr.cat.data.*;
	import com.kaltura.edw.components.fltr.cat.events.CategoriesDataManagerEvent;
	import com.kaltura.edw.components.fltr.cat.renderers.*;
	import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
	import com.kaltura.edw.control.CategoriesTreeController;
	import com.kaltura.edw.events.GeneralNonCairngormEvent;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaCategory;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.core.ClassFactory;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.TreeEvent;
	
	
	/**
	 * dispatched when the value of the component have changed 
	 */	
	[Event(name="valueChange", type="com.kaltura.edw.components.fltr.FilterComponentEvent")]
	
	
	/**
	 * The category tree component is used to browse categories 
	 * @author Atar
	 * 
	 */
	public class CatTree extends Tree implements IFilterComponent {
		
		/**
		 * allow multiple instances use the same data provider by using different attributes 
		 * to mark selection in tree (entriesSelected, moderationSelected, etc).
		 * the tree and the IRs use the value of this attribute for determining if a category is "selected".  
		 */		
		public var selectionAttribute:String = "selected";
		
		/**
		 * set the required selection status and dispatch propertyChange event
		 * (instead of binding, so we can use dynamic attributes) 
		 * @param cat
		 * @param status
		 */		
		private function setCatSelectionStatus(cat:CategoryVO, status:int):void {
			var oldval:int = cat[selectionAttribute];
			cat[selectionAttribute] = status;
			(cat as IEventDispatcher).dispatchEvent(PropertyChangeEvent.createUpdateEvent(cat, selectionAttribute, oldval, status));
		}
		
		// -----------------------
		// Chunked Data
		// -----------------------
		
		private var _chunkedData:Boolean = true;
		
		/**
		 * a flag indicating if data load should be by levels or complete tree 
		 */
		public function get chunkedData():Boolean {
			return _chunkedData;
		}
		
		/**
		 * @private
		 */
		public function set chunkedData(value:Boolean):void {
			_chunkedData = value;
			_initDataManagerRequested = true;
			setTimeout(delayInitDataManager, 500);
		}
		
		private var _initDataManagerRequested:Boolean = false;
		
		/**
		 * @internal
		 * assume the second call (triggered by general permissions setter setting
		 * chunkedDataLoad flag) will come up to a 500 ms after the initial set, 
		 * this way we will only init once, with the correct value. 
		 */
		private function delayInitDataManager():void {
			if (_initDataManagerRequested) {
				initDataManager();
				_initDataManagerRequested = false;
			}
		}
		
		// -----------------------
		// Data
		// -----------------------		
		
		override public function set dataProvider(value:Object):void {
			var savedOpenItems:Array = openItems as Array; // returns a copy of the array
			super.dataProvider = value;
			validateNow();
			if (value && _currentFilter) {
				deselectAllCategories();
				remarkPreviouslySelected(true);
			}
			disableItems();
			for each (var o:Object in savedOpenItems) {
				if (!isItemOpen(o)) {
					expandItem(o, true);
				}
			}
		}
		
		
		/**
		 * the data manager responsible for category data load and management
		 * */
		protected var _dataManager:ICategoriesDataManger; 
		
		/**
		 * container variable for the categories that should appear disabled 
		 */		
		private var _disabledCategories:Array;
		
		/**
		 * list of categories which should be displayed as non-selectable if shows 
		 */		
		public function set disabledCategories(value:Array):void {
			_disabledCategories = value;
			disableItems();
		}
		
		
		/**
		 * mark items that should be disabled as disabled in the dataprovider 
		 */		
		private function disableItems(e:CollectionEvent=null):void {
			if (!_disabledCategories || !categories) {
				return;
			}
			var kCat:CategoryVO;
			var disCat:KalturaCategory;
			var bFound:Boolean;
			
			for (var i:int=0; i<_disabledCategories.length; i++) {
				disCat = _disabledCategories[i] as KalturaCategory;
				
				if (categories.containsKey(disCat.id.toString())) {
					var catvo:CategoryVO = categories.getValue(disCat.id.toString()) as CategoryVO;
					catvo.enabled = false;
				}
			}
		}
		
		
		/**
		 * easy access to categories (key is category id) 
		 */		
		public var categories:HashMap;
		
		
		/**
		 * the categories currently selected in the tree (checkboxes) 
		 */
		protected var _selectedCategories:Object; 
		
		
		/**
		 * get a list of categories which are currently selected
		 * @return array of <code>CategoryVO</code> objects 
		 */		
		public function getSelectedCategories():Array {
			var ar:Array = [];
			for each (var cat:CategoryVO in _selectedCategories) {
				ar.push(cat);
			}
			return ar; 
		}
		
		
		/**
		 * manually set filter value
		 * 
		 * @internal
		 * when extracting a new filter, some of these values may not be
		 * in the data provider but we still want to add them to the filter.   
		 */		
		protected var _initialFilter:String = '';
		
		/**
		 * string representation of current filter (catids), 
		 * from both seletedCategories and initialFilter 
		 */		
		protected var _currentFilter:String = '';
		
		
		
		public function CatTree() {
			super();
			variableRowHeight = true;
			labelField = "name";
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}
		
		
		/**
		 * add a category from the autocomplete component
		 * */
		public function addFromAutoComplete(event:GeneralNonCairngormEvent):void {
			var cat:KalturaCategory = event.data as KalturaCategory;
			addByCatId(cat.id.toString(), true, cat);
		}
		
		
		/**
		 * 
		 * @param catid
		 * @param keep	if category already selected, don't toggle (remove)
		 * @param cat	KalturaCategory obejct of the affected category
		 */
		public function addByCatId(catid:String, keep:Boolean = false, cat:KalturaCategory = null):void {
			if (categories.containsKey(catid)) {
				var catvo:CategoryVO = categories.getValue(catid) as CategoryVO;
				if (keep && _selectedCategories[catid]) {
					return;
				}
				handleSelectionChange(catvo);
			}
			else {
				// the part of the tree that holds this category was not yet loaded
				if (_initialFilter.indexOf(catid) == -1) {
					// category not yet selected
					addToCurrentFilter(catid);
					if (cat) {
						dispatchChange(new CategoryVO(cat.id, cat.name, cat), FilterComponentEvent.EVENT_KIND_ADD);
					}
				}
			}
		}
		
		
		private function onCreationComplete(e:Event):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			
			_selectedCategories = new Object();
			// add listener to IR events
			addEventListener(Event.CHANGE, onSelectionChange, false, 0, true);
			addEventListener(TreeEvent.ITEM_OPEN, onItemOpen, false, 0, true);
			
		}
		
		
		private function initDataManager():void {
			// select IDataManager
			var isNewManager:Boolean;
			if (_chunkedData) {
				if (_dataManager) {
					if (!(_dataManager is ChunkedDataManager)) {
						_dataManager.destroy();
						_dataManager.removeEventListener(CategoriesDataManagerEvent.REOPEN_BRANCH, handleReopenBranch);
						_dataManager = new ChunkedDataManager();
						isNewManager = true;
					}
				}
				else {
					_dataManager = new ChunkedDataManager();
					isNewManager = true;
				}
			}
			else {
				if (_dataManager) {
					if (!(_dataManager is CompleteDataManager)) {
						_dataManager.destroy();
						_dataManager.removeEventListener(CategoriesDataManagerEvent.REOPEN_BRANCH, handleReopenBranch);
						_dataManager = new CompleteDataManager();
						isNewManager = true;
					}
				}
				else {
					_dataManager = new CompleteDataManager();
					isNewManager = true;
				}
			}
			if (isNewManager) {
				_dataManager.addEventListener(CategoriesDataManagerEvent.REOPEN_BRANCH, handleReopenBranch, false, 0, true);
				_dataManager.controller = new CategoriesTreeController();
				// only load cat list if it doesn't exist yet
				_dataManager.loadInitialData();
			}
		}
		
		
		/**
		 * get required data
		 * @param event
		 */		
		private function onItemOpen(event:TreeEvent):void {
			_dataManager.branchClicked(event.itemRenderer.data as CategoryVO);
			disableItems();
		}
		
		
		/**
		 * expand the received branch  
		 * @param e
		 */
		private function handleReopenBranch(e:CategoriesDataManagerEvent):void {
			reopenBranch(e.data as CategoryVO);
		}
		
		/**
		 * expand the branch starting the given category  
		 * @param catvo VO that represents a category in the tree
		 */
		private function reopenBranch(catvo:CategoryVO):void {
			expandItem(catvo, false);
			expandItem(catvo, true);
			// mark cats from initFilter
			_initialFilter = selectFromInitial(catvo, _initialFilter);
			disableItems();
		}
		
		
		
		
		// ----------------------
		// Selection Handlers
		// ----------------------
		
		/**
		 * dispatch change event
		 * @param e IR event
		 * 
		 */		
		private function onSelectionChange(e:Event):void {
			// only handle IR events
			if (!(e.target is ICatTreeRenderer))  
				return;
			
			e.stopPropagation();
			handleSelectionChange(e.target.data as CategoryVO);
		}
		
		
		/**
		 * set all categories as un-selected 
		 */
		public function clearSelection():void {
			// use a dummy "root" to clear all selection
			var kCat:KalturaCategory = new KalturaCategory();
			kCat.directSubCategoriesCount = 0;
			var dummy:CategoryVO = new CategoryVO(0, "root", kCat);
			dummy.children = dataProvider as ArrayCollection;
			handleSelectionChange(dummy);
		}
		
		
		/**
		 * removes all categories from the selected list and sets their status to unselected,
		 * with no effect on actual filter (ui change only)
		 */		
		private function deselectAllCategories():void {
			if (_selectedCategories) {
				for each (var oldcat:CategoryVO in _selectedCategories) {
					setCatSelectionStatus(oldcat, CatSelectionStatus.UNSELECTED);
					if (selectionMode == CatTreeSelectionMode.MULTIPLE_SELECT_PLUS) {
						setChildrenSelection(oldcat, TriStateCheckBox.UNSELECTED, true);
						remarkParents(oldcat);
					}
				}
			}
			
			_selectedCategories = new Object();
		}
		
		/**
		 * set selected categories according to selection mode
		 * @param cat	category subject of change
		 */
		private function handleSelectionChange(cat:CategoryVO, dispatch:Boolean = true):void {
			var eventKind:String;
			var catid:String = cat.id.toString();
			// set value according to mode 
			switch (_selectionMode) {
				case CatTreeSelectionMode.SINGLE_SELECT:
					// deselect previous
					deselectAllCategories();
					_initialFilter = '';
					_currentFilter = '';
					// select new
					if (catid != "0") {
						// cannot "remember" root category
						_selectedCategories[catid] = cat;
						_currentFilter = catid;
						setCatSelectionStatus(cat, CatSelectionStatus.SELECTED);
					}
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_EXACT:
					if (cat.id == 0) {
						// root category "clicked"; remove all selections
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;
						// deselect previous
						_initialFilter = '';
						_currentFilter = '';
						deselectAllCategories();
					}
					else if (_selectedCategories[catid]) {
						// if there is a value, it means it was selected before
						delete _selectedCategories[catid];
						removeFromCurrentFilter(catid);
						setCatSelectionStatus(cat, CatSelectionStatus.UNSELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
					}
					else {
						// otherwise, add the category
						_selectedCategories[catid] = cat;
						addToCurrentFilter(catid);
						setCatSelectionStatus(cat, CatSelectionStatus.SELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_ADD;
					}
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_PLUS:
					if (cat.id == 0) {
						// root category "clicked"; remove all selections
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;
						// deselect previous
						_initialFilter = '';
						_currentFilter = '';
						setChildrenSelection(cat, TriStateCheckBox.UNSELECTED, true);
					}
					else if (_selectedCategories[catid]) {
						// if there is a value, it means it was selected before
						setCatSelectionStatus(cat, TriStateCheckBox.UNSELECTED); 
						delete _selectedCategories[catid];
						removeFromCurrentFilter(catid);
						setChildrenSelection(cat, TriStateCheckBox.UNSELECTED, true);
						remarkParents(cat);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
					}
					else {
						// otherwise, add the category
						setCatSelectionStatus(cat, TriStateCheckBox.SELECTED); 
						_selectedCategories[catid] = cat;
						addToCurrentFilter(catid);		
						setChildrenSelection(cat, TriStateCheckBox.SELECTED, true);
						remarkParents(cat);
						eventKind = FilterComponentEvent.EVENT_KIND_ADD;
					}
					break;
			}

			if (eventKind == FilterComponentEvent.EVENT_KIND_ADD) {
				var shouldOpen:Boolean = true;
				for each (var catvo:CategoryVO in openItems) {
					if (catvo == cat) {
						shouldOpen = false;
						break;
					}
				}
				if (shouldOpen) {
					expandToItem(cat, true);
				}
			}
			
			// indicators: no need to handle single select state (doesn't exist in filter)
			if (dispatch) {
				dispatchChange(cat, eventKind);
			}
		}
		
		
		/**
		 * expand all ancestors of the given item 
		 * @param item	Item to affect
		 * @param open	Specify true to open, false to close
		 */		
		private function expandToItem(item:Object, open:Boolean):void {
			var cat:CategoryVO = item as CategoryVO;
			while (cat.category.parentId != 0) {
				cat = categories.getValue(cat.category.parentId.toString());
				if (cat) {
					expandItem(cat, open);
				}
				else {
					break;
				}
			}
		}
		
		/**
		 * remove an item from the current filter data 
		 * @param catid	id of category to remove
		 */		
		private function removeFromCurrentFilter(catid:String):void {
			_currentFilter = _currentFilter.replace(catid + ',', '');
		}
		
		
		/**
		 * add an item to the current filter data
		 * @param catid	id of category to add
		 * */
		private function addToCurrentFilter(catid:String):void {
			if (_currentFilter.indexOf(catid + ",") == -1) {
				_currentFilter = catid + "," + _currentFilter;
			}
		}
		
		/**
		 * dispatch the filter valueChange event 
		 * @param cat
		 * @param eventKind
		 */		
		private function dispatchChange(cat:CategoryVO, eventKind:String):void {
			var ivo:IndicatorVo = new IndicatorVo();
			ivo.label = cat.category.name;
			ivo.tooltip = cat.category.fullName;
			ivo.attribute = attribute;
			ivo.value = cat.id;
			dispatchEvent(new FilterComponentEvent(FilterComponentEvent.VALUE_CHANGE, ivo, eventKind));
		}
		
		
		/**
		 * calculate ancestors selection status according to siblings
		 * @param cat
		 */
		private function remarkParents(cat:CategoryVO):void {
			var prnt:CategoryVO = cat;
			while (prnt.category.parentId != int.MIN_VALUE && prnt.category.parentId != 0) {
				prnt = categories.getValue(prnt.category.parentId.toString()) as CategoryVO;
				
				var gotSelectedChildren:Boolean = false;
				
				// scan the parent's children to decide its state
				for each (var cld:CategoryVO in prnt.children) {
					if (cld[selectionAttribute] == CatSelectionStatus.SELECTED 
						|| cld[selectionAttribute] == CatSelectionStatus.PARTIAL) {
						gotSelectedChildren = true;
						break;
					}
				}
				
				if (gotSelectedChildren) {
					// at least one child is partial or selected
					setCatSelectionStatus(prnt, CatSelectionStatus.PARTIAL);
				}
				else {
					// all children are unselected
					setCatSelectionStatus(prnt, CatSelectionStatus.UNSELECTED);
				}
			}
		}
		
		
		/**
		 * set the "selected" value on a branch of the tree 
		 * @param parent	branch category
		 * @param value		the value to give "selected" (TriStateCheckBox values)
		 * @param enable_disable	if true, the category will be disabled if selected or enabled if deselected
		 */
		private function setChildrenSelection(parent:CategoryVO, value:int, enable_disable:Boolean = false):void {
			for each (var cat:CategoryVO in parent.children) {
				setCatSelectionStatus(cat, value);
				if (value == TriStateCheckBox.SELECTED){
					// if child is listed as selected, remove it.
					if (_selectedCategories[cat.id]) {
						delete _selectedCategories[cat.id];
						removeFromCurrentFilter(cat.id.toString());
						dispatchChange(cat, FilterComponentEvent.EVENT_KIND_REMOVE);
					}
					// disable child
					cat.enabled = false;
				}
				else if (value == TriStateCheckBox.UNSELECTED){
					// if child is listed as selected, remove it.
					if (_selectedCategories[cat.id]) {
						// this is only when removing all selection
						delete _selectedCategories[cat.id];
						removeFromCurrentFilter(cat.id.toString());
						dispatchChange(cat, FilterComponentEvent.EVENT_KIND_REMOVE);
					}
					// enable child
					cat.enabled = true;
				}
				// handle children
				if (cat.children) {
					recSetChildrenSelection(cat, value, enable_disable);
				}
			}
		}
		
		private function recSetChildrenSelection(parent:CategoryVO, value:int, enable_disable:Boolean):void {
			setChildrenSelection(parent, value, enable_disable);
		}
		
		
		
		// --------------------
		// IFilterComponent parameters
		// --------------------
		
		protected var _attribute:String;
		
		public function set attribute(value:String):void {
			_attribute = value;
		}
		
		public function get attribute():String {
			return _attribute;
		}
		
		
		
		public function set filter(value:Object):void {
			// reset selected
			deselectAllCategories();
			
			// save value (assume it was string..)
			_initialFilter = value.toString();
			_currentFilter = value.toString();
			
			if ((dataProvider as ArrayCollection).length > 0) {
				remarkPreviouslySelected(false);
			}
		}
		
		private function remarkPreviouslySelected(silent:Boolean):void {
			// create a dummy root category
			var dummyRoot:CategoryVO = new CategoryVO(0, "root", new KalturaCategory());
			dummyRoot.children = dataProvider as ArrayCollection;
			// start marking
			selectFromInitial(dummyRoot, _currentFilter, silent);
		}
		
		/**
		 * recursive helper - go through all children and mark their children. 
		 * @param headCat	category to start marking from
		 * @param selectedIds	ids to mark
		 * @return 	ids left to mark after removing the "used" ones
		 */		
		private function selectFromInitialRec(headCat:CategoryVO, selectedIds:ArrayCollection, silent:Boolean):ArrayCollection {
			// add from new value:
			for each (var cat:CategoryVO in headCat.children) {
				if (selectedIds.contains(cat.id.toString())) {
					handleSelectionChange(cat, !silent);
					
					// remove from initial filter
					var i:int = selectedIds.getItemIndex(cat.id.toString());
					selectedIds.removeItemAt(i);
				}
				selectedIds = selectFromInitialRec(cat, selectedIds, silent);
			}
			return selectedIds;
		}
		
		
		/**
		 * mark categories that appear in the initial filter on the given branch
		 * @param headCat
		 * @param idsToMark
		 */		
		private function selectFromInitial(headCat:CategoryVO, idsToMark:String, silent:Boolean = false):String {
			if (!idsToMark) { return ''; }
			var selectedIds:ArrayCollection = new ArrayCollection(idsToMark.split(","));
			selectedIds = selectFromInitialRec(headCat, selectedIds, silent);
			return selectedIds.source.join(',');
		}
		
		
		/**
		 * comma seperated list of category ids (String)
		 */		
		public function get filter():Object{
			if (_currentFilter != '') {
				return _currentFilter;
			}
			return null;
		}
		
		
		public function removeItem(item:IndicatorVo):void {
			// item.value is id of cat to remove
			if (_selectedCategories[item.value] is CategoryVO) {
				handleSelectionChange(_selectedCategories[item.value] as CategoryVO);
			}
			else {
				if (_currentFilter.indexOf(item.value + ',') > -1) {
					removeFromCurrentFilter(item.value);
					dispatchChange(new CategoryVO(item.value, null, new KalturaCategory()), FilterComponentEvent.EVENT_KIND_REMOVE); 
				}
			}
			
		}
		
		// --------------------
		// Tree Selection mode
		// --------------------
		
		/**
		 * @copy #selectionMode 
		 */		
		private var _selectionMode:int = CatTreeSelectionMode.SINGLE_SELECT;
		
		/**
		 * tree selection mode.
		 * possible values enumerated in <code>CatTreeMode</code> class
		 * */
		public function get selectionMode():int {
			return _selectionMode;
		}
		
		public function set selectionMode(value:int):void {
			if (!value) {
				return;
			}
			_selectionMode = value;
			switch (value) {
				case CatTreeSelectionMode.SINGLE_SELECT:
					itemRenderer = new ClassFactory(CatTreeSingleIR);
					break;
				case CatTreeSelectionMode.MULTIPLE_SELECT_EXACT:
					itemRenderer = new ClassFactory(CatTreeMultiExactIR);
					break;
				case CatTreeSelectionMode.MULTIPLE_SELECT_PLUS:
					itemRenderer = new ClassFactory(CatTreeMultiPlusIR);
					break;
			}
		}
	}
}