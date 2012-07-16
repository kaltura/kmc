package com.kaltura.kmc.modules.analytics.model.reports
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class TableHeaders
	{
		//---------------------------------------------------------
	    //reports table headers
	    public var topContent : Array = [ 'count_video', 'count_plays','sum_time_viewed','avg_time_viewed', 'count_loads', 'load_play_ratio']; //,'distinct_plays'    
		public var topContentPerUser : Array = [ 'user_id', 'count_plays','sum_time_viewed','avg_time_viewed', 'avg_view_drop_off', 'count_loads', 'load_play_ratio']; 
		public var contentDropoff : Array = [ 'count_video','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
		public var contentDropoffPerUser : Array = [ 'user_id','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
	    public var contentInteraction : Array = [ 'count_video','count_plays', 'count_edit','count_viral','count_download','count_report']; 
		public var contentInteractionPerUser : Array = [ 'user_id','count_plays', 'count_edit','count_viral','count_download','count_report']; 
	    public var contentContributions : Array = [ 'entry_media_source_name','count_total','count_video','count_audio','count_image','count_mix'];  //'editor_usage'
		public var topContrib : Array =[ 'screen_name','count_total', 'count_video','count_audio','count_image','count_mix']; //'editor_usage','edit_sessions'
	    public var mapOverlay : Array = [ 'country_id','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
	    public var syndicator : Array =[ 'domain_name','count_plays','sum_time_viewed','avg_time_viewed','count_loads','load_play_ratio']; //'distinct_plays',

		public var publisherBandwidthNStorage : Array = ['date_id', 'bandwidth_consumption', 'average_storage', 'peak_storage', 'added_storage', 'combined_bandwidth_storage'];
		public var endUserStorage : Array = ['NAME', 'added_entries', 'total_entries', 'added_storage_mb', 'total_storage_mb', 'added_msecs', 'total_msecs'];
		public var specificEndUserStorage : Array = ['date_id', 'user_added_entries', 'user_total_entries', 'user_added_storage_mb', 'user_total_storage_mb', 'user_added_msecs', 'user_total_msecs'];

		public var userEngagement : Array = ['name','unique_videos','count_plays','sum_time_viewed','avg_time_viewed','avg_view_drop_off','count_loads','load_play_ratio'];
		public var userEngagementDrilldown : Array = ['name','count_plays','sum_time_viewed','avg_time_viewed','avg_view_drop_off','count_loads','load_play_ratio'];

	}
}