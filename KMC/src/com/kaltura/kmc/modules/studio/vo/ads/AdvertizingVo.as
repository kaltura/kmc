package com.kaltura.kmc.modules.studio.vo.ads {
	import mx.collections.ArrayCollection;

	/**
	 * Holds info about current chosen advertizing configuration. 
	 * @author Atar
	 */
	[Bindable]
	public class AdvertizingVo {

		/**
		 * Corresponds to "requests ads for this player"
		 * */
		public var adsEnabled:Boolean = false;
		
		/**
		 * Info about the chosen ad source, a reference to one of the vos in <code>adSources</code>
		 */
		public var adSource:AdSourceVo;
		
		/**
		 * Possible ad sources data 
		 */
		public var adSources:ArrayCollection/*AdSourceVo*/;
		
		/**
		 * The length of time to wait for an ad to load before skipping it.
		 */
		public var timeout:Number;
		
		/**
		 * Indicates notice message should be presented during ad playback. 
		 */
		public var noticeEnabled:Boolean;
		
		/**
		 * The text to present as notice message.
		 */		
		public var noticeText:String;
		
		/**
		 * Indicates "skip" button should be presented during ad playback. 
		 */
		public var skipEnabled:Boolean;
		
		/**
		 * skip button label 
		 */
		public var skipText:String;
		
		/**
		 * companion ads data 
		 * (CompanionAdVo)
		 */
		public var companions:Array/*CompanionAdVo*/;
		
		/**
		 * kdp elements over which ads may be placed
		 * (Object {elementid,relativeTo,position})
		 */
		public var flashCompanionLocations:ArrayCollection/*Object*/;
		
		
		/**
		 * indicates a bumpervideo should be presented. 
		 */
		public var bumperEnabled:Boolean;
		
		/**
		 * the Kaltura entry to play as bumper 
		 */
		public var bumperEntry:String;
		
		/**
		 * clicking the bumper video opens a new window with the given url. 
		 */		
		public var bumperUrl:String;
		
		/**
		 * preroll configuration 
		 */
		public var preroll:InPlayerAdVo;
		
		/**
		 * postroll configuration 
		 */
		public var postroll:InPlayerAdVo;

		/**
		 * overlay configuration 
		 */
		public var overlay:InPlayerAdVo;
		
		/**
		 * possible values for linear ads comboboxes 
		 */		
		public var linearAdsValues:XML;
		
	}
}