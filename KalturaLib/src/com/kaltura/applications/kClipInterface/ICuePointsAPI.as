package com.kaltura.applications.kClipInterface
{
	public interface ICuePointsAPI extends IClipperAPI
	{
		/**
		 * Add a cue point on the playhead current position 
		 * 
		 */		
		function addCuePoint(object:Object):void ;
		
		/**
		 * Add a cue point at the given time, in milliseconds 
		 * @param object the the cue point to add
		 * @param timeInMS the given time
		 * 
		 */		
		function addCuePointAt(timeInMS:Number, object:Object):void ;
		
		/**
		 * Update a given cue point
		 * @param object the cue point to update
		 * 
		 */		
		function updateCuePoint(object:Object):void ;
		
		/**
		 * Will load cue points from server 
		 * 
		 */		
		function loadCuePoints():void;
		
	}
}