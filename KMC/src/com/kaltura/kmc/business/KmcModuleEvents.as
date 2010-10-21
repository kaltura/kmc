package com.kaltura.kmc.business
{
	import flash.events.Event;
	
	import mx.modules.ModuleLoader;
	
	public class KmcModuleEvents extends Event
	{
		public static const MODULE_LOADED:String = "moduleLoaded";
		public var moduleLoader:ModuleLoader;
		
		public function KmcModuleEvents(type:String,moduleLoader:ModuleLoader, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.moduleLoader = moduleLoader; 
			super(type, bubbles, cancelable);
		}
	}
}