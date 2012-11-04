package com.kaltura.kmc.modules.analytics.model.reports {

	[Bindable]
	/**
	 * list of column headers by which the report table cannot be ordered. <br>
	 * values should match those returned from server for the report
	 * 
	 * @see com.kaltura.kmc.modules.analytics.model.reports.TableHeaders
	 * 
	 * @author atar.shadmi
	 *
	 */
	public class UnsortableColumnHeaders {
//		public const topContent:Array;
		public var topContentPerUser:Array = ['user_id', 'name'];
//		public const contentDropoff:Array;
		public var contentDropoffPerUser:Array = ['user_id', 'name'];
//		public const contentInteraction:Array;
		public var contentInteractionPerUser:Array = ['user_id', 'name'];
//		public const contentContributions:Array;
		public var topContrib:Array = ['name'];
//		public const mapOverlay:Array;
//		public const syndicator:Array;

//		public const publisherBandwidthNStorage:Array;
		public var endUserStorage:Array = ['NAME', 'name'];
//		public const specificEndUserStorage:Array;

		public var userEngagement:Array = ['user_id', 'name'];
		public var userEngagementDrilldown:Array = ['count_video', 'entry_name'];

	}
}
