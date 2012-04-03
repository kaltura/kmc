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
	import com.kaltura.edw.vo.CategoryVO;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.engine.ElementFormat;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.controls.Tree;
	import mx.core.Application;
	import mx.core.ClassFactory;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
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
		protected var _initialFilter:String;
		
		
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
		
		
		
		private function onCreationComplete(e:Event):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			
			_selectedCategories = new Object();
			// add listener to IR events
			addEventListener(Event.CHANGE, onSelectionChange, false, 0, true);
			addEventListener(TreeEvent.ITEM_OPEN, onItemOpen, false, 0, true);
			
			// get selection mode from SO
			var so:SharedObject = SharedObject.getLocal("KMC_catTree");
			if (so.data && so.data.selectionMode) {
				selectionMode = so.data.selectionMode;
			}
			
//			initDataManager();
		}
		
		private function initDataManager():void {
			// destroy old controller
			if (_dataManager) {
//				_dataManager.controller.destroy();
				return;
			}
			
			// select IDataManager
			if (_chunkedData) {
				_dataManager = new ChunkedDataManager();
				(_dataManager as ChunkedDataManager).addEventListener(CategoriesDataManagerEvent.REOPEN_BRANCH, reopenBranch, false, 0, true);
			}
			else {
				_dataManager = new CompleteDataManager();
			}
			_dataManager.controller = new CategoriesTreeController();
			_dataManager.loadInitialData();
		}
		
		
		/**
		 * get required data
		 * @param event
		 */		
		private function onItemOpen(event:TreeEvent):void {
			_dataManager.branchClicked(event.itemRenderer.data as CategoryVO);
		}
		
		
		/**
		 * expand the received branch  
		 * @param e
		 */
		private function reopenBranch(e:CategoriesDataManagerEvent):void {
			expandItem(e.data, false);
			expandItem(e.data, true);
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
					oldcat.selected = CatSelectionStatus.UNSELECTED;
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
					cat.selected = CatSelectionStatus.SELECTED;
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_EXACT:
					if (cat.id == 0) {
						// root category clicked; remove all selections
						cat.selected = CatSelectionStatus.UNSELECTED;
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE_ALL;
						// deselect previous
						deselectAllCategories();
					}
					else if (_selectedCategories[cat.id.toString()]) {
						// if there is a value, it means it was selected before
						delete _selectedCategories[cat.id.toString()];
						cat.selected = CatSelectionStatus.UNSELECTED;
						eventKind = FilterComponentEvent.EVENT_KIND_REMOVE;
					}
					else {
						// otherwise, add the category
						_selectedCategories[cat.id.toString()] = cat;
						cat.selected = CatSelectionStatus.SELECTED;
						eventKind = FilterComponentEvent.EVENT_KIND_ADD;
					}
					break;
				
				case CatTreeSelectionMode.MULTIPLE_SELECT_PLUS:
					if (cat.id == 0) {
						// root category clicked; remove all selections
						cat.selected = CatSelectionStatus.UNSELECTED;
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
				c.selected = CatSelectionStatus.PARTIAL;
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
					if (c2.selected == CatSelectionStatus.SELECTED) {
						gotSelectedChildren = true;
					}
					else  if (c2.selected == CatSelectionStatus.UNSELECTED) {
						gotUnselectedChildren = true;
					}
					else  if (c2.selected == CatSelectionStatus.PARTIAL) {
						gotPartialChildren = true;
						break;
					}
				}
				
				if (gotPartialChildren) {
					c1.selected = CatSelectionStatus.PARTIAL;
				}
				else if (gotSelectedChildren && !gotUnselectedChildren) {
					c1.selected = CatSelectionStatus.SELECTED;
				}
				else if (!gotSelectedChildren && gotUnselectedChildren) {
					c1.selected = CatSelectionStatus.UNSELECTED;
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
			parent.selected = value;
			if (value == TriStateCheckBox.SELECTED){
				_selectedCategories[parent.id] = parent;
			}
			else if (value == TriStateCheckBox.UNSELECTED){
				delete _selectedCategories[parent.id];
			}
			
			for each (var cat:CategoryVO in parent.children) {
				cat.selected = value;
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
			_selectedCategories = new ArrayCollection();
			
			// save value (assume it was string..)
			_initialFilter = value.toString();
			
			var selectedIds:ArrayCollection = new ArrayCollection(_initialFilter.split(","));
			// add from new value:
			for each (var cat:CategoryVO in dataProvider) {
				if (selectedIds.contains(cat.id)) {
					_selectedCategories.addItem(cat);
					cat.selected = CatSelectionStatus.SELECTED;
					//TODO handle partial selection
				}
			}
		}
		
		/**
		 * comma seperated list of category ids (String)
		 */		
		public function get filter():Object{
			var result:String = '';
			var cat:CategoryVO;
			// add from selected categories
			for each(cat in _selectedCategories) {
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