package com.kaltura.kmc.modules.content.utils
{
	import com.kaltura.types.KalturaCategoryUserPermissionLevel;

	public class CategoryUserUtil
	{
		public function CategoryUserUtil()
		{
		}
		
		
		public static function getPermissionNames(permissionLevel:int):String {
			var result:String;
			switch(permissionLevel) {
				case KalturaCategoryUserPermissionLevel.MEMBER:
					result = "CATEGORY_VIEW";
					break;
				case KalturaCategoryUserPermissionLevel.CONTRIBUTOR:
					result = "CATEGORY_CONTRIBUTE,CATEGORY_VIEW";
					break;
				case KalturaCategoryUserPermissionLevel.MODERATOR:
					result = "CATEGORY_MODERATE,CATEGORY_CONTRIBUTE,CATEGORY_VIEW";
					break;
				case KalturaCategoryUserPermissionLevel.MANAGER:
					result = "CATEGORY_EDIT,CATEGORY_MODERATE,CATEGORY_CONTRIBUTE,CATEGORY_VIEW";
					break;
			}
			return result;
		}
	}
}