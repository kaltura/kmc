package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class UpdateSubCategoriesCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			
			var ar:Array = event.data as Array;
			var mr:MultiRequest = new MultiRequest();
			var catUpdate:CategoryUpdate;
			for (var i:int = 0; i<ar.length; i++) {
				ar[i].setUpdatedFieldsOnly(true);
				catUpdate = new CategoryUpdate(ar[i].id, ar[i]);
				mr.addAction(catUpdate);
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}
		
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var rm:IResourceManager = ResourceManager.getInstance();
			
			// check for errors
			var er:KalturaError = (data as KalturaEvent).error;
			if (er) { 
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				return;
			}
			else {
				// look iside MR
				for each (var o:Object in data.data) {
					er = o as KalturaError;
					if (er) {
						Alert.show(getErrorText(er), rm.getString('cms', 'error'));
					}
					else if (o.error) {
						// in MR errors aren't created
						var str:String = rm.getString('cms', o.error.code);
						if (!str) {
							str = o.error.message;
						} 
						Alert.show(str, rm.getString('cms', 'error'));
					}
				}	
			}
			
			
		}
	}
}