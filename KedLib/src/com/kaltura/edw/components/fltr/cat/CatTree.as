package com.kaltura.edw.components.fltr.cat
{
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.components.TriStateCheckBox;
	import com.kaltura.edw.components.fltr.FilterComponentEvent;
	import com.kaltura.edw.components.fltr.IFilterComponent;
	import com.kaltura.edw.components.fltr.cat.data.*;
	import com.kaltura.edw.components.fltr.cat.events.CatTreePrefsEvent;
	import com.kaltura.edw.components.fltr.cat.events.CategoriesDataManagerEvent;
	import com.kaltura.edw.components.fltr.cat.renderers.*;
	import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
	import com.kaltura.edw.control.CategoriesTreeController;
	import com.kaltura.edw.events.GeneralNonCairngormEvent;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.vo.KalturaCategory;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.Button;
	import mx.controls.Tree;
	import mx.core.Application;
	import mx.core.ClassFactory;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.TreeEvent;
	import mx.managers.PopUpManager;

	
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
		
		
		private var _chunkedData:Boolean;

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
			initDataManager(); 
		}

		
		/**
		 * the data manager responsible for category data load and management
		 * */
		protected var _dataManager:ICategoriesDataManger; 
		
		/**
		 *container variable for the categories that should appear disabled 
		 */		
		private var _disabledCategories:Array;
		
		/**
		 * list of categories which should be displayed as non-selectable if shows 
		 */		
		public function set disabledCategories(value:Array):void {
			_disabledCategories = value;
			if (categories) {
				disableItems();
			}
		}

		
		/**
		 * mark items that should be disabled as disabled in the dataprovider 
		 */		
		private function disableItems(e:CollectionEvent=null):void {
			if (!_disabledCategories) {
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
		 * preferences button 
		 */
		protected var _prefsBtn:Button;
		
		
		/**
		 * selection preferences window 
		 */
		private var _prefsWin:CatTreePrefsWin;
		
		
		
		public function CatTree() {
			super();
			variableRowHeight = true;
			labelField = "name";
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}
		
//		override public function set dataProvider(value:Object):void {
//			_initialFilter = '';
//			for each (var oldcat:CategoryVO in _selectedCategories) {
//				_initialFilter += oldcat.id + ",";
//			}
//			super.dataProvider = value;
//			selectFromInitial(dataProvider.getItemAt(0) as CategoryVO);
//		} 
		
		/**
		 * add a category from the autocomplete component
		 * */
		public function addFromAutoComplete(event:GeneralNonCairngormEvent):void {
			var cat:KalturaCategory = event.data as KalturaCategory;
			addByCatId(cat.id);
		}
		
		
		/**
		 * 
		 * @param catid
		 * 
		 */
		public function addByCatId(catid:int):void {
			if (categories.containsKey(catid.toString())) {
				var catvo:CategoryVO = categories.getValue(catid.toString()) as CategoryVO;
				handleSelectionChange(catvo);
			}
			else {
				// the part of the tree that holsd this category was not yet loaded
				_initialFilter = catid + "," + _initialFilter;
			}
		}
		
		
		private function onCreationComplete(e:Event):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			
			_selectedCategories = new Object();
			// add listener to IR events
			addEventListener(Event.CHANGE, onSelectionChange, false, 0, true);
			addEventListener(TreeEvent.ITEM_OPEN, onItemOpen, false, 0, true);
			
			if (selectionMode != CatTreeSelectionMode.SINGLE_SELECT) {
				// get selection mode from SO
				var so:SharedObject = SharedObject.getLocal("KMC_catTree");
				if (so.data && so.data.selectionMode) {
					selectionMode = so.data.selectionMode;
				}
			}
			showRoot = false;
		}
		
		
		private function initDataManager():void {
			// destroy old controller
			if (_dataManager) {
				return;
			}
			
			// select IDataManager
			if (_chunkedData) {
				_dataManager = new ChunkedDataManager();
			}
			else {
				_dataManager = new CompleteDataManager();
			}
			_dataManager.addEventListener(CategoriesDataManagerEvent.REOPEN_BRANCH, handleReopenBranch, false, 0, true);
			_dataManager.controller = new CategoriesTreeController();
			// only load cat list if it doesn't exist yet
			_dataManager.loadInitialData();
		}
		
		
		/**
		 * get required data
		 * @param event
		 */		
		private function onItemOpen(event:TreeEvent):void {
			_dataManager.branchClicked(event.itemRenderer.data as CategoryVO);
//			selectFromInitial(event.itemRenderer.data as CategoryVO); // complete manager does nothing, so we can mark here
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
			selectFromInitial(catvo);
			disableItems();
		}
		
		// ---------------------
		// preferences selection
		// ---------------------
		
		/**
		 * a button that opens the preferences window
		 * @internal
		 * we pass a reference because adding a button to the tree component is complicated 
		 */
		public function set prefsButton(btn:Button):void {
			btn.addEventListener(MouseEvent.CLICK, openPrefsWindow, false, 0, true);
			_prefsBtn = btn;
		}
		
		
		/**
		 * show the preferences window  
		 * @param e
		 */		
		private function openPrefsWindow(e:MouseEvent):void {
			_prefsWin = new CatTreePrefsWin();
			_prefsWin.addEventListener(CatTreePrefsEvent.PREFS_CHANGED, handlePrefsWin);
			_prefsWin.addEventListener(CloseEvent.CLOSE, handlePrefsWin);
			PopUpManager.addPopUp(_prefsWin, Application.application as DisplayObject);
		} 
		
		
		private function handlePrefsWin(e:Event):void {
			if (e.type == CatTreePrefsEvent.PREFS_CHANGED) {
				selectionMode = (e as CatTreePrefsEvent).newValue;
			}
			else if (e.type == CloseEvent.CLOSE) {
				_prefsWin.removeEventListener(CatTreePrefsEvent.PREFS_CHANGED, handlePrefsWin);
				_prefsWin.removeEventListener(CloseEvent.CLOSE, handlePrefsWin);
				PopUpManager.removePopUp(_prefsWin);
				_prefsWin = null
			}
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
		 * removes all categories from the selected list and sets their status to unselected 
		 */		
		private function deselectAllCategories():void {
			if (_selectedCategories) {
				for each (var oldcat:CategoryVO in _selectedCategories) {
					setCatSelectionStatus(oldcat, CatSelectionStatus.UNSELECTED);
//					oldcat.selected = CatSelectionStatus.UNSELECTED;
				}
			}
			
			_selectedCategories = new Object();
		}
		
		/**
		 * set selected categories according to selection mode
		 * @param cat	category subject of change
		 */
		private function handleSelectionChange(cat:CategoryVO):void {
			var eventKind:String;
			// set value according to mode 
			switch (_selectionMode) {
				case CatTreeSelectionMode.SINGLE_SELECT:
					// deselect previous
					deselectAllCategories();
					// select new
					_selectedCategories[cat.id.toString()] = cat;
					setCatSelectionStatus(cat, CatSelectionStatus.SELECTED);
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_EXACT:
					if (cat.id == 0) {
						// root category clicked; remove all selections
						setCatSelectionStatus(cat, CatSelectionStatus.UNSELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;
						// deselect previous
						deselectAllCategories();
					}
					else if (_selectedCategories[cat.id.toString()]) {
						// if there is a value, it means it was selected before
						delete _selectedCategories[cat.id.toString()];
						setCatSelectionStatus(cat, CatSelectionStatus.UNSELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
					}
					else {
						// otherwise, add the category
						_selectedCategories[cat.id.toString()] = cat;
						setCatSelectionStatus(cat, CatSelectionStatus.SELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_ADD;
					}
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_PLUS:
					if (cat.id == 0) {
						// root category clicked; remove all selections
						setCatSelectionStatus(cat, CatSelectionStatus.UNSELECTED);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;
						// deselect previous
						deselectAllCategories();
					}
					else if (_selectedCategories[cat.id.toString()]) {
						// if there is a value, it means it was selected before
						setChildrenSelection(cat, TriStateCheckBox.UNSELECTED);
						makeParentsPartial(cat);
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
					}
					else {
						// otherwise, add the category
						setChildrenSelection(cat, TriStateCheckBox.SELECTED);
						remarkParents(cat);
						eventKind = FilterComponentEvent.EVENT_KIND_ADD;
					}
					break;
			}
			
			
			// indicators: no need to handle single select state (doesn't exist in filter)
			var ivo:IndicatorVo = new IndicatorVo();
			ivo.label = cat.category.name;
			ivo.tooltip = cat.category.fullName;
			ivo.attribute = attribute;
			ivo.value = cat.id;
			//TODO for selection with children, indicators for all children?
			dispatchEvent(new FilterComponentEvent(FilterComponentEvent.VALUE_CHANGE, ivo, eventKind));
		}
		
		/**
		 * mark the ancestors of the given category vo as selected=partial 
		 * @param cat
		 */
		private function makeParentsPartial(cat:CategoryVO):void {
			var c:CategoryVO = cat;
			while (c.category.parentId != int.MIN_VALUE) {
				c = categories.getValue(c.category.parentId.toString()) as CategoryVO;
				setCatSelectionStatus(c, CatSelectionStatus.PARTIAL);
//				c.selected = CatSelectionStatus.PARTIAL;
			}
		}
		
		/**
		 * calculate ancestors selection status according to siblings
		 * @param cat
		 */
		private function remarkParents(cat:CategoryVO):void {
			var c1:CategoryVO = cat;
			while (c1.category.parentId != int.MIN_VALUE) {
				c1 = categories.getValue(c1.category.parentId.toString()) as CategoryVO;
				
				// scan the parent's children to decide its state
				var gotSelectedChildren:Boolean = false;
				var gotUnselectedChildren:Boolean = false;
				var gotPartialChildren:Boolean = false;
				for each (var c2:CategoryVO in c1.children) {
					if (c2[selectionAttribute] == CatSelectionStatus.SELECTED) {
						gotSelectedChildren = true;
					}
					else  if (c2[selectionAttribute] == CatSelectionStatus.UNSELECTED) {
						gotUnselectedChildren = true;
					}
					else  if (c2[selectionAttribute] == CatSelectionStatus.PARTIAL) {
						gotPartialChildren = true;
						break;
					}
				}
				
				if (gotPartialChildren) {
					setCatSelectionStatus(c1, CatSelectionStatus.PARTIAL);
				}
				else if (gotSelectedChildren && !gotUnselectedChildren) {
					setCatSelectionStatus(c1, CatSelectionStatus.SELECTED);
				}
				else if (!gotSelectedChildren && gotUnselectedChildren) {
					setCatSelectionStatus(c1, CatSelectionStatus.UNSELECTED);
				}
			}
		}
		
		/**
		 * set the "selected" value on a branch of the tree 
		 * @param parent	branch category
		 * @param value		the value to give "selected" (TriStateCheckBox values)
		 * 
		 */
		private function setChildrenSelection(parent:CategoryVO, value:int):void {
			setCatSelectionStatus(parent, value);
			if (value == TriStateCheckBox.SELECTED){
				_selectedCategories[parent.id] = parent;
			}
			else if (value == TriStateCheckBox.UNSELECTED){
				delete _selectedCategories[parent.id];
			}
			
			for each (var cat:CategoryVO in parent.children) {
				setCatSelectionStatus(cat, value);
				if (value == TriStateCheckBox.SELECTED){
					_selectedCategories[cat.id] = cat;
				}
				else if (value == TriStateCheckBox.UNSELECTED){
					delete _selectedCategories[cat.id];
				}
				// handle children
				if (cat.children) {
					setChildrenSelection(cat, value);
				}
			}
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
			
			selectFromInitial(dataProvider.getItemAt(0) as CategoryVO);
		}
		
		/**
		 * recursive helper - go through all children and mark their children. 
		 * @param headCat	category to start marking from
		 * @param selectedIds	ids to mark
		 * @return 	ids left to mark after removing the "used" ones
		 */		
		private function selectFromInitialRec(headCat:CategoryVO, selectedIds:ArrayCollection):ArrayCollection {
			// add from new value:
			for each (var cat:CategoryVO in headCat.children) {
				if (selectedIds.contains(cat.id.toString())) {
					handleSelectionChange(cat);
					
					// remove from initial filter
					var i:int = selectedIds.getItemIndex(cat.id.toString());
					selectedIds.removeItemAt(i);
				}
				selectedIds = selectFromInitialRec(cat, selectedIds);
			}
			return selectedIds;
		}
		
		/**
		 * mark categories that appear in the initial filter 
		 * @param headCat
		 * 
		 */		
		private function selectFromInitial(headCat:CategoryVO):void {
			if (!_initialFilter) { return; }
			var selectedIds:ArrayCollection = new ArrayCollection(_initialFilter.split(","));
			selectedIds = selectFromInitialRec(headCat, selectedIds);
			_initialFilter = selectedIds.source.join(',');
		}
		
		/**
		 * comma seperated list of category ids (String)
		 */		
		public function get filter():Object{
			var result:String = '';
			// add from selected categories
			for each(var cat:CategoryVO in _selectedCategories) {
				result += cat.id + ",";
			}
			
			// add from initial filter (if category never showed in tree)
			if (_initialFilter) {
				var temp:Array = _initialFilter.split(",");
				for each (var catid:String in temp) {
					if (result.indexOf(","+catid+",") < 0) {
						// the id doesn't appear in result string, add it
						result += catid + ",";
					}
				}
			}
			if (result != '') {
				// remove last comma and return result
				return result.substring(0, result.length - 1);
			}
			return null;
		}
		
		public function removeItem(item:IndicatorVo):void {
			// item.value is id of cat to remove
			handleSelectionChange(_selectedCategories[item.value] as CategoryVO);
				
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