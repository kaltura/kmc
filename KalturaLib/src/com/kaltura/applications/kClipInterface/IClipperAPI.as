package com.kaltura.applications.kClipInterface
{
	import flash.events.IEventDispatcher;
	
	public interface IClipperAPI extends IEventDispatcher
	{
		
		/**
		 * set given entry id to clipper
		 * @param entryId the entry id to load
		 * 
		 */		
		function setEntryId(entryId:String):void;
		
		/**
		 * remove all time based assets from the timeline
		 * */	
		function removeAll():void ;
		
		/**
		 * delete the selected time based assets
		 * */
		function deleteSelected():void;
		
		/**
		 * 
		 * @return all time based assets from the current timeline
		 * 
		 */		
		function getAll():Array ;
		
		/**
		 * set the playhead value and scroll to the given point
		 * @param timeInMS the new value of the playhead
		 * 
		 */		
		function scrollToPoint(timeInMS:Number):void 
		
		/**
		 * update the given time as a start time of the selected time based asset 
		 * @param timeInMS the new time
		 * 
		 */		
		function updateInTime(timeInMS:Number):void 
		
		/**
		 * return the playhead location in milliseconds
		 * */
		function getPlayheadLocation():Number;
		
		/**
		 * save
		 * */
		function save():void;
		
		/**
		 * is saved required
		 * */
		function isSaveRequired():Boolean;
		
		/**
		 * init the clipper
		 * @param params
		 * 
		 */		
		function init(params:Object):void;
		
		/**
		 * Is KClip ready 
		 * @return true if ready
		 * 
		 */		
		function isReady():Boolean;
	}
}