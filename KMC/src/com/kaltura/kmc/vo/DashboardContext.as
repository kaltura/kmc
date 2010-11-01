package com.kaltura.kmc.vo
{
	/**
	 * This is the context that is passed to the dashboard module. 
	 * It holds all values previously passed as flashvars, and possibly 
	 * stuff that were passed on the context object as well. 
	 * @author Atar
	 */	
	public class DashboardContext extends Context {
		
		//TODO get these variables from somewhere
		/**
		 * Google analytics identifier 
		 */		
		public var urchinnumber:String;
		
		/**
		 * readable user name
		 * */
		public var username:String;
		
		/**
		 * user name for google analytics
		 * */
		public var uid:String;
		
		public var firstlogin:String;
		
		public var uploaddoclink:String;
		
		public var embeddoclink:String;
		
		public var customizedoclink:String;
		
		public var gaDebug:String;
		
	}
}