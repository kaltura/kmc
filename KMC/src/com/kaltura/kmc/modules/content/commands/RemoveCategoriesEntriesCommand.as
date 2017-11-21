package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryEntry.CategoryEntryDelete;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryEntry;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class RemoveCategoriesEntriesCommand extends KalturaCommand {
		
		
		private static const CHUNK_SIZE:int = 50;
		private var _calls:Array; 
		
		
		/**
		 * crete the list of categoryEntry.delete calls that should be executed
		 * according to given entries and categories
		 * */
		private function genenrateCallsList(entries:Array, categories:Array):Array {
			var calls:Array = [];
			var ced:CategoryEntryDelete;
			var kce:KalturaCategoryEntry;
			for each (var kbe:KalturaBaseEntry in entries) {
				for each (var kc:KalturaCategory in categories) {
					for (var i:int = 0; i<_model.selectedEntriesCategoriesKObjects.length; i++) {
						kce = _model.selectedEntriesCategoriesKObjects[i] as KalturaCategoryEntry;
						if (kce.entryId == kbe.id && kce.categoryId == kc.id) {
							ced = new CategoryEntryDelete(kbe.id, kc.id);
							calls.push(ced);
							_model.selectedEntriesCategoriesKObjects.splice(i, 1);
							break;
						}
					}
				}
			}
			return calls;
		}
		
		
		/**
		 * send an MR with up-to-CHUNK_SIZE next calls
		 * */ 
		private function issueNextCall() {
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			mr.actions = _calls.splice(0, CHUNK_SIZE);
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}
		
		
		override public function execute(event:CairngormEvent):void {
			// for each entry, if it has the category remove it.
			// split calls array to chunks of CHUNK_SIZE calls per MR
			var e:EntriesEvent = event as EntriesEvent;
			var categories:Array = e.data as Array; // elements are KalturaCategories
			var entries:Array = _model.selectedEntries;
			
			_calls = this.genenrateCallsList(entries, categories);
			_model.selectedEntriesCategoriesKObjects = null;
			issueNextCall(); 
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			// look for error
			var str:String = '';
			var er:KalturaError = (data as KalturaEvent).error;
			var rm:IResourceManager = ResourceManager.getInstance();
			if (er) {
				str = rm.getString('cms', er.errorCode);
				if (!str) {
					str = er.errorMsg;
				} 
				Alert.show(str, rm.getString('cms', 'error'));
				
			}
			else {
				// look inside MR, ignore irrelevant
				for each (var o:Object in data.data) {
					er = o as KalturaError;
					if (er) {
						if (er.errorCode != "ENTRY_IS_NOT_ASSIGNED_TO_CATEGORY") {
							str = rm.getString('cms', er.errorCode);
							if (!str) {
								str = er.errorMsg;
							} 
							Alert.show(str, rm.getString('cms', 'error'));
						}
					}
					else if (o.error) {
						// in MR errors aren't created
						if (o.error.code != "ENTRY_IS_NOT_ASSIGNED_TO_CATEGORY") {
							str = rm.getString('cms', o.error.code);
							if (!str) {
								str = o.error.message;
							} 
							Alert.show(str, rm.getString('cms', 'error'));
						}
					}
				}	
			}
			if (_calls.length > 0) {
				issueNextCall();
			}
			else {
				allChunksDone();
			}
		}
		
		private function allChunksDone():void {
			var searchEvent:KMCSearchEvent = new KMCSearchEvent(KMCSearchEvent.DO_SEARCH_ENTRIES , _model.listableVo  );
			searchEvent.dispatch();
		}
	}
}