package com.kaltura.autocomplete.itemRenderers.selection.base
{
	import com.hillelcoren.components.autoComplete.interfaces.iComboItem;
	
	import mx.core.IContainer;
	
	public interface ISelectionItemRenderer extends IContainer, iComboItem
	{
		function set allowMultipleSelection(value:Boolean):void;
//		function set data(value:Object):void;
		function set selected(value:Boolean):void;
		function set showRemoveIcon(value:Boolean):void;
		function set labelField(value:String):void;
//		function get item():Object;
	}
}