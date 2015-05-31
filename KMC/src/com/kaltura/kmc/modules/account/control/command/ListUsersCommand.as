package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.types.KalturaUserRoleStatus;
	import com.kaltura.types.KalturaUserStatus;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	import com.kaltura.vo.KalturaUserRoleFilter;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import flash.display.Graphics;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexSprite;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import mx.states.AddChild;

	public class ListUsersCommand implements ICommand {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			// roles
			var rfilter:KalturaUserRoleFilter = new KalturaUserRoleFilter();
			rfilter.tagsMultiLikeOr = 'partner_admin';
			rfilter.statusEqual = KalturaUserRoleStatus.ACTIVE;
			var rl:UserRoleList = new UserRoleList(rfilter);
			mr.addAction(rl);
			// users
			var ufilter:KalturaUserFilter = new KalturaUserFilter();
			ufilter.isAdminEqual = KalturaNullableBoolean.TRUE_VALUE;
			ufilter.loginEnabledEqual = KalturaNullableBoolean.TRUE_VALUE;
			ufilter.statusEqual = KalturaUserStatus.ACTIVE;
			ufilter.roleIdsEqual = '0';
			var ul:UserList = new UserList(ufilter);
			mr.addAction(ul);
			mr.mapMultiRequestParam(1, 'objects:0:id', 2, 'filter:roleIdsEqual');
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			mr.queued = false;	// so numbering won't get messed up
			_model.context.kc.post(mr);
		}


		private function result(event:KalturaEvent):void {
			// error handling
			if(event && event.error && event.error.errorMsg && event.error.errorCode == APIErrorCode.INVALID_KS){
				JSGate.expired();
				return;
			}
			
			if (event.data && event.data.length > 0) {
				var l:int = event.data.length ;
				for(var i:int = 0; i<l; i++) {
					if (event.data[i].error && event.data[i].error.code) {
						Alert.show(event.data[i].error.message, ResourceManager.getInstance().getString('account', 'error'));
						return;
					}
				}
			}
			_model.usersList = new ArrayCollection((event.data[1] as KalturaUserListResponse).objects);
		}


		private function fault(event:KalturaEvent):void {
			if (event.error) {
				Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			}
		}
	}
}