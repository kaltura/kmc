package com.kaltura.utils.pager
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="refrash", type="flash.events.Event")]
	
	public class Pager extends EventDispatcher
	{
		public static const PAGE_NOT_FOUND:String		= "pageNotFound";
		public static const PAGE_PARTIALLY_EXIST:String	= "pagePartiallyExist";
		public static const PAGE_EXIST:String			= "pageExist";

		private var _isFirstPage:Boolean			= true;
		private var _isLastPage:Boolean 			= false;
		private var _knownTotalPagesSize:Boolean	= false;
		
		private var _firstPageIndex:int = 0;
		private var _localPageNum:int = 0;
		private var _remotePageNum:int = 0;
		private var _localPageSize:int = 10;
		private var _remotePageSize:int = 20;
		private var _numPagesTotal:int;
		private var _lastPageIndex:int = -1;
		
		private var _allEntries:Array = [];
		private var _visiblePageData:Array;

		[Bindable("firstPage")]
		public function get isFirstPage():Boolean
		{
			return _isFirstPage;
		}

		[Bindable("lastPage")]
		public function get isLastPage():Boolean
		{
			return _isLastPage;
		}

		public function set isLastPage(value:Boolean):void
		{
			_isLastPage = value;
		}

		[Bindable]
		public function set firstPageIndex(value:int):void
		{
			if (value != _firstPageIndex)
			{
				_firstPageIndex = value;
				if (_localPageNum < _firstPageIndex)
				{
					_localPageNum = _firstPageIndex
					dispatchPagerEvent(PagerEvent.LOCAL_PAGE_NUM_CHANGED);					
				}
				refresh();
			}
		}
		public function get firstPageIndex():int
		{
			return _firstPageIndex;
		}

		public function get lastPageIndex():int
		{
			return _lastPageIndex;
		}
		public function set lastPageIndex(value:int):void
		{
			_lastPageIndex = value;
			refresh();
		}

		[Bindable("localPageNumChanged")]
		public function get localPageNum():int
		{
			return _localPageNum;
		}

		[Bindable("remotePageNumChanged")]
		public function get remotePageNum():int
		{
			return _remotePageNum
		}

		public function get localPageSize():int
		{
			return _localPageSize;
		}

		public function set localPageSize(value:int):void
		{
			_localPageSize = value;
		}

		public function get remotePageSize():int
		{
			return _remotePageSize;
		}

		public function set remotePageSize(value:int):void
		{
			_remotePageSize = value;
		}

		[Bindable("totalPagesChanged")]
		public function get numPagesTotal():int
		{
			return _numPagesTotal;
		}
		
		public function set numPagesTotal( value : int ) : void
		{
			_numPagesTotal = value;
		}

		[Bindable]
		public function set visiblePageData(value:Array):void
		{
			_visiblePageData = value;
		}
		public function get visiblePageData():Array
		{
			return _visiblePageData;
		}

		public function nextPage():void
		{
			gotoPage(_localPageNum + 1);
		}

		public function prevPage():void
		{
			gotoPage(_localPageNum - 1);
		}
		
		public function get allEntries():Array
		{
			return _allEntries;
		}
		
		public function get knownTotalPagesSize() : Boolean
		{
			return _knownTotalPagesSize;
		}
		
		public function set knownTotalPagesSize( value : Boolean ) : void
		{
			_knownTotalPagesSize = value;
		}

		public function gotoPage(value:int):String
		{
			var pageExistenseStatus:String = getPageExistenseStatus(value);

			if (pageExistenseStatus != PAGE_NOT_FOUND && _localPageNum != value)
			{
				_localPageNum = value;
				dispatchPagerEvent(PagerEvent.LOCAL_PAGE_NUM_CHANGED);
				setRemotePageNum();
				refresh();
			}
			return pageExistenseStatus;
		}

		public function addDataSet(value:Array):void
		{
			_allEntries = _allEntries.concat(value);
			
			if(!_knownTotalPagesSize)
				setNumPagesTotal();
				
			refresh();
		}
		
		public function removeDataItem( index : int ) : void
		{
			_allEntries.splice(index,1);
			
			if(!_knownTotalPagesSize)
				setNumPagesTotal();
				
			refresh();
		}
		
		public function reorderItem( itemIndex : int , newIndex : int ) : Object
		{
			var item : Object = _allEntries.splice(itemIndex,1)[0];
			_allEntries.splice( newIndex , 0 , item );
			
			if(!_knownTotalPagesSize)
				setNumPagesTotal();
				
			refresh();
			return item;
		}

		public function clear():void
		{
			_allEntries = new Array();
			_visiblePageData = null;
			_isFirstPage = true;
			_isLastPage = false;
			_knownTotalPagesSize = false;
			_firstPageIndex = 0;
			_localPageNum= 0;
			_remotePageNum = 0;
			_localPageSize = 10;
			_remotePageSize = 20;
			_numPagesTotal = -1;
			_lastPageIndex = -1;
		}

		/**
		 * Returns the current page existense status
		 * @return
		 *
		 */
		public function currentExistenseStatus():String
		{
			return getPageExistenseStatus(_localPageNum);
		}

		public function getPageExistenseStatus(pageNum:int):String
		{
			var requestedPageFirstIndex:int = getFirstIndexForPage(pageNum);
			var requestedPageLastIndex:int = getFirstIndexForPage(pageNum) + _localPageSize;

			//completely out of range
			if (pageNum < _firstPageIndex || requestedPageFirstIndex > _allEntries.length - 1)
			{
				return PAGE_NOT_FOUND;
			}
			//completely in-range
			else if (requestedPageLastIndex <= _allEntries.length)
			{
				return PAGE_EXIST
			}
			else
			{
				return PAGE_PARTIALLY_EXIST
			}
		}

		public function getLocalPageByDirection(direction:int):int
		{
			switch (direction)
			{
				case PageSearchDirection.CURRENT_PAGE:
					return _localPageNum;
				break;

				case PageSearchDirection.FIRST_PAGE:
					return _firstPageIndex;
				break;

				case PageSearchDirection.NEXT_PAGE:
					return _localPageNum != _lastPageIndex ?
																_localPageNum + 1 :
																_lastPageIndex;
				break;

				case PageSearchDirection.PREVIOUS_PAGE:
					return _localPageNum != _firstPageIndex ?
																_localPageNum - 1 :
																_firstPageIndex;
				break;
			}

			return _localPageNum;
		}

		public function getRemotePageByDirection(direction:int):int
		{
			switch (direction)
			{
				case PageSearchDirection.CURRENT_PAGE:
					if (getPageExistenseStatus(_localPageNum) != PAGE_EXIST)
					{
						return _remotePageNum + 1;
					}
					else
					{
						return _remotePageNum;
					}
				break;

				case PageSearchDirection.FIRST_PAGE:
					return _firstPageIndex;
				break;

				case PageSearchDirection.NEXT_PAGE:
					return _remotePageNum + 1;
				break;

				case PageSearchDirection.PREVIOUS_PAGE:
					return _remotePageNum - 1 != _firstPageIndex ?
																	_remotePageNum -1 :
																	_remotePageNum;
				break;
			}
			return _remotePageNum;
		}

		[Bindable("totalPagesChanged")]
		public function get isEmpty():Boolean
		{
			return _allEntries.length == 0;
		}
		private function refresh():void
		{
			var startIndex:int = getFirstIndexForPage(_localPageNum);
			var endIndex:int = startIndex + _localPageSize;

			visiblePageData = _allEntries.slice(startIndex, endIndex);

			var isFirstPage:Boolean = _localPageNum == _firstPageIndex;
			if (_isFirstPage != isFirstPage)
			{
				_isFirstPage = isFirstPage;
				dispatchPagerEvent(PagerEvent.FIRST_PAGE);
			}

			var isLastPage:Boolean = _localPageNum == _lastPageIndex;
			if (_isLastPage != isLastPage)
			{
				_isLastPage = isLastPage;
				dispatchPagerEvent(PagerEvent.LAST_PAGE);
			}
			
			dispatchEvent(new Event("refresh"));
		} 

		private function getFirstIndexForPage(pageNum:int):int
		{
			return (pageNum - _firstPageIndex) * _localPageSize
		}

		private function dispatchPagerEvent(eventType:String):void
		{
			var event:PagerEvent = new PagerEvent(eventType, false, false, _localPageNum, _remotePageNum, _numPagesTotal);
			dispatchEvent(event);
		}

		private function setRemotePageNum():void
		{
			if (getPageExistenseStatus(_localPageNum) == PAGE_EXIST)
			{
				_remotePageNum = Math.ceil(_localPageSize * _localPageNum / _remotePageSize);
			}
			//the page might be partially filled
			else
			{
				_remotePageNum = Math.ceil(_allEntries.length / _remotePageSize);
			}

			dispatchPagerEvent(PagerEvent.REMOTE_PAGE_NUM_CHANGED);
		}

		private function setNumPagesTotal():void
		{
			_numPagesTotal = Math.ceil(_allEntries.length / _localPageSize);
			dispatchPagerEvent(PagerEvent.TOTAL_PAGES_CHANGED);
		}

	}

}