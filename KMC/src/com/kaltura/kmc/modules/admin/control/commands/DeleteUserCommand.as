package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.user.UserDelete;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import mx.collections.ArrayCollection;

	public class DeleteUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			// delete
			var call:KalturaCall = new UserDelete((event as UserEvent).user.id);
			mr.addAction(call);
			// list
			call = new UserList(_model.usersModel.usersFilter);
			mr.addAction(call);
			// post
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(mr);
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			var response:KalturaUserListResponse = data.data[1] as KalturaUserListResponse;
			_model.usersModel.users = new ArrayCollection(response.objects);
		}
	}
}