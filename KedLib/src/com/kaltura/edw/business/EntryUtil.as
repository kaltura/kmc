package com.kaltura.edw.business {
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTrackerConsts;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.kmvc.model.IDataPackRepository;
	import com.kaltura.kmvc.model.KMvCModel;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.utils.SoManager;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAsset;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaPlayableEntry;

	import mx.collections.ArrayCollection;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	import com.kaltura.vo.KalturaLiveStreamBitrate;

	/**
	 * This class will hold functions related to kaltura entries
	 * @author Michal
	 *
	 */
	public class EntryUtil {

		/**
		 * Update the given entry on the listableVO list, if it contains an entry with the same id
		 *
		 */
		public static function updateSelectedEntryInList(entryToUpdate:KalturaBaseEntry, entries:ArrayCollection):void {
			for each (var entry:KalturaBaseEntry in entries) {
				if (entry.id == entryToUpdate.id) {

					var atts:Array = ObjectUtil.getObjectAllKeys(entryToUpdate);
					var att:String;
					for (var i:int = 0; i < atts.length; i++) {
						att = atts[i];
						if (entry[att] != entryToUpdate[att]) {
							entry[att] = entryToUpdate[att];
						}
					}
					break;
				}
			}
		}


		/**
		 * In order not to override data that was inserted by the user, update only status & replacement fiedls that
		 * might have changed
		 * */
		public static function updateChangebleFieldsOnly(newEntry:KalturaBaseEntry, oldEntry:KalturaBaseEntry):void {
			oldEntry.status = newEntry.status;
			oldEntry.replacedEntryId = newEntry.replacedEntryId;
			oldEntry.replacingEntryId = newEntry.replacingEntryId;
			oldEntry.replacementStatus = newEntry.replacementStatus;
			(oldEntry as KalturaPlayableEntry).duration = (newEntry as KalturaPlayableEntry).duration;
			(oldEntry as KalturaPlayableEntry).msDuration = (newEntry as KalturaPlayableEntry).msDuration;
		}


		/**
		 * open preview and embed window for the given entry according to the data on the given model
		 * */
		public static function openPreview(selectedEntry:KalturaBaseEntry, model:IDataPackRepository, previewOnly:Boolean):void {
			//TODO eliminate, use the function triggered in WindowsManager.as

			var context:ContextDataPack = model.getDataPack(ContextDataPack) as ContextDataPack;
			if (context.openPlayerFunc) {
				var html5Compatible:Boolean = selectedEntry is KalturaMediaEntry && (selectedEntry as KalturaMediaEntry).mediaType == KalturaMediaType.VIDEO;
				var ddp:DistributionDataPack = model.getDataPack(DistributionDataPack) as DistributionDataPack;
				var bitrates:Array;
				if (selectedEntry is KalturaLiveStreamAdminEntry) {
					bitrates = [];
					var o:Object;
					for each (var br:KalturaLiveStreamBitrate in selectedEntry.bitrates) {
						o = new Object();
						o.bitrate = br.bitrate;
						o.width = br.width;
						o.height = br.height;
						bitrates.push(o);
					}
				}
				KedJSGate.doPreviewEmbed(context.openPlayerFunc, selectedEntry.id, selectedEntry.name, selectedEntry.description, previewOnly, false, null, bitrates, allFlavorAssets(ddp.flavorParamsAndAssetsByEntryId),
					html5Compatible);
			}
			GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_OPEN_PREVIEW_AND_EMBED, GoogleAnalyticsConsts.CONTENT);
			KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_OPEN_PREVIEW_AND_EMBED, "content>Open Preview and Embed");

			//First time funnel
			if (!SoManager.getInstance().checkOrFlush(GoogleAnalyticsConsts.CONTENT_FIRST_TIME_PLAYER_EMBED))
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_FIRST_TIME_PLAYER_EMBED, GoogleAnalyticsConsts.CONTENT);
		}


		/**
		 * extract flavor assets from the given list
		 * @param flavorParamsAndAssetsByEntryId
		 * */
		private static function allFlavorAssets(flavorParamsAndAssetsByEntryId:ArrayCollection):Array {
			var fa:KalturaFlavorAsset;
			var result:Array = new Array();
			for each (var kawp:FlavorAssetWithParamsVO in flavorParamsAndAssetsByEntryId) {
				fa = kawp.kalturaFlavorAssetWithParams.flavorAsset;
				if (fa) {
					result.push(fa);
				}
			}
			return result;
		}
	}
}
