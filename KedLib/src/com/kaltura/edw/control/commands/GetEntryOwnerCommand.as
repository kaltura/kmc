package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaUser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class GetEntryOwnerCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			
			var getUser:UserGet = new UserGet(event.data);
			
			getUser.addEventListener(KalturaEvent.COMPLETE, result);
			getUser.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(getUser);
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && data.data is KalturaUser) {
				var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
				edp.selectedEntryOwner = data.data as KalturaUser;
			}
			else if (data.data is KalturaError) {
				Alert.show((data.data as KalturaError).errorMsg, ResourceManager.getInstance().getString('drilldown', 'error'));
			}
			_model.decreaseLoadCounter();
		}
	}
}