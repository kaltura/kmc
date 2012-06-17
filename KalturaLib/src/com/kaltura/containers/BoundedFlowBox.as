package com.kaltura.containers
{
	import com.kaltura.containers.utilityClasses.BoundedFlowLayout;
	
	import flash.events.Event;
	
	import flexlib.containers.FlowBox;
	
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	[Event(name="rowsLimitExceeded", type="fl.events.Event")]
	
	public class BoundedFlowBox extends FlowBox {
		
		public static const ROWS_LIMIT_EXCEEDED:String = "rowsLimitExceeded";
		
		[Bindable]
		/**
		 * index of the the last child that is visible in the box 
		 */		
		public var lastVisibleItemIndex:int;
		
		private var _limitRows:int = 2;

		public function get limitRows():int
		{
			return _limitRows;
		}

		public function set limitRows(value:int):void
		{
			_limitRows = value;
			invalidateDisplayList();
		}

		
		public function BoundedFlowBox()
		{
			super();
			// Use a BoundedFlowLayout to lay out the children
			layoutObject = new BoundedFlowLayout();
			layoutObject.target = this;	
		}
		
		
		public function exceeded(lastVisibleItemIndex:int):void {
			dispatchEvent(new Event(BoundedFlowBox.ROWS_LIMIT_EXCEEDED));
		}
	}
}