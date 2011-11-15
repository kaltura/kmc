package com.kaltura.edw.model.datapacks
{
	import com.kaltura.kmvc.model.IDataPack;
	
	[Bindable]
	/**
	 * information about ad cuepoints on the current entry
	 * */
	public class CuePointsDataPack implements IDataPack {
		
		public var shared:Boolean = false;
		
		/**
		 * Will be used to make the KClip reload cue points upon bulk upload
		 * */
		public var reloadCuePoints:Boolean;
		
		/**
		 * number of cuepoints associated with current entry 
		 */
		public var cuepointsCount:int;
		
		/**
		 * url of cuepoints samples file 
		 */		
		public var cuepointsSamplesUrl:String;
	}
}