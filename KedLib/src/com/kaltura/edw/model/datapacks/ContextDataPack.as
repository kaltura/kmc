package com.kaltura.edw.model.datapacks
{
	import com.kaltura.KalturaClient;
	import com.kaltura.kmvc.model.IDataPack;
	
	import flash.events.IEventDispatcher;
	
	import mx.containers.ViewStack;
	import mx.core.UIComponent;
	
	[Bindable]
	/**
	 * information about the context in which this app is running
	 * */
	public class ContextDataPack implements IDataPack
	{
		public var shared:Boolean = true;
		
		public static const DEFAULT_UI_CONFIG_ID:String = "10000";
	
 		public var userId:String;
		public var isAnonymous:Boolean;
		public var subpId:int;
		public var uiConfigId:String = DEFAULT_UI_CONFIG_ID;
		
		/**
		 * uiconf for player in moderation tab 
		 */
		public var moderationUiconf:String = DEFAULT_UI_CONFIG_ID;
		
		/**
		 * uiconf for metadata tab in drilldown 
		 */		
		public var drilldownUiconf:String = DEFAULT_UI_CONFIG_ID;
		
		/**
		 * uiconf for advertisements tab in drilldown
		 */
		public var drilldownAdsUiconf:String = DEFAULT_UI_CONFIG_ID;
		
		/**
		 * uiconf for capture thumbnail player 
		 */
		public var captureThumbnailUiconf:String;
		
		/**
		 * panels definitions
		 * <panels>
		 * 		<panel id="panelid" url="/modules/panel.swf" styleName="metaDataHbox" index="0" />
		 *		..
		 * </panels> 
		 */
		public var panelsConfig:XML;
		
		/**
		 * should embed code be shown in P&E window 
		 */		
		public var showEmbedCode:Boolean;
		
		/**
		 * partner's landing page 
		 */		
		public var landingPage:String;
		
		/**
		 * JS function used to open P&E
		 */
		public var openPlayerFunc:String;
		
		/**
		 * id of the uiconf used for kClip in drilldown ads tab
		 */
		public var kClipAdsUiconf:String;
		
		public var permissions:int = -1;
		public var groupId:String;
		public var debugMode:Boolean = false;
		
		/**
		 * The PS3 - new flex client API
		 * 
		 */
		public var kc:KalturaClient;
		
		
		/**
		 * the protocol used for communication (like http://)
		 */
		public var protocol:String;
		
		/**
		* protocol (like http://) and then  domain (like www.kaltura.com)
		* e.g: swf that came from http://www.yourdomain.com/dir/file.swf will have "http://www.yourdomain.com/" as its root url
		*/
		public var rootUrl : String;
		
		/**
		 * host from which to load media, for entry drilldown KDP.
		 * protocol (like http://) and then  domain (like www.kaltura.com)
		 */
		public var cdnHost : String;
		
		/**
		* This url from which this swf came from, omitting the [filename.swf]
		* e.g: swf that came from http://www.yourdomain.com/dir/file.swf will have "http://www.yourdomain.com/dir/" as its source url
		*/
		public var sourceUrl:String;

		/**
		 *The hosting server name, e.g. "kaltura.com"
		 */
		public var hostName:String;

		/**
		 *The main swf file name (e.g "ContributionWizard.swf")
		 */
		public var fileName:String
		
		/**
		 * an IEventDispatcher used to dispatch events to which an 
		 * envelope application can listen.
		 * */
		public var dispatcher:IEventDispatcher;
		
		/**
		 * max number of categories in a single level that will show in the tree
		 * when chuncked category load
		 * @internal
		 * set in uiconf, should match the server flag that triggers chuncked category load feature 
		 */
		public var singleLevelMaxCategories:int;

		public function get defaultUrlVars() :Object
		{
			return {uid: userId,
					partner_id: kc.partnerId,
					subp_id: subpId,
					ks: kc.ks};
		}
	}
}