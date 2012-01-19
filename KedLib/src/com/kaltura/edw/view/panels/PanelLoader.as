package com.kaltura.edw.view.panels
{
	import flash.errors.IllegalOperationError;

	public class PanelLoader
	{
		private static var _instance:PanelLoaderImp;
		
		static public function initialize(metaData:PanelMetadataVO, urlPrefix:String):void{
			_instance = new PanelLoaderImp(metaData, urlPrefix);
		}
		
		static public function get instance():IPanelLoaderImp{
			if (_instance == null){
				throw new IllegalOperationError("PanelLoader: initializtion is required");
			}
			return _instance;
		}
		
		static public function clear():void{
			_instance = null;
		}
	}
}
import com.kaltura.edw.business.IDrilldownPanel;
import com.kaltura.edw.view.panels.IPanelLoaderImp;
import com.kaltura.edw.view.panels.PanelMetadataVO;

import flash.errors.IOError;
import flash.system.ApplicationDomain;
import flash.utils.Dictionary;

import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.modules.ModuleManager;

class PanelLoaderImp implements IPanelLoaderImp{
	
	private var _data:PanelMetadataVO;
	private var _moduleInfos:Vector.<IModuleInfo>; // Made to prevent GC issues.
	private var _callbackDict:Dictionary;
	private var _creationQueue:Vector.<CreationVO>
	private var _isBusy:Boolean;
	private var _loadedModules:Object;
	private var _urlPrefix:String;
	
	public function PanelLoaderImp(panelData:PanelMetadataVO, urlPrefix:String){
		_data = panelData;
		_moduleInfos = new Vector.<IModuleInfo>;
		_callbackDict = new Dictionary(true);
		_creationQueue = new Vector.<CreationVO>;
		_loadedModules = new Object();
		_urlPrefix = urlPrefix;
	}
	
	public function createPanel(panelId:String, successCallback:Function, passThrough:Object = null):void{
		if (_loadedModules[panelId] != null){
			createAndNotify(successCallback, _loadedModules[panelId], passThrough, panelId);
		} else {
			prepareLoading(panelId, successCallback, passThrough);
		}
	}
	
	private function prepareLoading(panelId:String, successCallback:Function, passThrough:Object):void{
		var vo:CreationVO = new CreationVO();
		vo.panelId = panelId;
		vo.successCallback = successCallback;
		vo.passThrough = passThrough;
		_creationQueue.push(vo);
		if (! _isBusy){
			_isBusy = true;
			loadPanelModule();
		}
	}
	
	private function loadPanelModule():void{
		var panelId:String = _creationQueue[0].panelId;
		var url:String = getModuleUrl(panelId);
		if (url.indexOf("://") == -1){
			url = _urlPrefix + url;
		}
		var mInfo:IModuleInfo = ModuleManager.getModule(url);
		_moduleInfos.push(mInfo);
		mInfo.addEventListener(ModuleEvent.READY, onModuleReady);
		mInfo.addEventListener(ModuleEvent.ERROR, onLoadingError);
		mInfo.load(ApplicationDomain.currentDomain);
	}
	
	private function onLoadingError(evt:ModuleEvent):void{
		throw new IOError("Failed to load KED module from url: '" + evt.module.url + "': " + evt.errorText);
	}
	
	private function onModuleReady(evt:ModuleEvent):void{
		evt.module.removeEventListener(ModuleEvent.READY, onModuleReady);
		
		var lastCall:CreationVO = _creationQueue.shift();
		_loadedModules[lastCall.panelId] = evt.module;
		createAndNotify(lastCall.successCallback, evt.module, lastCall.passThrough, lastCall.panelId);
		
		// Filtering out matching requests and responding to each. 
		var matching:Vector.<CreationVO> = extractMatchingRequests(lastCall.panelId);
		for each (var creationRequest:CreationVO in matching){
			createAndNotify(creationRequest.successCallback, evt.module, creationRequest.passThrough, creationRequest.panelId);
		}
		
		if (_creationQueue.length > 0){
			loadPanelModule();
		} else {
			_isBusy = false;
		}
	}
	
	private function extractMatchingRequests(panelId:String):Vector.<CreationVO>{
		var result:Vector.<CreationVO> = _creationQueue.filter( 
			function (item:CreationVO, index:int, vect:Vector.<CreationVO>):Boolean{
				return item.panelId == panelId;
			});
		
		_creationQueue = _creationQueue.filter(
			function (item:CreationVO, index:int, vect:Vector.<CreationVO>):Boolean{
				return item.panelId != panelId;
			});
		
		return result;
	}
	
	private function createAndNotify(callback:Function, module:IModuleInfo, passThrough:Object, panelId:String):void{
		var obj:Object = module.factory.create();
		var panel:IDrilldownPanel =  obj as IDrilldownPanel;
		
		if (_data.styleMapping[panelId] != null){
			panel.styleName = _data.styleMapping[panelId] as String;
		}
		
		if (passThrough != null){
			callback.call(null, panel, passThrough);
		} else {
			callback.call(null, panel);
		}
	}
	
	private function getModuleUrl(panelId:String):String{
		return _data.urlMapping[panelId] as String;
	}
	
	public function get panelData():PanelMetadataVO{
		return _data;
	}
}

class CreationVO{
	public var panelId:String;
	public var successCallback:Function;
	public var passThrough:Object;
}