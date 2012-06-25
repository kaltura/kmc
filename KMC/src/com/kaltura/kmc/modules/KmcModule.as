package com.kaltura.kmc.modules {
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.uiConf.UiConfGet;
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.events.KmcErrorEvent;
	import com.kaltura.kmc.events.KmcNavigationEvent;
	import com.kaltura.kmc.utils.XMLUtils;
	import com.kaltura.kmc.vo.Context;
	import com.kaltura.kmc.vo.UserVO;
	import com.kaltura.vo.KalturaUiConf;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getQualifiedClassName;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.FlexEvent;
	import mx.events.ResourceEvent;
	import mx.modules.Module;
	import mx.resources.ResourceManager;
	
	// =====================================================
	// events
	// =====================================================

	/**
	 * Dispatched when the module is ready to take action.
	 * @eventType flash.events.Event
	 */
	[Event(name="moduleReady", type="flash.events.Event")]
	
	/**
	 * Dispatched when the module needs to navigate to another module.
	 * @eventType com.kaltura.kmc.events.KmcNavigationEvent
	 */
	[Event(name="navigate", type="com.kaltura.kmc.events.KmcNavigationEvent")]

	/**
	 * Dispatched when the module encountered some error that prevents it from functioning.
	 * @eventType com.kaltura.kmc.events.KmcErrorEvent
	 */
	[Event(name="error", type="com.kaltura.kmc.events.KmcErrorEvent")]

	/**
	 * Dispatched when user clicked a help link.
	 * The <code>page</code> parameter is the anchor on help page.
	 * @eventType com.kaltura.kmc.events.KmcHelpEvent
	 */
	[Event(name="help", type="com.kaltura.kmc.events.KmcHelpEvent")]

	/**
	 * Dispatched when module has finished saving necessary data and application can navigate
	 * to a different module
	 * @eventType flash.events.Event
	 */
	[Event(name="finishedSaving", type="flash.events.Event")]

	
	
	/**
	 * KmcModule is an abstract class that holds common functionalities of KMC modules.
	 * */
	public class KmcModule extends Module {
		

		// =====================================================
		// members
		// =====================================================

		public static const FINISHED_SAVING:String = "finishedSaving";
		
		public static const MODULE_READY:String = "moduleReady";
		
		private const FALLBACK_LOCALE:String = "en_US";
		
		/**
		 * PermissionManager instance 
		 */		
		protected var permissionManager:PermissionManager= PermissionManager.getInstance();
		
		/**
		 * all the flashvars, lowercased with no underscores 
		 */
		protected var _flashvars:Object;
		
		/**
		 * @copy #kc
		 * */
		protected var _kc:KalturaClient;
		
	
		[Bindable]
		/**
		 * @copy #userInfo
		 * */
		protected var _userInfo:UserVO;
		
		
		[Bindable]
		/**
		 * @copy #context
		 * */
		protected var _context:Context;

		/**
		 * currently showing locale code
		 * */
		protected var _localeCode:String;

		/**
		 * @copy #uiconfId
		 * */
		protected var _uiconfId:String;

		/**
		 * configuration object
		 * */
		protected var _uiconf:KalturaUiConf;
		
		/**
		 * set to "true" when the module is functional
		 */
		public var isModuleReady:Boolean;


		// =====================================================
		// methods
		// =====================================================



		/**
		 * load configuration info
		 * */
		protected function loadUiconf(uiconfId:String):void {
			var uiconf:UiConfGet = new UiConfGet(int(uiconfId));
			uiconf.addEventListener(KalturaEvent.COMPLETE, configurationLoadHandler);
			uiconf.addEventListener(KalturaEvent.FAILED, configurationLoadFailedHandler);
			_kc.post(uiconf);
		}

		/**
		 * decide if should use relative or absolute url.
		 * if the given path is ablsolute, return the same string.
		 * if the given path is relative, concatenate it to the swf url.
		 * @param	given path
		 * @return	path to use
		 * */
		protected function getLoadUrl(path:String):String {
			var url:String;
			if (path.indexOf("http") == 0) {
				url = path;
			}
			else {
				var li:String = Application.application.loaderInfo.url; 
				var base:String = li.substr(0, li.lastIndexOf("/"));  
				url = base + "/" + path;
			}
			return url;
		}


		/**
		 * use configuration info
		 * @param e		data from server
		 * */
		protected function configurationLoadHandler(e:KalturaEvent):void {
			_uiconf = e.data as KalturaUiConf;
			// update any values from flashvars
			_uiconf.confFile = overrideDataByFlashvars(_uiconf.confFile, _flashvars);
			var confFile:XML = new XML(_uiconf.confFile);
			loadLocale(getLoadUrl(confFile.locale.path.toString()), confFile.locale.language.toString());
		}
		
		
		/**
		 * if any flashvars are supposed to override uiconf values, set them here to the uiconf.
		 * flashvars names will be constructed from module id + "." + xml structure, nodes 
		 * separated by ".", i.e, "content.uiconf.metadata" or "admin.locale.language"
		 */		
		protected function overrideDataByFlashvars(conf:String, flashvars:Object):String {
			var confFile:XML = new XML(conf);
			// override with general language definition
			if (flashvars.language && !flashvars[getModuleName() + ".locale.language"] ) {
				flashvars[getModuleName() + ".locale.language"] = flashvars.language;
			}
			
			// process
			for (var key:String in flashvars) {
				var elements:Array = key.split(".");
				if (elements[0] == getModuleName()) {
					// need to process
					// get to the node we need to edit
					var xml:XML = XMLUtils.getElement(confFile, elements);
					if (xml) {
						delete xml.children()[0];
						xml.appendChild(flashvars[key]);
					}
				}
			}
			// re-set values
			return confFile.toXMLString();
		}
		

		/**
		 * failed loading uiconf
		 * @param e		data from server
		 * */
		protected function configurationLoadFailedHandler(e:KalturaEvent):void {
			// use locale value instead of given error
			// - do we know the resourceBundle name? put all errors in "errors" bundle on all locales 
			dispatchEvent(new KmcErrorEvent(KmcErrorEvent.ERROR, e.error.errorMsg));
		}


		/**
		 * Load locale data.
		 * @param localePath	path to the locale (.swf) file
		 * @param language		locale code (i.e. en_US)
		 * */
		protected function loadLocale(localePath:String, language:String):void {
			_localeCode = language;
			localePath = localePath.replace(/{locale}/g, language);
			var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule(localePath, true);
			eventDispatcher.addEventListener(ResourceEvent.ERROR, localeLoadCompleteHandler);
			eventDispatcher.addEventListener(ResourceEvent.COMPLETE, localeLoadCompleteHandler);
		}


		/**
		 * Set use of loaded locale.
		 * This is also the place to update any values which are not
		 * bound to resource manager values and have to be set manualy.
		 * */
		protected function localeLoadCompleteHandler(event:ResourceEvent):void {
			event.target.removeEventListener(ResourceEvent.COMPLETE, localeLoadCompleteHandler);
			event.target.removeEventListener(ResourceEvent.ERROR, localeLoadCompleteHandler);
			if (event.type == ResourceEvent.ERROR) {
				Alert.show(event.errorText, "Locale Error", Alert.OK);
			}
			var chain:Array;
			if (_localeCode == FALLBACK_LOCALE) {
				chain = [_localeCode];
			}
			else {
				chain = [_localeCode, FALLBACK_LOCALE];
			}
			ResourceManager.getInstance().localeChain = chain;
			start();
		}



		/**
		 * Tell KMC to switch to another module.
		 * @param module	name of module to show, should match the NAME the module declares.
		 * @param subtab	name of subtab of the module to show. If <code>subtab</code> is supplied and the
		 * 					module has a subtab with the same name it should show the matching subtab.
		 * 					Otherwise it is up to the module to decide which subtab to show.
		 * @param extra		a generic object with data to be passed to the module.
		 * */
		protected function navigate(module:String, subtab:String = "", extra:Object = null):void {
			this.dispatchEvent(new KmcNavigationEvent(KmcNavigationEvent.NAVIGATE, module, subtab, extra));
		}


		/**
		 * This is the function that kicks-off any module-specific code. At this point we
		 * know the uiconf is loaded and its data is ready, the locale is loaded and used,
		 * and the application is just waiting for you to tell it what to do next.
		 * Each module should implement this method according to its inner structure.
		 * */
		protected function start():void {
			throw new Error("init must be implemented");
		}


		/**
		 * Initialize the module.
		 * @param kc	KalturaClient for server API calls
		 * @param uiconfid	Id of uiconf that the module has to load.
		 * @param flashvars	application flashvars - any data passed from the wrapper
		 * @param user	current user info
		 * @param cm	the global context menu, to add its version.
		 * @param context	Application context
		 * */
		public function init(kc:KalturaClient, uiconfid:String, flashvars:Object, user:UserVO, cm:ContextMenu, context:Context = null):void {
			Security.allowDomain('*');
			_kc = kc;
			_uiconfId = uiconfid;
			_flashvars = flashvars;
			_userInfo = user;
			_context = context;

			loadUiconf(uiconfid);

//			var moduleVersion:ContextMenuItem = new ContextMenuItem(getModuleName()+" : "+getModuleVersion());
//			cm.customItems.push(moduleVersion);
//			
//			this.contextMenu = cm;

		}
				
		
		/**
		 * Checks if current subTab of this module requires save. 
		 * Dispatches the "finishedSaving" event after all saving is done. 
		 * 
		 */		
		public function checkForSaveSubTab():void {
			this.dispatchEvent(new Event(FINISHED_SAVING, true));
		}
		
		
		/**
		 * The name returned by this method will be the ID of the module in KMC.
		 * Each module must implement this method to return the right name.  
		 */		
		public function getModuleName():String {
			throw new Error(getQualifiedClassName(this) + ".getModuleName() must be implemented");
		}


		/**
		 * Navigate to a subtab in the module.
		 * Each module should implement this method according to its inner structure.
		 * @param subtab	name (id) of the required subtab.
		 * @param data		object with data the subtab should use.
		 * */
		public function showSubtab(subtab:String, data:Object = null):void {
			throw new Error(getQualifiedClassName(this) + ".showSubtab() must be implemented");
		}
		
		
		/**
		 * enables / disables html tabs 
		 * @param enable	if true enables, if false disables
		 */
		protected function enableHtmlTabs(enable:Boolean):void {
//			ExternalInterface.call("kmc.utils.maskHeader", enable);
			JSGate.maskHeader(enable);
		}
		
		
		/**
		 * declare the module as ready and dispatch relevant event 
		 */
		protected function setModuleReady():void {
			isModuleReady = true;
			dispatchEvent(new Event("moduleReady", true));
		}
		
//		public function testMe():void {
//			Alert.show("Bhaaa: " + getModuleName(), "BHOOO");
//		}

		/**
		 * information about the current user and their role
		 * */
		public function get userInfo():UserVO
		{
			return _userInfo;
		}

		/**
		 * @private
		 */
		public function set userInfo(value:UserVO):void
		{
			_userInfo = value;
		}
		
		
		

		// =====================================================
		// getters / setters
		// =====================================================




	}
}