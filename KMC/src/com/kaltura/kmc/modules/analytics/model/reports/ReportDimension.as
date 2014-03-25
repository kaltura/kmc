package com.kaltura.kmc.modules.analytics.model.reports
{
	[Bindable]
	public class ReportDimension
	{
		public var topContent : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		public var contentDropoff : Array = [];
		public var contentInteraction : Array = [ 'count_plays','count_edit','count_viral','count_download','count_report'];
		public var contentContributions : Array = [ 'count_total','count_ugc','count_admin','count_video','count_audio','count_image','count_mix'];
		public var topContrib : Array = [ 'count_total','count_video','count_audio','count_image','count_mix']; 
		public var mapOverlay : Array = [ 'count_plays','count_plays_25','count_plays_50','count_plays_75','count_plays_100','play_through_ratio'];
		public var syndicator : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		
		public var publisherStorageNBandwidth : Array = ['bandwidth_consumption', 'average_storage', 'peak_storage', 'added_storage', 'deleted_storage', 'combined_bandwidth_storage', 'transcoding_consumption'];
		
		public var endUserStorage : Array = ['added_storage_mb', 'deleted_storage_mb', 'total_storage_mb', 'added_entries', 'deleted_entries', 'total_entries', 'added_msecs', 'deleted_msecs', 'total_msecs'];
		
		public var userEngagement : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		
		public var platform : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		public var opsys : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		public var browsers : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads']; 
		public var platformDrilldown : Array = [ 'count_plays','sum_time_viewed','avg_time_viewed','count_loads'];
		
		public var liveContent : Array = ['count_plays']; 
	}
}