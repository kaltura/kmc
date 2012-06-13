package com.kaltura.controls.table
{
	public interface ISelectionTable
	{
		/**
		 * name of the attribute on VO objects that the table uses to mark selection
		 * */
		function set selectionAttribute(value:String):void;
		function get selectionAttribute():String;
	}
}