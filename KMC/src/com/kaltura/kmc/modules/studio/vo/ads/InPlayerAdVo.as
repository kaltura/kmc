package com.kaltura.kmc.modules.studio.vo.ads
{
	[Bindable]
	/**
	 * InPlayerAdVo holds data relevant to in-player companion ads.
	 * @author Atar
	 */	
	public class InPlayerAdVo {
		
		/**
		 * present ads 
		 */
		public var enabled:Boolean;
		
		/**
		 * number of ads to show
		 */
		public var nAds:int;
		
		/**
		 * frequency of ads. <br>
		 * for linear ads counted in media entries, for nonlinear ads counted in seconds. 
		 */
		public var frequency:int;
		
		/**
		 * show first ad before this entry 
		 */
		public var start:int;
		
		/**
		 * the url to get the VAST from
		 */
		public var url:String;
	}
}