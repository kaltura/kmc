package com.kaltura.kmc.modules.analytics.model.reports
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class TableHeaders
	{
		//---------------------------------------------------------
	    //reports table headers
	    public var topContent : Array = [ 'count_video', 'count_plays','sum_time_viewed','avg_time_viewed', 'count_loads', 'load_play_ratio']; //,'distinct_plays'    
		public var topContentPerUser : Array = [ 'name','count_video', 'count_plays','sum_time_viewed','avg_time_viewed', 'count_loads', 'load_play_ratio']; 
		public var contentDropoff : Array = [ 'count_video','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
		public var contentDropoffPerUser : Array = [ 'name','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
	    public var contentInteraction : Array = [ 'count_video','count_plays', 'count_edit','count_viral','count_download','count_report']; 
		public var contentInteractionPerUser : Array = [ 'name','count_video','count_plays', 'count_edit','count_viral','count_download','count_report']; 
	    public var contentContributions : Array = [ 'entry_media_source_name','count_total','count_video','count_audio','count_image','count_mix'];  //'editor_usage'
		public var topContrib : Array =[ 'screen_name','count_total', 'count_video','count_audio','count_image','count_mix']; //'editor_usage','edit_sessions'
	    public var mapOverlay : Array = [ 'country_id','count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
	    public var syndicator : Array =[ 'domain_name','count_plays','sum_time_viewed','avg_time_viewed','count_loads','load_play_ratio']; //'distinct_plays',

		public var usage : Array = ['date', 'bandwidth', 'storage', 'total_usage'];

		public var userEngagement : Array = ['name','unique_videos','count_plays','sum_time_viewed','avg_time_viewed','avg_view_drop_off','count_loads','load_play_ratio'];

	}
}