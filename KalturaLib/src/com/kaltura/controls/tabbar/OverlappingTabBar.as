package com.kaltura.controls.tabbar
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;

	import mx.controls.TabBar;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	use namespace mx_internal;

	public class OverlappingTabBar extends TabBar
	{
		// Used to store local reference to tabs
		private var _tabs:Array;
		private var _tabsDict:Dictionary;

		[Bindable]
		[Inspectable]
		public var useSelectedHack:Boolean = true;

		public function OverlappingTabBar()
		{
			super();
			_tabs = new Array();
			_tabsDict = new Dictionary(true);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationComplete, false, 0, true);
		}

		protected function creationComplete (event:FlexEvent):void
		{
			if (useSelectedHack)
			{
				var last:int = selectedIndex;
				selectedIndex = -1;
				setTimeout(function ():void {selectedIndex = last}, 1500);
			}
		}

		override protected function createNavItem(label:String, icon:Class = null):IFlexDisplayObject
		{
			var tabIndex:int = numChildren;
			var navItem:IFlexDisplayObject = super.createNavItem(label, icon);
			// Store tab refs in our array and dictionary
			_tabs.push(navItem);
			_tabsDict[navItem] = tabIndex;
			return navItem;
		}

		override public function getChildAt(index:int):DisplayObject
		{
			return _tabs[index];
		}

		override public function getChildIndex(child:DisplayObject):int
		{
			return _tabsDict[child];
		}

		override public function removeChildAt(index:int):DisplayObject
   	 	{
   	 		// ensures tabs are cleaned up from our
   	 		// array and dictionary when removed
   	 		var c:DisplayObject = super.removeChild(getChildAt(index));
   	 		_tabsDict[getChildAt(index)] = null;
   	 		_tabs.splice(index, 1);
   	 		return c;
		}

		override protected function hiliteSelectedNavItem(index:int):void
		{
			super.hiliteSelectedNavItem(index);
			if (index != -1)
			{
				// z-order tabs
				var l:int = _tabs.length - 1;
				for (var i:int = 0; i <= l; i++) {
					setChildIndex(_tabs[i], (l-i));
				}
				// put our selected tab at the top
				setChildIndex(_tabs[index], l);
			}
		}
	}
}