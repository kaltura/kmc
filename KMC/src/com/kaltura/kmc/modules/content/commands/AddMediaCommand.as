package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryAdd;
	import com.kaltura.commands.media.MediaAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.MediaEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.kmc.modules.content.vo.CategoryVO;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaMediaEntry;
	
	import mx.resources.ResourceManager;

	public class AddMediaCommand extends KalturaCommand {
		//whether to open drilldown after media is created
		private var _openDrilldown:Boolean;
		//true if a multrirequest was sent
		private var _isMR:Boolean = false;
		
		override public function execute(event:CairngormEvent):void 
		{
			var mediaEvent:MediaEvent = event as MediaEvent;
			var mediaEntry:KalturaMediaEntry = mediaEvent.entry;
			var defaultCatName:String = ResourceManager.getInstance().getString('cms','defaultCategoryName');
			mediaEntry.categories = defaultCatName;
			_openDrilldown = mediaEvent.openDrilldown;
			
			var mr:MultiRequest = new MultiRequest();
			var addMedia:MediaAdd = new MediaAdd(mediaEntry);
			//multirequest or addMedia
			var callToSend:KalturaCall = addMedia;
			
			var categories:Array = _model.filterModel.categoriesMap.values;
			var defaultCatExists:Boolean = false;
			//looks if default category already exists
			for each (var category:CategoryVO in categories) {
				if (category.name==defaultCatName) {
					mediaEntry.categoriesIds = category.name; //required?
					defaultCatExists = true;
					break;
				}
			}
			//default category doesn't exist- add it and send multirequest
			if (!defaultCatExists) {
				var newCategory:KalturaCategory = new KalturaCategory();
				newCategory.name = defaultCatName;
				mediaEntry.name = defaultCatName;
				//TODO should be configurable?
				newCategory.parentId = 0;
				var addCategory:CategoryAdd = new CategoryAdd(newCategory);
				_isMR = true;
				mr.addAction(addCategory);
				mr.addAction(addMedia);	
				mr.mapMultiRequestParam(0, "id", 1, "categoriedIds"); //required?
				callToSend = mr;
			}	
			
			callToSend.addEventListener(KalturaEvent.COMPLETE, result);
			callToSend.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(callToSend);
		}
		
		override public function result(data:Object):void {
			_model.entryDetailsModel.selectedEntry = _isMR ?  data.data[1] as KalturaMediaEntry : data.data as KalturaMediaEntry;
			if (_openDrilldown) {	
				var cgEvent:WindowEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.ENTRY_DETAILS_WINDOW_NEW_ENTRY);
				cgEvent.dispatch();
			}
		}
		
	}
}