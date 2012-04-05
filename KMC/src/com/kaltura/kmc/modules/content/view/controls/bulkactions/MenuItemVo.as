package com.kaltura.kmc.modules.content.view.controls.bulkactions
{
	/**
	 * the data vo that builds a menu item in a BulkActionsMenu 
	 * @author atar.shadmi
	 * 
	 */
	public class MenuItemVo {
		
		/**
		 * Specifies whether the user can select the menu item (true), or not (false). 
		 * If not specified, Flex treats the item as if the value were true.
		 * @internal
		 * If you use the default data descriptor, data providers must use an 
		 * enabled XML attribute or object field to specify this characteristic.
		 */
		public var enabled:Boolean = true;
		
		
				
		/**
		 * The identifier that associates radio button items in a radio group.
		 * (Required, and meaningful, for radio type only).
		 * @intenral 
		 * If you use the default data descriptor, data providers must use a groupName 
		 * XML attribute or object field to specify this characteristic.
		 */
		public var groupName:String;
		
		
		
			
		/**
		 * Specifies the class identifier of an image asset. 
		 * This item is not used for the check, radio, or separator types. 
		 * @internal
		 * You can use the checkIcon and radioIcon styles to specify the icons 
		 * used for radio and check box items that are selected.
		 * The menu’s iconField or iconFunction property determines the name of the field 
		 * in the data that specifies the icon, or a function for determining the icons.
		 */
		public var icon:Class;
		
		
		
				
		/**
		 * Specifies the text that appears in the control. 
		 * This item is used for all menu item types except separator.
		 * The menu’s labelField or labelFunction property determines the name of the field
		 * in the data that specifies the label, or a function for determining the labels. 
		 * If the data provider is an array of strings, Flex uses the string value as the label.
		 */
		public var label:String;
		
		
		
				
		/**
		 * Specifies whether a check or radio item is selected. 
		 * If not specified, Flex treats the item as if the value were false and the item is not selected.
		 * If you use the default data descriptor, data providers must use a 
		 * toggled XML attribute or object field to specify this characteristic.
		 */
		public var toggled:Boolean;
		
		
		
				
		/**
		 * Specifies the type of menu item. 
		 * Meaningful values are "separator", "check", or "radio". 
		 * Flex treats all other values, or nodes with no type entry, as normal menu entries.
		 * @internal
		 * If you use the default data descriptor, data providers must use a
		 * type XML attribute or object field to specify this characteristic.
		 */
		public var type:String;
		
		
		
		/**
		 * contents of sub-menu for this item.
		 * array elements are of type MenuItemVo. 
		 */
		public var children:Array;
		
		
		
		/**
		 * item data container
		 */
		public var data:*;
		
	}
}