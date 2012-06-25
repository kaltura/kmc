package com.kaltura.autocomplete.itemRenderers.selection.base
{
	import com.hillelcoren.components.AutoComplete;
	import com.hillelcoren.components.autoComplete.classes.IconButton;
	import com.hillelcoren.components.autoComplete.classes.ShorterTextInput;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.HBox;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	
	[Event(name="change")]
	[Event(name="removeItem")]
	[Style(name="selectedItemStyleName", type="String", inherit="yes")]
	[Style(name="unregisteredSelectedItemStyleName", type="String", inherit="yes")]
	
	public class SelectionItemBase extends HBox implements ISelectionItemRenderer
	{
		
		protected var _text:String;
		protected var _textChanged:Boolean;
		
		protected var _buttonStyleChanged:Boolean;
		
		protected var _item:Object;
		protected var _isMouseOver:Boolean;
		
		protected var _allowMultipleSelection:Boolean;
		protected var _allowMultipleSelectionChanged:Boolean;
		
		[Bindable]			
		protected var _showRemoveIcon:Boolean = true;
		
		private var _labelField:String;
		
		public static const REMOVE_ITEM:String = "removeItem";
		
		public var button:IconButton;
		public var textInput:ShorterTextInput;
		
		public function SelectionItemBase()
		{
			super();
			setStyle("verticalGap", 0);
			setStyle("horizontalGap", 0);
			tabChildren = false;
			tabEnabled = false;
			verticalScrollPolicy = ScrollPolicy.OFF;
			horizontalScrollPolicy = ScrollPolicy.OFF;
			
			addEventListener(FlexEvent.INITIALIZE, init);
			addEventListener(FlexEvent.CREATION_COMPLETE, init);
		}
		
		private function init(evt:FlexEvent):void
		{
			initButtonsHook();
			
			textInput.width = 5;
			textInput.setStyle("borderStyle", "none");
			textInput.setStyle("borderSkin", null);
			textInput.setStyle("paddingLeft", 0);
			textInput.setStyle("paddingRight", 0);
			textInput.setStyle("focusThickness", 0);
			textInput.width = 5;
			textInput.addEventListener( TextEvent.TEXT_INPUT, handleTextInput );
			BindingUtils.bindProperty(this, "height", textInput, "height");
			
			button.toggle = true;
			button.addEventListener( FocusEvent.FOCUS_OUT, handleButtonFocusOut );
			button.addEventListener( MouseEvent.CLICK, handleClick );
			button.addEventListener( "removeClick", handleRemoveClick );
			BindingUtils.bindProperty(button, "allowMultipleSelection", this, "allowMultipleSelection");
			BindingUtils.bindProperty(button, "showRemoveIcon", this, "showRemoveIcon");
		}
		
		protected function initButtonsHook():void{
			
		}
		
		protected function handleButtonFocusOut( event:FocusEvent ):void
		{
			if (!event.relatedObject)
			{
				button.setFocus();					
			}
			else
			{
				selected = false;
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (_textChanged)
			{
				_textChanged = false;					
				button.label = _text;
			}
			
			if (_allowMultipleSelectionChanged)
			{
				_allowMultipleSelectionChanged = false;
				button.allowMultipleSelection = _allowMultipleSelection;
			}
		}
		
		override public function styleChanged( styleProp:String ):void
		{
			super.styleChanged( styleProp );
			
			if (!styleProp || styleProp == "selectedItemStyleName" || styleProp == "unregisteredSelectedItemStyleName")
			{
				_buttonStyleChanged = true;					
				invalidateDisplayList();
			}
		}
		
		override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
			
			if (_buttonStyleChanged)
			{
				_buttonStyleChanged = false;
				
				var styleName:String = getCurrStyle();
				button.setStyle( "styleName", styleName );
			}
		}
		
		protected function getCurrStyle():String{
			return getStyle( "selectedItemStyleName" )
		}
		
		private function handleClick(evt:MouseEvent):void
		{
			selected = true;
		}
		
		protected function handleTextInput( event:TextEvent ):void
		{
			textInput.text = "";
			textInput.validateNow();
			
			dispatchEvent( event );
		}
		
		public function get allowMultipleSelection():Boolean{
			return _allowMultipleSelection;
		}
		
		public function set allowMultipleSelection(value:Boolean):void
		{
			if (_allowMultipleSelection != value)
			{
				_allowMultipleSelection = value;
				_allowMultipleSelectionChanged = true;
				
				invalidateProperties();
			}
		}
		
		public function set selected(value:Boolean):void
		{
			button.selected = value;
		}
		
		public function setTextFocus():void
		{
			textInput.setFocus();
		}
		
		public function isCursorAtBeginning():Boolean
		{
			return true;
		}
		
		public function isCursorAtEnd():Boolean
		{
			return true;
		}
		
		public function isEditable():Boolean
		{
			return false;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function get item():Object
		{
			return _item;
		}
		
		public function set item(value:Object):void
		{
			_item = value;
			setText(AutoComplete.getLabel(_item, _labelField));
		}
		
		protected function setText( value:String ):void
		{
			if (_text != value)
			{
				_text = value;
				_textChanged = true;
				
				invalidateProperties();
			}
		}
		override public function setFocus():void
		{
			button.setFocus();
		}
		
		public function handleRemoveClick(evt:Event):void
		{
			var event:Event = new Event( REMOVE_ITEM );
			dispatchEvent( event );
		}
		public function set showRemoveIcon( value:Boolean ):void
		{
			_showRemoveIcon = value;
		}
		
		public function get showRemoveIcon():Boolean
		{
			return _showRemoveIcon;
		}
		
		public function set labelField(value:String):void{
			_labelField = value;
		}
	}
}