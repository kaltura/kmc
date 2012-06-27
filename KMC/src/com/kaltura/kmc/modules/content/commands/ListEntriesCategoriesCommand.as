package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.commands.categoryEntry.CategoryEntryList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.view.window.RemoveCategoriesWindow;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaCategoryEntry;
	import com.kaltura.vo.KalturaCategoryEntryFilter;
	import com.kaltura.vo.KalturaCategoryEntryListResponse;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class ListEntriesCategoriesCommand extends KalturaCommand {
		
		private var _origin:RemoveCategoriesWindow; 
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_model.selectedEntriesCategories = null;
			
			if (event.data is RemoveCategoriesWindow) {
				_origin = event.data as RemoveCategoriesWindow;
			}
			var f:KalturaCategoryEntryFilter = new KalturaCategoryEntryFilter();
			
			var ids:String = '';
			for (var i:uint = 0; i < _model.selectedEntries.length; i++) {
				ids += (_model.selectedEntries[i] as KalturaBaseEntry).id + ",";
			}
			f.entryIdIn = ids;
			
			var list:CategoryEntryList = new CategoryEntryList(f);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(list);
			
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			// look for error
			var str:String = '';
			var er:KalturaError = (data as KalturaEvent).error;
			var rm:IResourceManager = ResourceManager.getInstance();
			if (er) {
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				return;
			}
			
			// handle KalturaCategoryEntryListResponse
			if (data.data is KalturaCategoryEntryListResponse) {
				var f:KalturaCategoryFilter = new KalturaCategoryFilter();
				var orig:Array = (data.data as KalturaCategoryEntryListResponse).objects;
				if (!orig) {
					// non of the entries was in any categories
					if (_origin) {
						// close the window (oish, this is ugly)
						_origin.dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
					}
					return;
				}
				var uniques:Array = [];
				var i:int;
				var found:Boolean;
				for (i = 0; i<orig.length; i++) {
					found = false;
					for each (var kce:KalturaCategoryEntry in uniques) {
						if (kce.categoryId == orig[i].categoryId) {
							found = true;
							break;
						}
					}
					if (!found) {
						uniques.push(orig[i]);
						str += orig[i].categoryId + ",";
					}
				}
				f.idIn = str;
					
				var list:CategoryList = new CategoryList(f);
				list.addEventListener(KalturaEvent.COMPLETE, result);
				list.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(list);
			}
			else if (data.data is KalturaCategoryListResponse) {
				
				_model.selectedEntriesCategories = new ArrayCollection((data.data as KalturaCategoryListResponse).objects);
			}
		}
	}
}