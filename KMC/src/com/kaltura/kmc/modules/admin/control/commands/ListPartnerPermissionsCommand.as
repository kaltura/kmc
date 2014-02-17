package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.permission.PermissionList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaPermission;
	import com.kaltura.vo.KalturaPermissionListResponse;
	
	public class ListPartnerPermissionsCommand extends BaseCommand {
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			var largePager:KalturaFilterPager = new KalturaFilterPager();
			largePager.pageSize = 500;
			var ul:PermissionList = new PermissionList(_model.rolesModel.permissionsFilter, largePager);
			ul.addEventListener(KalturaEvent.COMPLETE, result);
			ul.addEventListener(KalturaEvent.FAILED, fault);
			if (_model.kc) {
				_model.increaseLoadCounter();
				_model.kc.post(ul);
			}
		}
		
		
		/**
		 * set received data on model
		 * @param data data returned from server.
		 */
		override protected function result(data:Object):void {
			super.result(data);
			var response:KalturaPermissionListResponse = data.data as KalturaPermissionListResponse;
			_model.rolesModel.partnerPermissions = parsePartnerPermissions(response);
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * parse the permissions list response
		 * @param klr	the permissions list response
		 * @return a comma separated string of partner permission ids.
		 * */
		protected function parsePartnerPermissions(klr:KalturaPermissionListResponse):String {
			var result:String = '';
			for each (var kperm:KalturaPermission in klr.objects) {
				result += kperm.name + ",";
			}
			// remove last ","
			result = result.substring(0, result.length - 1);
			return result;
		}
	}
}