package com.kaltura.kmc.modules.studio.vo.ads
{
	import mx.collections.ArrayCollection;

	/**
	 * Holds info about a companion ad 
	 * @author Atar
	 */
	[Bindable]
	public class CompanionAdVo {
		
		/**
		 * ad type (html / flash) 
		 */
		public var type:String;
		
		/**
		 * id of the element where the ad should be presented. 
		 */
		public var elementid:String;
		
		/**
		 * id of the element which places the ad. 
		 */
		public var relativeTo:String;
		
		/**
		 * the relation of the ad to the positioning element (<code>relativeTo</code>) <br>
		 * firstChild\lastChild\before\after
		 */
		public var position:String;
		
		/**
		 * ad width. 
		 */
		public var width:Number = 0;
		
		/**
		 * ad height. 
		 */
		public var height:Number = 0;
		
		
		/**
		 * for flash ads, dataprovider for locations combobox. 
		 */
		public var dp:ArrayCollection;
		
	}
}