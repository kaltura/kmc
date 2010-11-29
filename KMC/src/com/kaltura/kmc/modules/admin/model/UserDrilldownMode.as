package com.kaltura.kmc.modules.admin.model
{
	/**
	 * the <code>UserDrilldownMode</code> class lists the optional states for 
	 * the user drilldown mode.
	 * @author Atar
	 */	
	public class UserDrilldownMode {
		
		/**
		 * edit mode - some fields are ediatble, others are not.
		 * the selected user entity is edited on save.
		 * */
		public static const EDIT:String = "editMode";
		
		/**
		 * add mode - all fields are editable.
		 * a new user entity is created on the server on save.
		 * */
		public static const ADD:String = "addMode";
		
		/**
		 * name of the none mode.
		 * the window is closed.
		 * */
		public static const NONE:String = "noneMode";
	}
}