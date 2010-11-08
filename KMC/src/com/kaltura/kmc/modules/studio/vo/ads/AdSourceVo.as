package com.kaltura.kmc.modules.studio.vo.ads {

	/**
	 * holds info about the chosen ad source, if any.
	 * @author Atar
	 */
	[Bindable]
	public class AdSourceVo {
		
		/**
		 * ad source id <br>
		 */
		public var id:String;

		/**
		 * text to show as combobox label 
		 */
		public var label:String;
		
		/**
		 * for custom swf is where to find the file, for other options it <br>
		 * is the ad tag (the url from which to ask for ads)
		 */
		public var url:String;

		/**
		 * extra data, key:value pairs separated by semicolon.
		 */
		public var extra:String;

	}
}