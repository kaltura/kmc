package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class UpdateCategoriesCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var cats:Array = event.data as Array;
			var mr:MultiRequest = new MultiRequest();
			for each (var kCat:KalturaCategory in cats) {
				kCat.setUpdatedFieldsOnly(true);
				var update:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
				mr.addAction(update);
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr); 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			var isErr:Boolean = checkError(data);
			if (!isErr) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'catRemTagsSuccess'));
			}
		}
	}
}