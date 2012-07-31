package com.kaltura.kmc.business
{
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.types.KalturaInheritanceType;
	import com.kaltura.vo.KalturaCategory;

	public class CategoryUtils {
		
		public function CategoryUtils()
		{
		}
		
		/**
		 * removes fields that should not be sent to the server even though they are updateable, due to entitlements  
		 * @param cat	category to set
		 */		
		public static function resetUnupdateableFields(cat:KalturaCategory):void {
			// no entitlements to category
			if (!cat.privacyContexts) {
				cat.appearInList = int.MIN_VALUE;
				cat.moderation = int.MIN_VALUE;
				cat.privacy = int.MIN_VALUE;
				cat.owner = null;
				cat.contributionPolicy = int.MIN_VALUE;
				cat.defaultPermissionLevel = int.MIN_VALUE;
				cat.inheritanceType = int.MIN_VALUE;
				// cat.userJoinPolicy = int.MIN_VALUE;
			}
				
				
			// if category inherits members from parent, don't send inherited values
			else if (cat.inheritanceType == KalturaInheritanceType.INHERIT) {
				cat.defaultPermissionLevel = int.MIN_VALUE;
				cat.owner = null;
				// cat.userJoinPolicy = int.MIN_VALUE;
			}
		}
		
		public static function compareValues(a:CategoryVO, b:CategoryVO, fields:Array = null):int {
			if (a == null && b == null)
				return 0;
			
			if (a == null)
				return 1;
			
			if (b == null)
				return -1;
			
			if (a.category.partnerSortValue < b.category.partnerSortValue)
				return -1;
			
			if (a.category.partnerSortValue > b.category.partnerSortValue)
				return 1;
			
			return 0;
		}
	}
}