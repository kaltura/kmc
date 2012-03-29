package com.kaltura.kmc.modules.content.model {
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Data that is used by moderation tab
	 * @author Atar
	 */
	public class ModerationModel {

		public function ModerationModel() {
			moderationsArray = new ArrayCollection();
		}

		/**
		 * list of moderation data (comments) per entry.
		 * <code>KalturaModerationFlag</code> objects
		 * */
		public var moderationsArray:ArrayCollection;
		
		
		/**
		 * in moderation screen, should confirmation popup be displayed
		 * when approving / rejecting entry moderation 
		 */
		public var confirmModeration:Boolean = true; 
	}
}