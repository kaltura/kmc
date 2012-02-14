package com.kaltura.kmc.business
{
	import com.kaltura.edw.business.KedJSGate;
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
		
		public static function openClipApp(entryId:String, mode:String):void {
			KedJSGate.openClipApp(entryId, mode);
//			ExternalInterface.call("kmc.functions.openClipApp", entryId, mode);
		}
		
		/**
		 * ks expired 
		 */
		public static function expired():void {
			KedJSGate.expired();
		}
		
		/**
		 * create the HTML tabs
		 * @param tabs	list of objects that describe the tabs.
		 * 				{display_name:name to display on tab,
		 * 				module_name:id to return to kmc for this tab,
		 * 				subtab:initial subtab to show when switching to this module,
		 * 				html_url:url of contents of html tabs}
		 */
		public static function createTabs(tabs:Array):void {
			ExternalInterface.call("kmc.utils.createTabs", tabs);
		}
		
		/**
		 * switch to HTML tab
		 * @param url url of the html tab contents
		 */
		public static function openIframe(url:String):void {
			ExternalInterface.call("kmc.utils.openIframe", url);
		}
		
		/**
		 * show the kmc swf
		 * (used after showing HTML tab to tell js that we need to switch back to flash)
		 */
		public static function showFlash():void {
			ExternalInterface.call("kmc.utils.showFlash");
		}
		
		/**
		 * set the active tab
		 * @param module	id of module to mark active 
		 */
		public static function setTab(module:String, resetAll:Boolean):void {
			ExternalInterface.call("kmc.utils.setTab", module, resetAll);
		}
		
		
		/**
		 * set the tab as not active
		 * @param module	id of module to mark active 
		 */
		public static function resetTab(module:String):void {
			ExternalInterface.call("kmc.utils.resetTab", module);
			//TODO use this
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
		 * @param flavors			all entry flavors
		 * @param isHtml5			should the html5 part of the p&e be shown
		 */
		public static function doPreviewEmbed(functionName:String, entryId:String, entryName:String, entryDescription:String, 
											  previewOnly:Boolean, is_playlist:Boolean, uiconfId:String, live_bitrates:Array, 
											  flavors:Array, isHtml5:Boolean):void {
			KedJSGate.doPreviewEmbed(functionName, entryId, entryName, entryDescription, 
				previewOnly, is_playlist, uiconfId, live_bitrates, flavors, isHtml5);
		}
		
		
		public static function onTabChange():void {
			ExternalInterface.call("onTabChange");
		}
		
		/**
		 * set url hash text to represent current subtab 
		 * @param module	name of module (not part of JS API)
		 * @param subtab	name of subtab to write in url
		 */
		public static function writeUrlHash(module:String, subtab:String):void {
			ExternalInterface.call("kmc.mediator.writeUrlHash", module, subtab);
		}
		
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
		
		/**
		 * open the change user name popup window 
		 * @param fName	user's current first name
		 * @param lName	user's current last name
		 * @param email	user's current email
		 */
		public static function openChangeName(fName:String, lName:String, email:String):void {
//			ExternalInterface.call("kmc.functions.openChangeName", fName, lName, email);
			ExternalInterface.call("kmc.user.changeSetting", 'name', {fname: fName, lname: lName, email: email} );
		}
		
		/**
		 * open the change user password popup window 
		 */
		public static function openChangePwd(mail:String):void {
//			ExternalInterface.call("kmc.functions.openChangePwd", mail);
			ExternalInterface.call("kmc.user.changeSetting", 'password', {email: mail});
		}
		
		/**
		 * open the change user email popup window
		 * @param mail	user's current email 
		 */
		public static function openChangeEmail(mail:String):void {
//			ExternalInterface.call("kmc.functions.openChangeEmail", mail);
			ExternalInterface.call("kmc.user.changeSetting", 'email', {email: mail});
		}
		
		
		/**
		 * open the KCW 
		 * @param conversion_profile
		 * @param uiconftag
		 */
		public static function openKcw(conversion_profile:String, uiconftag:String):void {
			ExternalInterface.call("kmc.functions.openKcw", conversion_profile,uiconftag);
		}
		
		
		
		/**
		 * ask the page where to position the add entry menu 
		 * @return top right point of where the menu should open.
		 */
		public static function getPanelPosition():int {
			return ExternalInterface.call("kmc.functions.getAddPanelPosition");
		}
		
		public static function alerti(str:String):void {
			ExternalInterface.call("alert", str);
		}
	}
}