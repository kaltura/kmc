package com.kaltura.controls
{
	import com.kaltura.controls.text.NoTruncationUITextField;
	
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	
	import mx.controls.RadioButton;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;

	use namespace mx_internal;
	
	/**
	 * A radio button whose label is multiline
	 * @see http://blogs.adobe.com/aharui/2007/04/multiline_buttons.html
	 */
	public class MultilineRadioButton extends RadioButton
	{
		
		public function MultilineRadioButton()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			if (!textField)
			{
				textField = new NoTruncationUITextField();
				textField.styleName = this;
				addChild(DisplayObject(textField));
			}
			
			super.createChildren();
			
			textField.multiline = true;
			textField.wordWrap = true;
		}
		
		override protected function measure():void
		{
			if (!isNaN(explicitWidth))
			{
				var tempIcon:IFlexDisplayObject = getCurrentIcon();
				var w:Number = explicitWidth;
				if (tempIcon)
					w -= tempIcon.width + getStyle("horizontalGap") + getStyle("paddingLeft") + getStyle("paddingRight");
				textField.width = w;
			}
			super.measure();
			
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