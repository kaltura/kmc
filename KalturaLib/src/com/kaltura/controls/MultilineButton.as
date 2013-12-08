package com.kaltura.controls
{
	import com.kaltura.controls.text.NoTruncationUITextField;
	
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	
	import mx.controls.Button;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUITextField;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class MultilineButton extends Button
	{
		public function MultilineButton()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			if (!textField)
			{
				textField = IUITextField(createInFontContext(NoTruncationUITextField));
				textField.styleName = this;
				addChild(DisplayObject(textField));
			}
			
			super.createChildren();
			
			textField.multiline = true;
			textField.wordWrap = true;
		}
		
		
		override public function measureText(s:String):TextLineMetrics
		{
			textField.text = s;
			var lineMetrics:TextLineMetrics = textField.getLineMetrics(0);
			lineMetrics.width = textField.textWidth + 4;
			lineMetrics.height = textField.textHeight + 4;
			return lineMetrics;
		}
	}
}