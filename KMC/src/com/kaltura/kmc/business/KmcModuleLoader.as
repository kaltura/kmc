package com.kaltura.kmc.business 
{
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	
	import mx.events.ModuleEvent;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;

	public class KmcModuleLoader extends EventDispatcher
	{
		
		private static var instance:KmcModuleLoader;

			
		public function loadKmcModule(path:String):void
		{
			var moduleLoader:ModuleLoader = new ModuleLoader();
			moduleLoader.applicationDomain = ApplicationDomain.currentDomain;
			moduleLoader.addEventListener(ModuleEvent.READY , onModuleReady);
			moduleLoader.addEventListener(ModuleEvent.PROGRESS , onModuleProgress);
			moduleLoader.addEventListener(ModuleEvent.ERROR , onModuleError);
			moduleLoader.loadModule( path );
		}
		
		public function onModuleProgress(event:ModuleEvent):void
		{
			if(event.bytesLoaded == event.bytesTotal)
			{
				trace("onModuleReady");	
				dispatchEvent(new KmcModuleEvents(KmcModuleEvents.MODULE_LOADED ,event.target as ModuleLoader));
			}
				
		}
		
		public function onModuleReady(event:ModuleEvent):void
		{
			trace("onModuleReady");
		}
		
		public function onModuleError(event:ModuleEvent):void
		{
			trace("onModuleError");
		}
		
		public function KmcModuleLoader(p_key:SingletonBlocker)
		{
			if (p_key == null) {
				throw new Error("Error: Instantiation failed: Use KmcModuleLoader.getInstance() instead of new.");
			}

		}

		public static function getInstance():KmcModuleLoader {
			if (instance == null) {
				instance = new KmcModuleLoader(new SingletonBlocker());
			}
			return instance;
		}

	}
}
// this class is only available to SingletonDemo
// (despite the internal access designation)
internal class SingletonBlocker {}