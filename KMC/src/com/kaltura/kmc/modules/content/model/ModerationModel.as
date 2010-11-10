package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.kmc.modules.content.model.search.SearchData;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Data that is used by moderation tab 
	 * @author Atar
	 */	
	public class ModerationModel {
		
		public function ModerationModel() {
			entriesSearchData = new SearchData();
			moderationsArray = new ArrayCollection();
		}
		
		/**
		 * results of entries searching
		 * used to get a pager for Content.contentView.pager
		 * */
		public var entriesSearchData:SearchData;
		
		public var moderationsArray:ArrayCollection;
	}
}