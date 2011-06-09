package com.kaltura.kmc.business
{
	import com.kaltura.KalturaClient;
	import com.kaltura.kmc.events.KmcErrorEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import mx.events.ModuleEvent;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	import mx.resources.ResourceManager;

	public class KmcPluginManager extends EventDispatcher {
		
		/**
		 * KMC uiconf, holds data regarding modules and plugins 
		 */
		private var _uiconf:XML;
		
		/**
		 * associative array of plugins (FlexModules) that KMC loaded, 
		 * listed by their ids
		 * */
		private var _plugins:Object;
		
		/**
		 * something to addChild plugins to 
		 */
		private var _approot:DisplayObjectContainer;
		
		/**
		 * client for API calls 
		 */
		private var _client:KalturaClient;
		
		
		public function KmcPluginManager(approot:DisplayObjectContainer, client:KalturaClient)
		{
			_approot = approot;
			_client = client;
			_plugins = new Object(); 
		}
		
		
		/**
		 * load the FlexModule
		 * @param pluginInfo xml with plugin load info 
		 * 			<plugin id="addCode" path="modules/Add.swf" dependencies="add,admin"/>
		 */
		private function loadPlugin(pluginInfo:XML):void {
			var pluginLoader:ModuleLoader = new ModuleLoader();
			pluginLoader.applicationDomain = ApplicationDomain.currentDomain;
			pluginLoader.addEventListener(ModuleEvent.READY, onPluginLoaded);
			pluginLoader.addEventListener(ModuleEvent.ERROR, onPluginLoadError);
			pluginLoader.url = pluginInfo.@path;
			_approot.addChild(pluginLoader);
		}
		
		/**
		 * when the plugin is loaded, assign it an id according
		 * to uiconf and put it in the plugins list
		 * */
		private function onPluginLoaded (e:ModuleEvent):void {
			var ml:ModuleLoader = e.target as ModuleLoader;
			if (ml.parent) {
				ml.parent.removeChild(ml);
			}
			ml.removeEventListener(ModuleEvent.READY, onPluginLoaded);
			ml.removeEventListener(ModuleEvent.ERROR, onPluginLoadError);
			var pluginInfo:XML = _uiconf.plugins.plugin.(@path == ml.url)[0]; 
			var plugin:Module = ml.child as Module;
			plugin.id = pluginInfo.@id.toString();
			if (plugin is IPopupMenu) {
				(plugin as IPopupMenu).setRoot(_approot);
			}
			if (plugin is IKmcPlugin) {
				(plugin as IKmcPlugin).client = _client;
			}
			_plugins[plugin.id] = plugin;
			
		}
		
		
		/**
		 * dispatch a KMCErrorEvent
		 * @param e
		 */
		private function onPluginLoadError (e:ModuleEvent):void {
			dispatchEvent(new KmcErrorEvent(KmcErrorEvent.ERROR, e.errorText));
		}
		
		/**
		 * load required KMC plugins 
		 * */
		public function loadPlugins(uiconf:XML):void {
			_uiconf = uiconf;
			// see if plugin is needed, then load it.
			var plugins:XMLList = uiconf.plugins.plugin;
			var module:XMLList;
			
			for each (var pluginInfo:XML in plugins) {
				var dependencies:Array = pluginInfo.@dependencies.split(",");
				for (var i:int =0;i <dependencies.length; i++) {
					module = uiconf.modules.module.(@id == dependencies[i]);
					if (module.length() > 0) {
						// load plugin, then break.
						loadPlugin(pluginInfo);
						break;
					}
				}
			}
		}
		
		public function executePluginMethod(pluginId:String, methodName:String, ...args):* {
			try {
				return _plugins[pluginId][methodName].apply(_plugins[pluginId], args);
			} catch (e:Error) {
				dispatchEvent(new KmcErrorEvent(KmcErrorEvent.ERROR, ResourceManager.getInstance().getString('kmc', 'method_dont_exist', [pluginId, methodName])));
			}
		}
	}
}