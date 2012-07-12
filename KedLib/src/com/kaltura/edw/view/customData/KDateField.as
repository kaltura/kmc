package com.kaltura.edw.view.customData
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.DateField;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	/**
	 * When editable, if typed value isn't translated to real date, reset view (as well as data)
	 * @author atar.shadmi
	 * 
	 */
	public class KDateField extends DateField
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Overridden event handlers: UIComponent
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			
			// if no selectedDate, set text to null	
			if (selectedDate == null) {
				if (labelFunction != null)
					textInput.text = labelFunction(null);
				else
					textInput.text = null;
			}
				
		}
		
		
		
		/**
		 *  @private
		 */
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			super.keyDownHandler(event);
			if (event.keyCode == Keyboard.ENTER && !showingDropdown && editable && !selectedDate) {
				// if no selectedDate, set text to null
				if (labelFunction != null)
					textInput.text = labelFunction(null);
				else
					textInput.text = null;
			}
				
			
		}
		
	}
}