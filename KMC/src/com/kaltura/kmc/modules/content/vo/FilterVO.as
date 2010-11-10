package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.kmc.modules.content.model.types.MediaIntagerTypes;
	import com.kaltura.kmc.modules.content.model.types.ModerationTypes;
	import com.kaltura.kmc.modules.content.model.types.OrderByServerTypes;
	
	[Bindable]
	public class FilterVO
	{
		public var page : uint = 1;
		public var page_size : uint = 10;	
		//public var filter__like_tags : String; 
		//public var filter__like_name : String;
		public var filter__mlikeor_tags0name : String; // filter__mlikeor_tags0name == filter__mlikeor_tags-name
		public var filter__mlikeor_name : String;
		public var filter__mlikeor_tags : String;
		public var filter__mlikeor_search_text : String;
		public var filter__mlikeor_admin_tags : String;
		public var filter__in_status : String = "2,3";
		public var filter__in_media_type : String = MediaIntagerTypes.ROUGHCUT +','
													+ MediaIntagerTypes.VIDEO + ',' 
													+ MediaIntagerTypes.IMAGE + ',' 
													+  MediaIntagerTypes.AUDIO;
		public var filter__gte_created_at : uint;
		public var filter__lte_created_at : uint;
		
		public var filter__in_moderation_status : String = ModerationTypes.APPROVED + ',' 
														 + ModerationTypes.AUTO_APPROVED + ',' 
														 + ModerationTypes.PENDING + ',' 
														 + ModerationTypes.REVIEW + ',' 
														 + ModerationTypes.REJECTED;
														 
		public var filter__order_by : String = OrderByServerTypes.CREATED_AT_DESC;
		
		public var allAdminTags : Array = new Array();
		//TODO: Remove this hard coded fields and use them when i create a detailed_fields setter
		public var detailed_fields : String = "moderationStatus,moderationCount,contributorScreenName"; 
	}
}