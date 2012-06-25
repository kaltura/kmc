package com.kaltura.controls.pagingClasses
{
	import flash.events.IEventDispatcher;
	
	import mx.core.Container;

	public interface IPagingBehavior extends IEventDispatcher
	{
		function init(pagingContainer:Container, labelContainer:Container):void;
		
		function createPrePrevButtons():void;
		function createMiddleButtons():void;
		function createNextButtons():void;
		function createLabelIndicators():void;
		
		function get selectedPage():int;
		function set selectedPage(value:int):void;
		
		// Should be 25 by default
		function set pageSize(value:int):void;
		function get pageSize():int;
		
		function set currRowsInPage(value:int):void;
		function get currRowsInPage():int;
		
		// Should be bindable
		function get visible():Boolean;
	}
}