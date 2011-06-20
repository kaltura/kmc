package com.kaltura.kmc.business
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;

	public interface IPopupMenu extends IFlexDisplayObject {
		
		/**
		 * popup will be added to this root's diplaylist
		 * @param doc
		 */
		function setRoot(doc:DisplayObjectContainer):void;
		
		function showPanel():void;
		
		function hidePanel(e:Event = null):void;
		
		function positionPanel(right:Number):void;
		
		function togglePanel():void;
		
	}
}