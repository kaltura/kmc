package com.kaltura.kmc.modules.content.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	import com.kaltura.vo.KalturaGoogleVideoSyndicationFeed;
	import com.kaltura.vo.KalturaITunesSyndicationFeed;
	import com.kaltura.vo.KalturaTubeMogulSyndicationFeed;
	import com.kaltura.vo.KalturaYahooSyndicationFeed;

	import flash.events.Event;

	[Bindable]
	/**
	 * External syndication data
	 */
	public class ExternalSyndicationVO implements IValueObject {
		/**
		 * defines the value of the type property for the externalSyndicationSelectedChanged event.
		 */
		public static const SELECTED_CHANGED_EVENT:String = "externalSyndicationSelectedChanged";

		/**
		 * feed id 
		 */		
		public var id:String;

		/**
		 * feed object 
		 */		
		public var kSyndicationFeed:KalturaBaseSyndicationFeed;

		/**
		 * used to mark selections in ExternalSyndicationTable 
		 */		
		public var tableSelected:Boolean;


		/**
		 * Clone this vo
		 * @return a clone.
		 */
		public function clone():ExternalSyndicationVO {
			var clonedVo:ExternalSyndicationVO = new ExternalSyndicationVO();

			clonedVo.tableSelected = this.tableSelected;
			clonedVo.kSyndicationFeed = cloneKFeeder(this.kSyndicationFeed);

			return clonedVo;
		}


		/**
		 * clone a google feed
		 * @param feed	the feed to be cloned
		 * @return a clone
		 */
		private function cloneGoogleFeed(feed:KalturaGoogleVideoSyndicationFeed):KalturaGoogleVideoSyndicationFeed {
			var gglFeed:KalturaGoogleVideoSyndicationFeed = new KalturaGoogleVideoSyndicationFeed();
			gglFeed.allowEmbed = feed.allowEmbed;
			gglFeed.createdAt = feed.createdAt;
			gglFeed.id = feed.id;
			gglFeed.landingPage = feed.landingPage;
			gglFeed.name = feed.name;
			gglFeed.partnerId = feed.partnerId;
			gglFeed.playerSkin = feed.playerSkin;
			gglFeed.playlistId = feed.playlistId;
			gglFeed.status = feed.status;
			gglFeed.type = feed.type;
			return gglFeed;
		}


		/**
		 * clone a ITunes feed
		 * @param feed	the feed to be cloned
		 * @return a clone
		 */
		private function cloneITunesFeed(feed:KalturaITunesSyndicationFeed):KalturaITunesSyndicationFeed {
			var itFeed:KalturaITunesSyndicationFeed = new KalturaITunesSyndicationFeed();
			itFeed.allowEmbed = feed.allowEmbed;
			itFeed.author = feed.author;
			itFeed.createdAt = feed.createdAt;
			itFeed.description = feed.description;
			itFeed.id = feed.id;
			itFeed.landingPage = feed.landingPage;
			itFeed.language = feed.language;
			itFeed.name = feed.name;
			itFeed.partnerId = feed.partnerId;
			itFeed.playerSkin = feed.playerSkin;
			itFeed.playlistId = feed.playlistId;
			itFeed.podcastImage = feed.podcastImage;
			itFeed.status = feed.status;
			itFeed.subTitle = feed.subTitle;
			itFeed.summary = feed.summary;
			itFeed.type = feed.type;
			return itFeed;
		}

		/**
		 * clone a Yahoo feed
		 * @param feed	the feed to be cloned
		 * @return a clone
		 */
		private function cloneYahooFeed(feed:KalturaYahooSyndicationFeed):KalturaYahooSyndicationFeed {
			var yFeed:KalturaYahooSyndicationFeed = new KalturaYahooSyndicationFeed();
			yFeed.allowEmbed = feed.allowEmbed;
			yFeed.createdAt = feed.createdAt;
			yFeed.id = feed.id;
			yFeed.landingPage = feed.landingPage;
			yFeed.name = feed.name;
			yFeed.partnerId = feed.partnerId;
			yFeed.playerSkin = feed.playerSkin;
			yFeed.playlistId = feed.playlistId;
			yFeed.status = feed.status;
			yFeed.type = feed.type;
			return yFeed;
		}

		/**
		 * clone a Yahoo feed
		 * @param feed	the feed to be cloned
		 * @return a clone
		 */
		private function cloneTubeMogulFeed(feed:KalturaTubeMogulSyndicationFeed):KalturaTubeMogulSyndicationFeed {
			var tmFeed:KalturaTubeMogulSyndicationFeed = new KalturaTubeMogulSyndicationFeed();
			tmFeed.allowEmbed = feed.allowEmbed;
			tmFeed.createdAt = feed.createdAt;
			tmFeed.id = feed.id;
			tmFeed.landingPage = feed.landingPage;
			tmFeed.name = feed.name;
			tmFeed.partnerId = feed.partnerId;
			tmFeed.playerSkin = feed.playerSkin;
			tmFeed.playlistId = feed.playlistId;
			tmFeed.status = feed.status;
			tmFeed.type = feed.type;
			return tmFeed;
		}


		private function cloneKFeeder(synFeeder:KalturaBaseSyndicationFeed):KalturaBaseSyndicationFeed {
			var clonedSynFeeder:KalturaBaseSyndicationFeed;

			if (synFeeder is KalturaGoogleVideoSyndicationFeed) {
				clonedSynFeeder = cloneGoogleFeed(synFeeder as KalturaGoogleVideoSyndicationFeed);
			}
			else if (synFeeder is KalturaITunesSyndicationFeed) {
				clonedSynFeeder = cloneITunesFeed(synFeeder as KalturaITunesSyndicationFeed);

			}
			else if (synFeeder is KalturaYahooSyndicationFeed) {
				clonedSynFeeder = cloneYahooFeed(synFeeder as KalturaYahooSyndicationFeed);
			}
			else if (synFeeder is KalturaTubeMogulSyndicationFeed) {
				clonedSynFeeder = cloneTubeMogulFeed(synFeeder as KalturaTubeMogulSyndicationFeed);
			}

			return clonedSynFeeder;
		}


	}
}