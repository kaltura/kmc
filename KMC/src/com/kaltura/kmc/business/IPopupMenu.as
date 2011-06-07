package com.kaltura.kmc.business
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public interface IPopupMenu {
		
		/**
		 * popup will be added to this root's diplaylist
		 * @param doc
		 */
		function setRoot(doc:DisplayObjectContainer):void;
		
		function showPanel():void;
		
		function hidePanel(me:MouseEvent = null):void;
		
		function positionPanel(right:Number):void;
		
	}
}