package com.kaltura.kmc.business.module {
	import com.kaltura.kmc.business.KmcModuleLoader;
	import com.kaltura.kmc.events.KmcModuleEvent;
	import com.kaltura.kmc.modules.KmcModule;
	
	import flash.system.ApplicationDomain;
	
	import mx.containers.HBox;
	import mx.controls.ComboBox;
	import mx.events.ModuleEvent;
	import mx.modules.ModuleLoader;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	public class TestKmcModuleLoader {
		private var _kmcModuleLoader:KmcModuleLoader;


		[Before]
		public function setUp():void {
			_kmcModuleLoader = new KmcModuleLoader();
		}


		[After]
		public function tearDown():void {
			_kmcModuleLoader = null;
		}


		[Test(async, description="if module loaded, say so")]
		public function testOnModuleReady():void {
			KmcModule;HBox;ComboBox;
			var asyncHandler:Function = Async.asyncHandler(this, handleSuccess, 5000, null, handleTimeout);
			_kmcModuleLoader.addEventListener(KmcModuleEvent.MODULE_LOADED, asyncHandler, false, 0, true);
			var ml:ModuleLoader = _kmcModuleLoader.loadKmcModule("modules/Dashboard.swf", "dashboard");
			ml.loadModule();
		}


		[Test(async, description="if error loading module, catch the error")]
		public function testOnModuleError():void {
			KmcModule; 
			var asyncHandler:Function = Async.asyncHandler(this, handleSuccess, 10000, null, handleTimeout);
			_kmcModuleLoader.addEventListener(KmcModuleEvent.MODULE_LOAD_ERROR, asyncHandler, false, 0, true);
			var ml:ModuleLoader = _kmcModuleLoader.loadKmcModule("modules/Dashboard1.swf", "dashboard");
			ml.loadModule();
		}


		protected function handleSuccess(event:KmcModuleEvent, passThroughData:Object = null):void {
			trace(event.type, event.errorText);
		}


		



		protected function handleTimeout(passThroughData:Object):void {
			Assert.fail("Timeout reached before event");
		}
	}
}