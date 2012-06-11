package com.kaltura.edw.components.fltr.cat.renderers {
	import com.kaltura.edw.components.TriStateCheckBox;
	import com.kaltura.edw.components.fltr.cat.CatSelectionStatus;
	import com.kaltura.edw.components.fltr.cat.CatTree;
	import com.kaltura.edw.vo.CategoryVO;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.Tree;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.mx_internal;

	use namespace mx_internal;

	/**
	 * Item Renderer for the categories tree when displaying the
	 *  CatTreeSelectionMode.MULTIPLE_SELECT_PLUS mode
	 * @author Atar
	 * 
	 */
	public class CatTreeMultiPlusIR extends TreeItemRenderer implements ICatTreeRenderer {
		
		protected var cb:TriStateCheckBox;
		private var _watcher:ChangeWatcher;
		private var _listOwner:CatTree;

		private function onToggle(e:Event):void {
			e.stopPropagation();
			data[_listOwner.selectionAttribute] = cb.selected ? CatSelectionStatus.SELECTED : CatSelectionStatus.UNSELECTED;
			// let the tree know this item was clicked
			dispatchEvent(new Event(Event.CHANGE, true));
		}
		
		
		override public function set data(value:Object):void {
			super.data = value;
			
			
			// remove previous binding
			if (_watcher) {
				_watcher.unwatch();
			}
			var cat:CategoryVO = data as CategoryVO;
			if (cat) {
				_listOwner = CatTree((listData as TreeListData).owner);
				// bind CB to cat selected 
				// use binding instead of assignment because when setting filter 
				// "selected" can change after data is set
				_watcher = BindingUtils.bindSetter(catSelectionStatusChanged, cat, _listOwner.selectionAttribute);
			}
		}
		
		
		/**
		 * set CB selection status according to new cat selection status
		 * @param value new cat selection status
		 */
		private function catSelectionStatusChanged(value:int):void {
			if (!value || value == CatSelectionStatus.UNSELECTED) {
				cb.selected = TriStateCheckBox.UNSELECTED;
			}
			else if (value == CatSelectionStatus.PARTIAL) {
				cb.selected = TriStateCheckBox.PARTIAL;
			}
			else {
				cb.selected = TriStateCheckBox.SELECTED;
			}
		}
		
		override protected function createChildren():void {
			super.createChildren();

			//Setting this keeps the label field from jumping around on resizes
			setStyle("verticalAlign", "middle");
			setStyle("percentWidth", "100");
		}


		override mx_internal function createLabel(childIndex:int):void {
			super.createLabel(childIndex);
			if (!cb) {
				cb = new TriStateCheckBox();
				cb.addEventListener(Event.CHANGE, onToggle, false, 0, true);
				if (childIndex == -1)
					addChildAt(DisplayObject(cb), getChildIndex(getLabel() as DisplayObject));
				else
					addChildAt(DisplayObject(cb), childIndex);
//				addChildAt(cb, childIndex);
			}
		}


		

		/**
		 * Override the updateDisplayList() method
		 * to position the combobox correctly
		 * @internal
		 * this is the same code as in super + references to the checkbox (which re-positions 
		 * everything else). we still need to trigger super() because it triggers its super().
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (!listData) return;
			var ld:TreeListData = listData as TreeListData;
			var listOwner:Tree = Tree(ld.owner);
			var startx:Number = data ? ld.indent : 0;

			if (disclosureIcon) {
				disclosureIcon.x = startx;

				startx = disclosureIcon.x + disclosureIcon.width;

				disclosureIcon.setActualSize(disclosureIcon.width,
					disclosureIcon.height);

				disclosureIcon.visible = data ? ld.hasChildren : false;
			}

			if (icon) {
				icon.x = startx;
				startx = icon.x + icon.measuredWidth;
				icon.setActualSize(icon.measuredWidth, icon.measuredHeight);
			}

			cb.x = startx;
			startx = cb.x + cb.measuredWidth;
			cb.setActualSize(cb.measuredWidth, cb.measuredHeight);

			label.x = startx;
			label.setActualSize(unscaledWidth - startx, measuredHeight);

			var verticalAlign:String = getStyle("verticalAlign");
			if (verticalAlign == "top") {
				label.y = 0;
				cb.y = 0;
				if (icon)
					icon.y = 0;
				if (disclosureIcon)
					disclosureIcon.y = 0;
			}
			else if (verticalAlign == "bottom") {
				cb.y = unscaledHeight - cb.height + 2; // 2 for gutter
				label.y = unscaledHeight - label.height + 2; // 2 for gutter
				if (icon)
					icon.y = unscaledHeight - icon.height;
				if (disclosureIcon)
					disclosureIcon.y = unscaledHeight - disclosureIcon.height;
			}
			else {
				cb.y = (unscaledHeight - cb.height) / 2;
				label.y = (unscaledHeight - label.height) / 2;
				if (icon)
					icon.y = (unscaledHeight - icon.height) / 2;
				if (disclosureIcon)
					disclosureIcon.y = (unscaledHeight - disclosureIcon.height) / 2;
			}

			var labelColor:Number;

			if (data && parent) {
				if (!enabled)
					labelColor = getStyle("disabledColor");

				else if (listOwner.isItemHighlighted(listData.uid))
					labelColor = getStyle("textRollOverColor");

				else if (listOwner.isItemSelected(listData.uid))
					labelColor = getStyle("textSelectedColor");

				else
					labelColor = getStyle("color");

				label.setColor(labelColor);
			}

			if (data != null) {
				if (listOwner.showDataTips) {
					if (label.textWidth > label.width || listOwner.dataTipFunction != null) {
						toolTip = listOwner.itemToDataTip(data);
					}
					else {
						toolTip = null;
					}
				}
				else {
					toolTip = null;
				}
			}
		}


		override protected function commitProperties():void {
			super.commitProperties();
			var vo:CategoryVO = data as CategoryVO;
//			if (getLabel().text && getLabel().text != " ") {
//				// if there is text on the label it means there is data
//				label.htmlText = vo.name + " <font color='#666666' size='11'> (" + vo.category.entriesCount + ")</font>";
//			}
			if (vo ){
				switch (vo[_listOwner.selectionAttribute]){
					case CatSelectionStatus.PARTIAL:
						cb.selected = TriStateCheckBox.PARTIAL;
						break;
					case CatSelectionStatus.SELECTED:
						cb.selected = TriStateCheckBox.SELECTED;
						break;
					case CatSelectionStatus.UNSELECTED:
					default:
						cb.selected = TriStateCheckBox.UNSELECTED;
						break;
				}
				cb.enabled = vo.enabled;
			}
			else {
				cb.selected = TriStateCheckBox.UNSELECTED;
				cb.enabled = true;
			}
		}
	}
}