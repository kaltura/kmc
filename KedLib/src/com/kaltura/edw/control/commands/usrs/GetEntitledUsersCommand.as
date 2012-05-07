package com.kaltura.edw.control.commands.usrs
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.UsersEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class GetEntitledUsersCommand extends KedCommand {
		
		private var _type:String;
		
		override public function execute(event:KMvCEvent):void {
			_type = event.type;
			_model.increaseLoadCounter();
			
			var mr:MultiRequest = new MultiRequest();
			var ids:Array = event.data.split(",");
			var getUser:UserGet 
			
			for (var i:int = 0; i<ids.length; i++) {
				getUser = new UserGet(ids[i]);
				mr.addAction(getUser);
					
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(mr);
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.data && data.data is Array) {
				var isError:Boolean = checkErrors(data);
				if (!isError) {
					var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
					switch (_type) {
						case UsersEvent.GET_ENTRY_EDITORS:
							edp.entryEditors = data.data as Array;
							break;
						
						case UsersEvent.GET_ENTRY_PUBLISHERS:
							edp.entryPublishers = data.data as Array;
							break;
					}
				}
			}
			_model.decreaseLoadCounter();
		}
	}
}