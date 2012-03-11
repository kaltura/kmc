package com.kaltura.edw.components.filter.cat {
	import com.kaltura.edw.components.filter.CategoriesTree;
	import com.kaltura.edw.vo.CategoryVO;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.LinkButton;
	import mx.controls.Tree;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.mx_internal;
	import mx.events.ResizeEvent;
	
	use namespace mx_internal;

	public class CategoriesTreeItemRenderer extends TreeItemRenderer {
		protected var _tree:CategoriesTree;
		protected var hBox:HBox;
		protected var addBtn:LinkButton;
		protected var deleteBtn:LinkButton;
		protected var cb:CheckBox;

		override protected function createChildren():void {
			super.createChildren();

			//Setting this keeps the label field from jumping around on resizes
			setStyle("verticalAlign", "top");
			setStyle("percentWidth", "100");

			hBox = new HBox();
			hBox.styleName = 'treeItemButtonsHBox';
			addBtn = new LinkButton();
			addBtn.styleName = 'addLinkButton';
			addBtn.addEventListener(MouseEvent.CLICK, onAddCategoryEvent);

			deleteBtn = new LinkButton();
			deleteBtn.addEventListener(MouseEvent.CLICK, onDeleteCategoryEvent);
			hBox.addChild(addBtn);
			deleteBtn.styleName = 'deleteLinkButton';
			hBox.addChild(deleteBtn);
			hBox.visible = false;

			addChild(hBox);
		}

		override mx_internal function createLabel(childIndex:int):void {
			super.createLabel(childIndex);
			if (!cb){
				cb = new CheckBox();
				trace(childIndex);
				if (childIndex == -1)
					addChildAt(DisplayObject(cb), getChildIndex(getLabel() as DisplayObject));
				else 
					addChildAt(DisplayObject(cb), childIndex);
//				addChildAt(cb, childIndex);
			}
		}

		private function onDeleteCategoryEvent(event:Event):void {
			dispatchEvent(new Event(CategoriesTree.OPEN_DELETE_CATEGORY, true));
		}


		private function onAddCategoryEvent(event:Event):void {
			dispatchEvent(new Event(CategoriesTree.OPEN_ADD_CATEGORY, true));
		}


		/**
		 * Override the set method for the data property
		 * to set the font color and style of each node.
		 * */
		override public function set data(value:Object):void {
			if (value == null)
				return;

			super.data = value;

			if (this.parent == null)
				return;

			if (_tree == null) {
				this.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent):void {
						if (_tree.isInEditMode) {
							hBox.visible = true;
							deleteBtn.visible = (data as CategoryVO).id != 0;
						}
					});

				this.addEventListener(MouseEvent.ROLL_OUT, function(evt:MouseEvent):void {
						hBox.visible = false;
					});


				_tree = CategoriesTree(this.parent.parent);
				_tree.addEventListener(ResizeEvent.RESIZE, function(evt:ResizeEvent):void {
					//We must unset the height and width of the text field or it won't re-measure
					//and won't resize properly
						hBox.explicitWidth = NaN;
						hBox.explicitHeight = NaN;
					});
			}

			invalidateDisplayList();
		}
		

		/**
		 * @inheritDoc 
		 */
		override protected function measure():void {
			super.measure();

			if (hBox) {
				//Setting the width of the description field
				//causes the height calculation to happen
				hBox.width = explicitWidth - label.x;
	
				//We add the measuredHeight to the renderers measured height
				measuredHeight = hBox.measuredHeight;
			}
		}


		/**
		 * Override the updateDisplayList() method
		 * to set the text for each tree node.
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var ld:TreeListData = listData as TreeListData;
			var listOwner:Tree = Tree(ld.owner);
			var startx:Number = data ? ld.indent : 0;
			
			if (disclosureIcon)
			{
				disclosureIcon.x = startx;
				
				startx = disclosureIcon.x + disclosureIcon.width;
				
				disclosureIcon.setActualSize(disclosureIcon.width,
					disclosureIcon.height);
				
				disclosureIcon.visible = data ?
					ld.hasChildren :
					false;
			}
			
			if (icon)
			{
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
			if (verticalAlign == "top")
			{
				label.y = 0;
				cb.y = 0;
				if (icon)
					icon.y = 0;
				if (disclosureIcon)
					disclosureIcon.y = 0;
			}
			else if (verticalAlign == "bottom")
			{
				cb.y = unscaledHeight - cb.height + 2; // 2 for gutter
				label.y = unscaledHeight - label.height + 2; // 2 for gutter
				if (icon)
					icon.y = unscaledHeight - icon.height;
				if (disclosureIcon)
					disclosureIcon.y = unscaledHeight - disclosureIcon.height;
			}
			else
			{
				cb.y = (unscaledHeight - cb.height) / 2;
				label.y = (unscaledHeight - label.height) / 2;
				if (icon)
					icon.y = (unscaledHeight - icon.height) / 2;
				if (disclosureIcon)
					disclosureIcon.y = (unscaledHeight - disclosureIcon.height) / 2;
			}
			
			var labelColor:Number;
			
			if (data && parent)
			{
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
			
			if (data != null)
			{			
				if (listOwner.showDataTips)
				{
					if (label.textWidth > label.width ||
						listOwner.dataTipFunction != null)
					{
						toolTip = listOwner.itemToDataTip(data);
					}
					else
					{
						toolTip = null;
					}
				}
				else
				{
					toolTip = null;
				}
			}
			// ===========================================================================
			// ===========================================================================
			if (data && (data is CategoryVO)) {
				var vo:CategoryVO = data as CategoryVO;
				label.htmlText = vo.name + " <font color='#666666' size='11'> (" +
					vo.category.entriesCount + ")</font>";
				label.height = 25;
				label.toolTip = label.text;

				var gWid:int = label.textWidth;
				hBox.x = label.x + gWid + 2;
				hBox.height = 26;
			}
		}
	}
}