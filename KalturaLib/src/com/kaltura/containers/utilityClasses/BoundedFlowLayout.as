package com.kaltura.containers.utilityClasses {
	import com.kaltura.containers.BoundedFlowBox;
	
	import flash.display.DisplayObject;
	
	import mx.containers.BoxDirection;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.states.RemoveChild;

	use namespace mx_internal;

	/**
	 * A BoundedFlowLayout implementation.  When the width of the children exceeds
	 * the width of the container, the next child is placed on a new row.
	 * When the limitRows parameter is reached an event is dispatched.
	 */
	public class BoundedFlowLayout extends BoxLayout {

		public function BoundedFlowLayout() {
			super();
			direction = BoxDirection.HORIZONTAL;
		}


		/**
		 * Measure the contents of the container and report back to the
		 * layout manager.
		 */
		override public function measure():void {
			direction = BoxDirection.VERTICAL;
			super.measure();
			direction = BoxDirection.HORIZONTAL;

			if (!isNaN(target.explicitWidth)) {
				doLayout(target.explicitWidth, false);
			}
			else if (!isNaN(target.percentWidth) && target.parent is UIComponent && !isNaN(UIComponent(target.parent).explicitWidth)) {
				doLayout(UIComponent(target.parent).explicitWidth * target.percentWidth / 100, false);
			}

			// This is tricky.  Because the FlowLayout can accomodate
			// multiple width and heights, it's hard to determine what the
			// measured values are.  For the time being, we'll just the 
			// measurement of the BoxLyaout in a regular HBox fashion.  This
			// produces, essentially, a FlowLayout measurement with just 1
			// row defined.
		}


		/**
		 * Layout the contents of the target using a flow layout
		 */
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			doLayout(unscaledWidth, true);
		}


		private function doLayout(unscaledWidth:Number, moveChildren:Boolean):void {
			var vm:EdgeMetrics = target.viewMetricsAndPadding;

			var hAlign:Number = getHorizontalAlignValue();
			var vAlign:Number = getVerticalAlignValue();
			var hGap:Number = target.getStyle("horizontalGap");
			var vGap:Number = target.getStyle("verticalGap");
			var len:Number = target.numChildren;

			var currentRowChildren:Array = new Array;
			var currentRowHeight:Number = 0;
			var currentRowY:Number = vm.top;
			var currentRowLastX:Number = vm.left;

			var child:IFlexDisplayObject;
			var tmpChild:IFlexDisplayObject;
			var rowExcessSpace:Number;
			var top:Number;

			var maxX:Number;
			var maxY:Number;

			var paddingRight:Number = target.getStyle("paddingRight") + target.borderMetrics.right;
			var paddingLeft:Number = target.getStyle("paddingLeft") + target.borderMetrics.left;

			var maxLines:int = (target as BoundedFlowBox) ? (target as BoundedFlowBox).limitRows : 0;
			var currentLine:int = 1;

			for (var i:int = 0; i < len; i++) {
				child = IFlexDisplayObject(target.getChildAt(i));

				if (child is UIComponent && !UIComponent(child).includeInLayout) {
					continue;
				}

				// If the child can't be placed in the current row....
				if (currentRowLastX + child.width > unscaledWidth - paddingRight) {
					currentRowLastX -= hGap;

					rowExcessSpace = unscaledWidth - paddingRight - currentRowLastX;
					rowExcessSpace *= hAlign;
					currentRowLastX = rowExcessSpace == 0 ? paddingLeft : rowExcessSpace;

					// Go back through the row and adjust the children for
					// their vertical and horizontal align values
					for (var j:int = 0; j < currentRowChildren.length; j++) {
						tmpChild = currentRowChildren[j];

						top = (currentRowHeight - tmpChild.height) * vAlign;
						if (moveChildren) {
							tmpChild.move(Math.floor(currentRowLastX), currentRowY + Math.floor(top));
						}
						currentRowLastX += tmpChild.width + hGap;
					}

					
					currentLine++;
					if (maxLines > 0 && currentLine > maxLines) {
						target.removeChild(child as DisplayObject);
						(target as BoundedFlowBox).exceeded();
						break;
					}
					else {
						// Start a new row
						currentRowY += currentRowHeight + vGap;
						currentRowLastX = paddingLeft;
						currentRowHeight = 0;
						currentRowChildren = [];
					}
				}

				// Don't actually move the child yet because that'd done when we
				// "finish" a row
				//child.move( currentRowLastX, currentRowY );

				// Move on to the next x location in the row
				currentRowLastX += child.width + hGap;

				// Add the child to the current row so we can adjust the
				// coordinates based on vAlign and hAlign
				currentRowChildren.push(child);

				// The largest child height in the row is the height for the
				// entire row
				currentRowHeight = Math.max(child.height, currentRowHeight);
			}



			// Done laying out the children, finish up the children that
			// are in the last row -- adjust the children for
			// their vertical and horizontal align values

			//remove the single extra padding we have
			currentRowLastX -= hGap;

			rowExcessSpace = unscaledWidth - paddingRight - currentRowLastX;
			rowExcessSpace *= hAlign;
			currentRowLastX = rowExcessSpace == 0 ? paddingLeft : rowExcessSpace;



			for (j = 0; j < currentRowChildren.length; j++) {
				tmpChild = currentRowChildren[j];
				top = (currentRowHeight - tmpChild.height) * vAlign;
				if (moveChildren) {
					tmpChild.move(Math.floor(currentRowLastX), currentRowY + Math.floor(top));
				}
				currentRowLastX += hGap + tmpChild.width;
			}

			if (!moveChildren) {
				target.measuredHeight = currentRowY + currentRowHeight + vm.bottom + vm.top;
			}
		}
	}
}
