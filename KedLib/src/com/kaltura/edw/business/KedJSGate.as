package com.kaltura.edw.business
{
	import flash.external.ExternalInterface;

	/**
	 * this class is supposed to make sure we pass correct parameters to JS functions.
	 * a method's signature in JS should be identical to the one here, give or take, 
	 * so if we use the one here instead of directly calling ExternalInterface we'll 
	 * know where we need to change stuff when changing method signatures, etc.  
	 * @author Atar
	 */
	public class KedJSGate {
		
		public static function openClipApp(entryId:String, mode:String):void {
			ExternalInterface.call("kmc.functions.openClipApp", entryId, mode);
		} 
		
		
		/**
		 * open preview and embed popup 
		 * @param functionName		name of the function we need to trigger in js
		 * @param entryId			entry id
		 * @param entryName			entry name
		 * @param entryDescription	entry description
		 * @param previewOnly		hide embed code
		 * @param is_playlist		the entry is a playlist
		 * @param uiconfId			initial player uiconf to use
		 * @param live_bitrates		list of bitrate objects {bitrate, width, height}
		 * @param duration			entry duration (only for single player, not playlist)
		 * @param thumbnail			entry thumbnail (only for single player, not playlist)
		 */
		public static function doPreviewEmbed(functionName:String, entryId:String, entryName:String, entryDescription:String, 
											  previewOnly:Boolean, is_playlist:Boolean, uiconfId:String, live_bitrates:Array,
											  duration:int, thumbnail:String):void {
			//			kmc.preview_embed.doPreviewEmbed(id, name, description, previewOnly, is_playlist, uiconf id, live_bitrates);
			ExternalInterface.call(functionName, entryId, entryName, entryDescription, previewOnly, is_playlist, uiconfId,
				live_bitrates, duration, thumbnail);
		}
		
		/**
		 * ks expired 
		 */
		public static function expired():void {
			ExternalInterface.call("kmc.functions.expired");
		}
		
		/**
		 * enable/disable header tabs
		 * @param enable	if true enable, otherwise disable  
		 */
		public static function maskHeader(enable:Boolean):void {
			ExternalInterface.call("kmc.utils.maskHeader", enable);
		}
		
		
		/**
		 * open live analytics in modal win directly to given entry 
		 * @param entryId
		 * @param entryName
		 */
		public static function openLiveAnalyticsDrilldown(entryId:String, entryName:String):void { 
			ExternalInterface.call("kmc.functions.openLiveAnalyticsDrilldown", entryId, entryName);
		}
		
		/**
		 * trigger the given JS function
		 * @param funcName name of JS function to trigger
		 */
		public static function triggerJS(funcName:String, ...args):void {
			ExternalInterface.call(funcName, args);
		}
	}
}
