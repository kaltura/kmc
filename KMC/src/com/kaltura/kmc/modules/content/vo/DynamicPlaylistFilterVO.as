package com.kaltura.kmc.modules.content.vo
{
	[Bindable]
	public class DynamicPlaylistFilterVO
	{
		public var limit : Number = 30; //NO MORE THEN 100
		public var order_by : String = "-views"; // "-views" | "-created_at" | "-rank" 
		public var eq_partner_id : String = null;
		public var mlikeor_admin_tags : String = "";
		public var mlikeor_tags : String = "";
		public var in_media_type : String = "1,2,5,6"; //1,2,5,6
		public var gte_created_at : uint;
		public var lte_created_at : uint;	
	}
}