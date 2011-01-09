package com.kaltura.kmc.modules.content.business
{
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	
	import flash.external.ExternalInterface;

	/**
	 * this class is supposed to make sure we pass correct parameters to JS functions.
	 * a method's signature in JS should be identical to the one here, give or take, 
	 * so if we use the one here instead of directly calling ExternalInterface we'll 
	 * know where we need to change stuff when changing method signatures, etc.  
	 * @author Atar
	 */
	public class JSGate {
		
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
		 */
		public static function doPreviewEmbed(functionName:String, entryId:String, entryName:String, entryDescription:String, previewOnly:Boolean, is_playlist:Boolean, uiconfId:String, live_bitrates:Array, hasMobileFlavors:Boolean):void {
//			kmc.preview_embed.doPreviewEmbed(id, name, description, previewOnly, is_playlist, uiconf id, live_bitrates);
			ExternalInterface.call(functionName, entryId, entryName, entryDescription, previewOnly, is_playlist, uiconfId, live_bitrates, hasMobileFlavors);
		}
		
		
		public static function onTabChange():void {
			ExternalInterface.call("onTabChange");
		}
		
		/**
		 * set url hash text to represent current subtab 
		 * @param subtab	name of subtab to write in url
		 */
		public static function writeUrlHash(subtab:String):void {
			ExternalInterface.call("kmc.mediator.writeUrlHash", "content", subtab);
		}
		
//		editorType , isNewMix (true: create a mix and then open an editor, 
			//false - edit this mix with the matching editor type)
		/**
		 * open an editor for the given entry 
		 * @param entryId		entry id
		 * @param entryName		entry name
		 * @param editorType	editor type
		 * @param isNewMix		true: create a mix and then open an editor, 
		 *						false: edit this mix with the matching editor type
		 */
		public static function startEditor(entryId:String, entryName:String, editorType:int, isNewMix:Boolean):void {
			ExternalInterface.call("kmc.editors.start", entryId, entryName, editorType, isNewMix);
		}
	}
}