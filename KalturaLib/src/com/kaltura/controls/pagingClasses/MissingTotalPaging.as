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

	public class MissingTotalPaging extends EventDispatcher implements IPagingBehavior
	{
		private var _pagingContainer:Container;
		private var _labelContainer:Container;
		private var _selectedPage:int;
		private var _pageSize:int = 25;
		private var _currRows:int;
		
		public function MissingTotalPaging()
		{
		}
		
		public function init(pagingContainer:Container, labelContainer:Container):void{
			_pagingContainer = pagingContainer;
			_labelContainer = labelContainer;
//			_pageSize = pageSize;
		}
		
		public function createPrePrevButtons():void{
			
		}
		
		public function createMiddleButtons():void{
			
		}
		
		public function createNextButtons():void{
			if (_currRows == _pageSize) {
				//add previous button
				var btn:Button = new LinkButton();
				btn.label = ResourceManager.getInstance().getString('windows', 'next');;
				btn.styleName = "pagerNextBtn";
				btn.addEventListener(MouseEvent.CLICK, next);
				_pagingContainer.addChild(btn);
			}
		}
		
		private function next(evt:MouseEvent):void{
			_selectedPage = _selectedPage + 1;
			dispatchEvent(new PagingBehaviorEvent(PagingBehaviorEvent.SELECTED_PAGE_CHANGED));
			dispatchEvent(new PagingEvent(PagingEvent.NEXT_PAGE));
		}
		
		public function createLabelIndicators():void{
			var firstItem:int = (_selectedPage-1) * _pageSize + 1;
			var lastItem:int = _currRows == _pageSize ? _selectedPage * _pageSize : firstItem + _currRows - 1;
			
			var label:Label = new Label();
			label.text = ResourceManager.getInstance().getString('windows', 'outOfNoTotal', [firstItem, lastItem, _selectedPage]);
			label.setStyle("styleName", "selectRowsLable");
			
			_labelContainer.addChild(label);
		}
		
		public function set selectedPage(value:int):void{
			_selectedPage = value;
		}
		
		public function get selectedPage():int{
			return _selectedPage;
		}
		
		
		[Bindable]
		public function set visible(value:Boolean):void{
			
		}
		
		public function get visible():Boolean{
			return false;
		}
		
		public function set pageSize(value:int):void{
			_pageSize = value;
		}
		
		public function get pageSize():int{
			return _pageSize;
		}
		
		public function set currRowsInPage(value:int):void{
			_currRows = value;
		}
		
		public function get currRowsInPage():int{
			return _currRows;
		}
	}
}