package com.kaltura.kmc.modules.studio.vo
{
	
	/**
	 * media KDP should display in appstudio  
	 * @author Atar
	 */	
	public dynamic class PlayerContentVo {
		
		/**
		 * entry id for single player 
		 */		
		public var entryId:String;
		
		/**
		 * name of playlist for single playlist player 
		 */		
		public var kpl0Name:String;
		
		/**
		 * url of playlist for single playlist player 
		 */
		public var kpl0Url:String;
		
		/**
		 * name of 2nd playlist for multi playlist player 
		 */
		public var kpl1Name:String;
		
		/**
		 * url of 2nd playlist for multi playlist player 
		 */
		public var kpl1Url:String;
		
	}
}