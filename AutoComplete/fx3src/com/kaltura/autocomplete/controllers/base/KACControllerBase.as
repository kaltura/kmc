package com.kaltura.autocomplete.controllers.base
{
	import com.hillelcoren.components.AutoComplete;
	import com.kaltura.KalturaClient;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.net.KalturaCall;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;

	public class KACControllerBase
	{
		public var minPrefixLength:uint = 3;
		
		protected var _elementSelection:ArrayCollection;
		protected var _autoComp:AutoComplete;
		protected var _client:KalturaClient;
		
		private var _pendingCall:KalturaCall;
		
		public function KACControllerBase(autoComp:AutoComplete, client:KalturaClient)
		{
			_elementSelection = new ArrayCollection();
			_autoComp = autoComp;
			_autoComp.autoSelectEnabled = false;
			_client = client;
			
			_autoComp.dataProvider = _elementSelection;
			_autoComp.addEventListener(AutoComplete.SEARCH_CHANGE, onSearchChange);
		}
		
		private function onSearchChange(event:Event):void{
			if (_autoComp.searchText != null){
				if (_pendingCall != null){
					_pendingCall.removeEventListener(KalturaEvent.COMPLETE, result);
					_pendingCall.removeEventListener(KalturaEvent.FAILED, fault);
				}
				
				_autoComp.clearSuggestions();
				
				if (_autoComp.searchText.length > (minPrefixLength - 1)){
					_elementSelection.removeAll();
					
					var call:KalturaCall = createCallHook();
					
					call.addEventListener(KalturaEvent.COMPLETE, result);
					call.addEventListener(KalturaEvent.FAILED, fault);
					call.queued = false;
					_autoComp.notifySearching();
					_pendingCall = call;
					_client.post(call);
				} 
			}
		}
		
		private function result(data:Object):void{
			_pendingCall = null;
			var elements:Array = fetchElements(data);
			if (elements != null && elements.length > 0){
				for each (var element:Object in elements){
					_elementSelection.addItem(element);
				}
			}
			_autoComp.search();
		}
		
		protected function fault(info:KalturaEvent):void{
			throw new Error(info.error.errorMsg);
		}
		
		protected function fetchElements(data:Object):Array{
			return null;
		}
		
		protected function createCallHook():KalturaCall{
			return null;
		}
	}
}