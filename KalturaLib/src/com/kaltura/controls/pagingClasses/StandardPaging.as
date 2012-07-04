package com.kaltura.controls.pagingClasses
{
	import com.kaltura.events.PagingEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.core.Container;
	import mx.resources.ResourceManager;

	public class StandardPaging extends EventDispatcher implements IPagingBehavior
	{
		private var _pagingContainer:Container;
		private var _labelContainer:Container;
		private var _selectedPage:int;
		private var _showFirstLast:Boolean;
		private var _totalCount:int;
		private var _doubleEnd:Boolean;
		private var _sideLinkCount:int;
		private var _visible:Boolean;
		private var _pageSize:int = 25;
		private var _currRowsInPage:int;
		
		public function StandardPaging(totalCount:int, showFirstLast:Boolean, doubleEnd:Boolean, sideLinkCount:int)
		{
			_totalCount = totalCount;
			_showFirstLast = showFirstLast;
			_doubleEnd = doubleEnd;
			_sideLinkCount = sideLinkCount;
		}
		
		public function init(pagingContainer:Container, labelContainer:Container):void{
			_pagingContainer = pagingContainer;
			_labelContainer = labelContainer;
		}
		
		
		public function createPrePrevButtons():void{
			if (_showFirstLast && _selectedPage > 1) {
				var btn:LinkButton = new LinkButton();
				btn.label = ResourceManager.getInstance().getString('windows', 'first');;
				btn.styleName = "pagerFirstBtn";
				btn.addEventListener(MouseEvent.CLICK, first);
				_pagingContainer.addChild(btn);
			}
		}
		
		public function createMiddleButtons():void{
			var min:int = 0; // = _selectedPage-_sideLinkCount;
			var max:int = getTotalPageCount(); // = _selectedPage+_sideLinkCount;
			// case end / begin 
			if (_doubleEnd) {
				var total:int = _sideLinkCount * 2 + 1;
				
				for (var j:uint = 1; j <= total; j++) {
					if (Math.abs(max - min) == total - 1)
						break;
					
					if (_selectedPage + j <= getTotalPageCount())
						max = _selectedPage + j;
					if (_selectedPage - j >= 1)
						min = _selectedPage - j;
				}
				
				// handle end case of selected is 1
				if (_selectedPage == 1 && max < getTotalPageCount() && max < total)
					max = total;
			}
			else {
				min = _selectedPage - _sideLinkCount
				max = _selectedPage + _sideLinkCount
			}
			
			for (var i:int = min; i <= max; i++) {
				//paging must be positive and less the total page count
				if (i > 0 && i <= getTotalPageCount()) {
					var linkBtn:LinkButton = new LinkButton();
					linkBtn.toggle = true;
					linkBtn.label = i.toString();
					linkBtn.styleName = "pagerBtn";
					
					if (i == _selectedPage) {
						linkBtn.selected = true;
						linkBtn.enabled = false;
					}
					else
						linkBtn.addEventListener(MouseEvent.CLICK, setNewPage);
					
					_pagingContainer.addChild(linkBtn);
				}
				visible = true;
			}
		}
		
		public function createNextButtons():void{
			var btn:Button;
			if (_selectedPage < getTotalPageCount()) {
				//add previous button
				btn = new LinkButton();
				btn.label = ResourceManager.getInstance().getString('windows', 'next');;
				btn.styleName = "pagerNextBtn";
				btn.addEventListener(MouseEvent.CLICK, next);
				_pagingContainer.addChild(btn);
			}
			if (_showFirstLast && _selectedPage < getTotalPageCount()) {
				btn = new LinkButton();
				btn.label = ResourceManager.getInstance().getString('windows', 'last');;
				btn.styleName = "pagerLastBtn";
				btn.addEventListener(MouseEvent.CLICK, last);
				_pagingContainer.addChild(btn);
			}
		}
		
		public function createLabelIndicators():void{
			// out-of text:
			var firstItem:int = (_selectedPage-1) * _pageSize + 1;
			var lastItem:int = _selectedPage * _pageSize;
			if (lastItem > _totalCount) {
				lastItem = _totalCount;
			}
			if (_totalCount == 0) {
				firstItem = 0;
			}
			
			var label:Label = new Label();
			label.text = ResourceManager.getInstance().getString('windows', 'outOfText', [firstItem, lastItem, _totalCount]);
			label.setStyle("styleName", "selectRowsLable");
			
			_labelContainer.addChild(label);
		}
		
		protected function first(event:MouseEvent):void {
			_selectedPage = 1;
			dispatchEvent(new PagingBehaviorEvent(PagingBehaviorEvent.SELECTED_PAGE_CHANGED));
			dispatchEvent(new PagingEvent(PagingEvent.GET_PAGE_NUM));
		}
		
		protected function setNewPage(event:MouseEvent):void {
			_selectedPage = int((event.target as LinkButton).label);
			dispatchEvent(new PagingBehaviorEvent(PagingBehaviorEvent.SELECTED_PAGE_CHANGED));
			dispatchEvent(new PagingEvent(PagingEvent.GET_PAGE_NUM));
		}
		
		private function next(event:MouseEvent = null):void {
			if (_selectedPage < getTotalPageCount()) {
				_selectedPage = _selectedPage + 1;
				dispatchEvent(new PagingBehaviorEvent(PagingBehaviorEvent.SELECTED_PAGE_CHANGED));
				dispatchEvent(new PagingEvent(PagingEvent.NEXT_PAGE));
			}
		}
		
		protected function last(event:MouseEvent):void {
			_selectedPage = getTotalPageCount();
			dispatchEvent(new PagingBehaviorEvent(PagingBehaviorEvent.SELECTED_PAGE_CHANGED));
			dispatchEvent(new PagingEvent(PagingEvent.GET_PAGE_NUM));
		}
		
		private function getTotalPageCount():int{
			return Math.ceil(_totalCount / _pageSize);
		}
		
		public function set selectedPage(value:int):void{
			_selectedPage = value;
		}
		
		public function get selectedPage():int{
			return _selectedPage;
		}
		
		public function get visible():Boolean{
			return _visible;
		}
		
		[Bindable]
		public function set visible(value:Boolean):void{
			_visible = value;
		}
		
		public function get pageSize():int{
			return _pageSize;
		}
		
		public function set pageSize(value:int):void{
			_pageSize = value;
		}
		
		public function set currRowsInPage(value:int):void{
			_currRowsInPage = value;
		}
		
		public function get currRowsInPage():int{
			return _currRowsInPage;
		}
	}
}