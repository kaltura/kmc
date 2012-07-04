package com.kaltura.controls.pagingClasses
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.Container;
	
	public class PlaceHolderPagingBehavior extends EventDispatcher implements IPagingBehavior
	{
		private var _selectedPage:int = 1;	// page index should never ever be 0!!!
		private var _pageSize:int = 25;
		private var _currRowsInPage:int;
		
		public function PlaceHolderPagingBehavior(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init(pagingContainer:Container, labelContainer:Container):void
		{
		}
		
		public function createPrePrevButtons():void
		{
		}
		
		public function createMiddleButtons():void
		{
		}
		
		public function createNextButtons():void
		{
		}
		
		public function createLabelIndicators():void
		{
		}
		
		public function get selectedPage():int
		{
			return _selectedPage;
		}
		
		public function set selectedPage(value:int):void
		{
			_selectedPage = value;
		}
		
		public function set pageSize(value:int):void
		{
			_pageSize = value;
		}
		
		public function get pageSize():int
		{
			return _pageSize;
		}
		
		public function set currRowsInPage(value:int):void
		{
			_currRowsInPage = value;
		}
		
		public function get currRowsInPage():int
		{
			return _currRowsInPage;
		}
		
		[Bindable]
		public function set visible(value:Boolean):void{
			
		}
		
		public function get visible():Boolean
		{
			return false;
		}
	}
}