package com.kaltura.edw.components.filter.cat {
	import com.kaltura.edw.components.filter.CategoriesTree;
	import com.kaltura.edw.vo.CategoryVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.LinkButton;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.events.ResizeEvent;

	public class CategoriesTreeItemRenderer extends TreeItemRenderer {
		protected var _tree:CategoriesTree;
		protected var hBox:HBox;
		protected var addBtn:LinkButton;
		protected var deleteBtn:LinkButton;

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

			//Setting the width of the description field
			//causes the height calculation to happen
			hBox.width = explicitWidth - label.x;

			//We add the measuredHeight to the renderers measured height
			measuredHeight = hBox.measuredHeight;
		}


		/**
		 * Override the updateDisplayList() method
		 * to set the text for each tree node.
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			if (data && (data is CategoryVO)) {
				var vo:CategoryVO = data as CategoryVO;
				label.htmlText = vo.name + " <font color='#666666' size='11'> (" +
					vo.category.entriesCount + ")</font>";
				label.height = 25;  //TODO cat tree variableRowHeight probably fails because of this
				label.toolTip = label.text;

				var gWid:int = label.textWidth;
				hBox.x = label.x + gWid + 2;
				hBox.height = 26;
			}
		}
	}
}