package com.kaltura.controls {
	import flash.events.FocusEvent;
	
	import mx.controls.TextArea;
	import mx.events.FlexEvent;
	
	public class DefaultLabelTextArea extends TextArea {
		
		[Bindable]
		/**
		 * text to show as default 
		 */		
		public var defaultLabel:String;
		
		[Bindable]
		/**
		 * the style to use for the default text 
		 */		
		public var defaultLabelStyleName:Object;
		
		/**
		 * the style originaly assigned to the TextArea 
		 */		
		private var _originalStyleName:Object;


		public function DefaultLabelTextArea() {
			super();

			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		}


		private function onCreationComplete(event:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			// saves the original style first
			_originalStyleName = styleName;
			if (!super.text) {
				showDefaultText();
			}
		}


		private function onFocusIn(event:FocusEvent):void {
			if (super.text == defaultLabel) {
				super.text = "";
				styleName = _originalStyleName;
			}
		}
		
		private function onFocusOut(event:FocusEvent):void {
			if (super.text == '') {
				showDefaultText();
			}
		}
		
		override public function get text():String {
			if (super.text == defaultLabel) {
				return '';
			}
			else return super.text;
		}
		
		override public function set text(value:String):void {
			if (value) {
				super.text = value;
				styleName = _originalStyleName;
			}
			else {
				showDefaultText();
			}
		}
		
		private function showDefaultText():void {
			super.text = defaultLabel;
			styleName = defaultLabelStyleName;
		}
	}
}