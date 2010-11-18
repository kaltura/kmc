/**
 * Autocomplete for names text input.
 * Exteneded from Adobe's AutoComplete text input from the FlexLib.
 * @Author Zohar Babin. &
 * @Author Avi Bossira.
 * 
 * This component take object with the label property:
 * 			var nameObj:Object = new Object();
 nameObj.label = some_name_here;
 * 
 */
package com.kaltura.kmc.modules.content.utils
{
		//	import com.sagada.business.SagadaServices;
		
		import flash.events.ContextMenuEvent;
		import flash.events.Event;
		import flash.events.FocusEvent;
		import flash.events.KeyboardEvent;
		import flash.net.SharedObject;
		import flash.ui.ContextMenu;
		import flash.ui.ContextMenuItem;
		import flash.ui.Keyboard;
		
		import mx.collections.CursorBookmark;
		import mx.collections.ListCollectionView;
		import mx.controls.ComboBox;
		import mx.core.EventPriority;
		import mx.core.UIComponent;
		import mx.core.UITextField;
		import mx.core.mx_internal;
		import mx.events.FlexEvent;
		import mx.utils.StringUtil;
		
		use namespace mx_internal;
		//--------------------------------------
		//  Events
		//--------------------------------------
		
		/**
		 *  Dispatched when the <code>filterFunction</code> property changes.
		 *
		 *  You can listen for this event and update the component
		 *  when the <code>filterFunction</code> property changes.</p>
		 *
		 *  @eventType flash.events.Event
		 */
		[Event(name="filterFunctionChange", type="flash.events.Event")]
		
		/**
		 *  Dispatched when the <code>typedText</code> property changes.
		 *
		 *  You can listen for this event and update the component
		 *  when the <code>typedText</code> property changes.</p>
		 *
		 *  @eventType flash.events.Event
		 */
		[Event(name="typedTextChange", type="flash.events.Event")]
		
		//--------------------------------------
		//  Excluded APIs
		//--------------------------------------
		
		[Exclude(name="editable", kind="property")]
		
		/**
		 *  The AutoComplete control is an enhanced
		 *  TextInput control which pops up a list of suggestions
		 *  based on characters entered by the user. These suggestions
		 *  are to be provided by setting the <code>dataProvider
		 *  </code> property of the control.
		 *  @mxml
		 *
		 *  <p>The <code>&lt;fc:AutoComplete&gt;</code> tag inherits all the tag attributes
		 *  of its superclass, and adds the following tag attributes:</p>
		 *
		 *  <pre>
		 *  &lt;fc:AutoComplete
		 *    <b>Properties</b>
		 *    keepLocalHistory="false"
		 *    lookAhead="false"
		 *    typedText=""
		 *    filterFunction="<i>Internal filter function</i>"
		 *
		 *    <b>Events</b>
		 *    filterFunctionChange="<i>No default</i>"
		 *    typedTextChange="<i>No default</i>"
		 *  /&gt;
		 *  </pre>
		 *
		 *  @includeExample ../../../../../../docs/com/adobe/flex/extras/controls/example/AutoCompleteCountriesData/AutoCompleteCountriesData.mxml
		 *
		 *  @see mx.controls.ComboBox
		 *
		 */
		public class AutoComplete extends ComboBox
		{
			
			public function setTextInputStyle(styleName:String, value:Object):void
			{
				textInput.setStyle(styleName, value);
			}
			/** Flag to indicate if the text is empty or not */
			private var _textEmpty:Boolean;
			
			/**
			 * Flag to prevent us from re-inserting the prompt if the text is cleared
			 * while the component still has focus.
			 */
			private var _currentlyFocused:Boolean=false;
			
			// ==============================================================
			//	prompt
			// ==============================================================
			
			/** Storage for the prompt property */
			private var _prompt:String="";
			
			/**
			 * The string to use as the prompt value
			 */
			override public function get prompt():String
			{
				return _prompt;
			}
			
			[Bindable]
			override public function set prompt(value:String):void
			{
				_prompt=value;
				
				invalidateProperties();
			}
			// ==============================================================
			//	promptFormat
			// ==============================================================
			
			/** Storage for the promptFormat property */
			private var _promptFormat:String='<font color="#999999"><i>[prompt]</i></font>';
			
			/**
			 * A format string to specify how the prompt is displayed.  This is typically
			 * an HTML string that can set the font color and style.  Use <code>[prompt]</code>
			 * within the string as a replacement token that will be replaced with the actual
			 * prompt text.
			 *
			 * The default value is "&lt;font color="#999999"&gt;&lt;i&gt;[prompt]&lt;/i&gt;&lt;/font&gt;"
			 */
			public function get promptFormat():String
			{
				return _promptFormat;
			}
			
			public function set promptFormat(value:String):void
			{
				_promptFormat=value;
				// Check to see if the replacement code is found in the new format string
				if (_promptFormat.indexOf("[prompt]") < 0)
				{
					trace( "PromptingTextInput warning: prompt format does not contain [prompt] replacement code." );
				}
				
				invalidateDisplayList();
			}
			
			// ==============================================================
			//	text
			// ==============================================================
			
			
			/**
			 * Override the behavior of text so that it doesn't take into account
			 * the prompt.  If the prompt is displaying, the text is just an empty
			 * string.
			 */
			[Bindable("textChanged")]
			[CollapseWhiteSpace]
			[NonCommittingChangeEvent("change")]
			
			override public function set text(value:String):void
			{
				// changed the test to also test for null values, not just 0 length
				// if we were passed undefined or null then the zero length test would
				// still return false. - Doug McCune
				_textEmpty=(!value) || value.length == 0;
				_typedText=value;
				textInput.text=value;
				invalidateProperties();
			}
			
			override public function get text():String
			{
				// If the text has changed
				if (_textEmpty)
				{
					// Skip the prompt text value
					return "";
				}
				else
				{
					return textInput.text;
				}
			}
			
			// ==============================================================
			//	event handlers
			// ==============================================================
			override public function close(trigger:Event=null):void
			{
				super.close(trigger);
				if (textInput.text)
				{
					if (_selectionChanged)
						appendFunction();
					textInput.setSelection(textInput.text.length, textInput.text.length);
				}
			}
			
			protected function appendFunction():void
			{
				if (_selectedItem)
				{
					var valids:Array=getValidTextsArray(textInput.text, textInput.selectionBeginIndex);
					var firstPart:String=valids[0] != '' ? String(valids[0]).charAt(valids[0].length - 1) != ',' ? valids[0] + ',' : valids[0] : '';
					var lastPart:String=valids[1] != '' ? String(valids[1]).charAt(0) != ',' ? ',' + valids[1] : valids[1] : '';
					var textAddedSelection:String=(firstPart == '' && lastPart == '') ? _selectedItem[labelField] : firstPart + _selectedItem[labelField] + lastPart;
					_typedText=textAddedSelection == '' ? '' : textAddedSelection.charAt(textAddedSelection.length - 1) == ',' ? textAddedSelection : textAddedSelection + ',';
					textInput.text=_typedText;
					_selectionChanged=false;
					_selectedItem=null;
					_textEmpty=false;
					textInput.invalidateProperties();
				}
			}
			
			protected function getValidTextsArray(testText:String, cursorPos:int):Array
			{
				var beforeCursorPos:String=testText.substring(0, cursorPos);
				var afterCursorPos:String=testText.substring(cursorPos);
				var firstCommaPos:int;
				var secondCommaPos:int;
				var valuesArray:Array=['', ''];
				var testComma:Boolean=testText.indexOf(',') != -1;
				if (testComma)
				{
					firstCommaPos=beforeCursorPos.lastIndexOf(',');
					valuesArray[0]=testText.substring(0, firstCommaPos);
					var secondCommaIndex:int=afterCursorPos.indexOf(',');
					secondCommaPos=secondCommaIndex == -1 ? cursorPos : secondCommaIndex + cursorPos;
					valuesArray[1]=secondCommaPos == -1 ? '' : testText.substring(secondCommaPos);
					/* secondCommaPos = testText.substr(cursorPos).indexOf(",") + firstCommaPos;
					secondCommaPos = secondCommaPos == -1 ? firstCommaPos + 1 : secondCommaPos; */
					
					//valuesArray[1] = secondCommaPos >= cursorPos - 1 ? '' : testText.substring(secondCommaPos);
				}
				return valuesArray;
			}
			
			protected var _selectedIndex:int=-1;
			protected var _selectedItem:Object=null;
			protected var _selectedIndexChanged:Boolean=false;
			protected var _selectionChanged:Boolean=false;
			
			override public function set selectedIndex(value:int):void
			{
				_selectedIndex=value;
				if (value == -1)
				{
					_selectedItem=null;
				}
				
				//2 code paths: one for before collection, one after
				if (!collection || collection.length == 0)
				{
					_selectedIndexChanged=true;
				}
				else
				{
					if (value != -1)
					{
						value=Math.min(value, collection.length - 1);
						var bookmark:CursorBookmark=iterator.bookmark;
						var len:int=value;
						iterator.seek(CursorBookmark.FIRST, len);
						var data:Object=iterator.current;
						var uid:String=itemToUID(data);
						iterator.seek(bookmark, 0);
						_selectedIndex=value;
						_selectedItem=data;
					}
				}
				
				_selectionChanged=true;
			}
			
			private function handleChange(event:Event):void
			{
				//Stores the text typed by the user in a variable
				typedText=textInput.text;
				//check if the text us empty
				_textEmpty=(!textInput.text) || textInput.text.length == 0;
			}
			
			override protected function textInput_changeHandler(event:Event):void
			{
				super.textInput_changeHandler(event);
			}
			
			/**
			 * When the component recevies focus, check to see if the prompt
			 * needs to be cleared or not.
			 */
			override protected function focusInHandler(event:FocusEvent):void
			{
				super.focusInHandler(event);
				
				_currentlyFocused=true;
				
				// If the text is empty, clear the prompt
				if (_textEmpty)
				{
					textInput.htmlText="";
					// KLUDGE: Have to validate now to avoid a bug where the format
					// gets "stuck" even though the text gets cleared.
					textInput.validateNow();
				}
				else
				{
					var trimmed:String=mx.utils.StringUtil.trim(_typedText);
					var lastChar:String=trimmed.charAt(trimmed.length - 1);
					if (lastChar != "," && _typedText != "")
					{
						_typedText=_typedText + ", ";
						textInput.text=_typedText;
						textInput.setSelection(textInput.text.length, textInput.text.length);
					}
				}
			}
			
			/**
			 * @private
			 *
			 * When the component loses focus, check to see if the prompt needs
			 * to be displayed or not.
			 */
			override protected function focusOutHandler(event:FocusEvent):void
			{
				super.focusOutHandler(event);
				
				resetToValidValue();
				
				if (keepLocalHistory && dataProvider.length == 0)
					addToLocalHistory();
				
				_currentlyFocused=false;
				
				// If the text is empty, put the prompt back
				invalidateDisplayList();
			}
			
			/**
			 *formats the value to be valid, inorder to clear display when not editing, and return a valid value when desired.
			 * @return 	a valid value.
			 */
			public function getValidValue():String
			{
				var trimmed:String=mx.utils.StringUtil.trim(_typedText);
				var lastChar:String=trimmed.charAt(trimmed.length - 1);
				var validValue:String=lastChar == "," ? trimmed.substring(0, trimmed.length - 1) : trimmed;
				return validValue;
			}
			
			public function resetToValidValue():void
			{
				_typedText=getValidValue();
				textInput.text=_typedText;
			}
			
			//--------------------------------------------------------------------------
			//
			//  Constructor
			//
			//--------------------------------------------------------------------------
			
			/**
			 *  Constructor.
			 */
			public function AutoComplete()
			{
				super();
				
				//Make ComboBox look like a normal text field
				editable=true;
				if (keepLocalHistory)
					addEventListener("focusOut", focusOutHandler);
				
				setStyle("arrowButtonWidth", 0);
				setStyle("fontWeight", "normal");
				setStyle("cornerRadius", 0);
				setStyle("paddingLeft", 0);
				setStyle("paddingRight", 0);
				rowCount=7;
				
				addEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompleteHandle);
			}
			
			public function onCreationCompleteHandle(event:FlexEvent):void
			{
				if (textInput)
				{
					_textEmpty=(!value) || value.length == 0;
					textInput.addEventListener(Event.CHANGE, handleChange, false, EventPriority.BINDING);
					/* textInput.addEventListener( FocusEvent.FOCUS_IN, handleFocusIn );
					textInput.addEventListener( FocusEvent.FOCUS_OUT, handleFocusOut ); */
				}
				invalidateDisplayList();
			}
			
			private function createContextMenu():ContextMenu
			{
				var editContextMenu:ContextMenu=new ContextMenu();
				var deletItem:ContextMenuItem=new ContextMenuItem("Delet contact!")
				deletItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, deleteContactHandler);
				editContextMenu.customItems.push(deletItem);
				
				return editContextMenu
			}
			
			protected function deleteContactHandler(event:ContextMenuEvent):void
			{
				var target:UITextField=event.mouseTarget as UITextField;
				var firstCloserPos:int=target.text.indexOf("<");
				var secondCloserPos:int=target.text.indexOf(">");
				//		var deleteEmail:String=firstCloserPos > -1 ? target.text.substring(firstCloserPos + 1, secondCloserPos) : target.text;
				//		SagadaServices.getInstance().writeLogMessage("Delete me: " + deleteEmail);
			}
			//--------------------------------------------------------------------------
			//
			//  Variables
			//
			//--------------------------------------------------------------------------
			
			/**
			 *  @private
			 */
			private var cursorPosition:Number=0;
			
			/**
			 *  @private
			 */
			private var prevIndex:Number=-1;
			
			/**
			 *  @private
			 */
			private var removeHighlight:Boolean=false;
			
			/**
			 *  @private
			 */
			private var showDropdown:Boolean=false;
			
			/**
			 *  @private
			 */
			private var showingDropdown:Boolean=false;
			
			/**
			 *  @private
			 */
			private var tempCollection:Object;
			
			/**
			 *  @private
			 */
			private var usingLocalHistory:Boolean=false;
			
			/**
			 *  @private
			 */
			private var dropdownClosed:Boolean=true;
			
			//--------------------------------------------------------------------------
			//
			//  Overridden Properties
			//
			//--------------------------------------------------------------------------
			
			//----------------------------------
			//  editable
			//----------------------------------
			/**
			 *  @private
			 */
			override public function set editable(value:Boolean):void
			{
				//This is done to prevent user from resetting the value to false
				super.editable=true;
			}
			
			/**
			 *  @private
			 */
			override public function set dataProvider(value:Object):void
			{
				var oldValues:String=_typedText;
				super.dataProvider=value;
				if (!usingLocalHistory)
					tempCollection=value;
				_typedText=oldValues;
				if (textInput)
					textInput.text=_typedText;
			}
			
			//----------------------------------
			//  labelField
			//----------------------------------
			/**
			 *  @private
			 */
			override public function set labelField(value:String):void
			{
				super.labelField=value;
				
				invalidateProperties();
				invalidateDisplayList();
			}
			
			
			//--------------------------------------------------------------------------
			//
			//  Properties
			//
			//--------------------------------------------------------------------------
			
			
			//----------------------------------
			//  filterFunction
			//----------------------------------
			
			/**
			 *  @private
			 *  Storage for the filterFunction property.
			 */
			private var _filterFunction:Function=defaultFilterFunction;
			
			/**
			 *  @private
			 */
			private var filterFunctionChanged:Boolean=true;
			
			[Bindable("filterFunctionChange")]
			[Inspectable(category="General")]
			
			/**
			 *  A function that is used to select items that match the
			 *  function's criteria.
			 *  A filterFunction is expected to have the following signature:
			 *
			 *  <pre>f(item:~~, text:String):Boolean</pre>
			 *
			 *  where the return value is <code>true</code> if the specified item
			 *  should displayed as a suggestion.
			 *  Whenever there is a change in text in the AutoComplete control, this
			 *  filterFunction is run on each item in the <code>dataProvider</code>.
			 *
			 *  <p>The default implementation for filterFunction works as follows:<br>
			 *  If "AB" has been typed, it will display all the items matching
			 *  "AB~~" (ABaa, ABcc, abAc etc.).</p>
			 *
			 *  <p>An example usage of a customized filterFunction is when text typed
			 *  is a regular expression and we nt to display all the
			 *  items which come in the set.</p>
			 *
			 *  @example
			 *  <pre>
			 *  public function myFilterFunction(item:~~, text:String):Boolean
			 *  {
			 *     public var regExp:RegExp = new RegExp(text,"");
			 *     return regExp.test(item);
			 *  }
			 *  </pre>
			 *
			 */
			public function get filterFunction():Function
			{
				return _filterFunction;
			}
			
			/**
			 *  @private
			 */
			public function set filterFunction(value:Function):void
			{
				//An empty filterFunction is allowed but not a null filterFunction
				if (value != null)
				{
					_filterFunction=value;
					filterFunctionChanged=true;
					
					invalidateProperties();
					invalidateDisplayList();
					
					dispatchEvent(new Event("filterFunctionChange"));
				}
				else
					_filterFunction=defaultFilterFunction;
			}
			
			//----------------------------------
			//  filterFunction
			//----------------------------------
			
			/**
			 *  @private
			 *  Storage for the keepLocalHistory property.
			 */
			private var _keepLocalHistory:Boolean=false;
			
			/**
			 *  @private
			 */
			private var keepLocalHistoryChanged:Boolean=true;
			
			[Bindable("keepLocalHistoryChange")]
			[Inspectable(category="General")]
			
			/**
			 *  When true, this causes the control to keep track of the
			 *  entries that are typed into the control, and saves the
			 *  history as a local shared object. When true, the
			 *  completionFunction and dataProvider are ignored.
			 *
			 *  @default "false"
			 */
			public function get keepLocalHistory():Boolean
			{
				return _keepLocalHistory;
			}
			
			/**
			 *  @private
			 */
			public function set keepLocalHistory(value:Boolean):void
			{
				_keepLocalHistory=value;
			}
			
			//----------------------------------
			//  lookAhead
			//----------------------------------
			
			/**
			 *  @private
			 *  Storage for the lookAhead property.
			 */
			private var _lookAhead:Boolean=false;
			
			/**
			 *  @private
			 */
			private var lookAheadChanged:Boolean;
			
			[Bindable("lookAheadChange")]
			[Inspectable(category="Data")]
			
			/**
			 *  lookAhead decides whether to auto complete the text in the text field
			 *  with the first item in the drop down list or not.
			 *
			 *  @default "false"
			 */
			public function get lookAhead():Boolean
			{
				return _lookAhead;
			}
			
			/**
			 *  @private
			 */
			public function set lookAhead(value:Boolean):void
			{
				_lookAhead=value;
				lookAheadChanged=true;
			}
			
			//----------------------------------
			//  typedText
			//----------------------------------
			
			/**
			 *  @private
			 *  Storage for the typedText property.
			 */
			private var _typedText:String="";
			/**
			 *  @private
			 */
			private var typedTextChanged:Boolean;
			
			[Bindable("typedTextChange")]
			[Inspectable(category="Data")]
			
			/**
			 *  A String to keep track of the text changed as
			 *  a result of user interaction.
			 */
			public function get typedText():String
			{
				return _typedText;
			}
			
			/**
			 *  @private
			 */
			public function set typedText(input:String):void
			{
				_typedText=input;
				typedTextChanged=true;
				
				invalidateProperties();
				invalidateDisplayList();
				dispatchEvent(new Event("typedTextChange"));
			}
			
			//--------------------------------------------------------------------------
			//
			//  Overridden methods
			//
			//--------------------------------------------------------------------------
			
			/**
			 *  @private
			 */
			override protected function commitProperties():void
			{
				super.commitProperties();
				
				if (!dropdown)
					selectedIndex=-1;
				
				if (dropdown)
				{
					if (typedTextChanged)
					{
						cursorPosition=textInput.selectionBeginIndex;
						
						updateDataProvider();
						
						//In case there are no suggestions there is no need to show the dropdown
						if (collection.length == 0 || typedText == "" || typedText == null)
						{
							dropdownClosed=true;
							showDropdown=false;
						}
						else
						{
							showDropdown=true;
							selectedIndex=0;
						}
					}
				}
			}
			
			/**
			 *  @private
			 */
			override public function getStyle(styleProp:String):*
			{
				if (styleProp != "openDuration")
					return super.getStyle(styleProp);
				else
				{
					if (dropdownClosed)
						return super.getStyle(styleProp);
					else
						return 0;
				}
			}
			
			/**
			 *  @private
			 */
			override protected function keyDownHandler(event:KeyboardEvent):void
			{
				super.keyDownHandler(event);
				
				if (!event.ctrlKey)
				{
					if (event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)
					{
						textInput.setSelection(cursorPosition, cursorPosition);
					}
					if (event.keyCode == Keyboard.ESCAPE && showingDropdown)
					{
						textInput.text=_typedText;
						textInput.setSelection(cursorPosition, cursorPosition);
						showingDropdown=false;
						dropdownClosed=true;
					}
					else if (event.keyCode == Keyboard.ENTER)
					{
						if (keepLocalHistory && dataProvider.length == 0)
							addToLocalHistory();
					}
					else if (lookAhead && event.keyCode == Keyboard.BACKSPACE || event.keyCode == Keyboard.DELETE)
						removeHighlight=true;
				}
				else if (event.ctrlKey && event.keyCode == Keyboard.UP)
					dropdownClosed=true;
				
				prevIndex=selectedIndex;
			}
			
			/**
			 *  @private
			 */
			override protected function measure():void
			{
				super.measure();
				measuredWidth=mx.core.UIComponent.DEFAULT_MEASURED_WIDTH;
			}
			
			/**
			 *  @private
			 */
			override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
			{
				mx_internal::textChanged=false;
				super.updateDisplayList(unscaledWidth, unscaledHeight);
				
				if (_textEmpty && _prompt != "" && !_currentlyFocused)
				{
					if (_promptFormat == "")
					{
						textInput.text=_prompt;
					}
					else
					{
						textInput.htmlText=_promptFormat.replace(/\[prompt\]/g, _prompt);
					}
				}
				else
				{
					textInput.htmlText='';
					textInput.text=_typedText;
				}
				
				if (dropdown)
				{
					if (typedTextChanged)
					{
						//This is needed because a call to super.updateDisplayList() set the text
						// in the textInput to "" and thus the value
						//typed by the user losts
						if (lookAhead && showDropdown && typedText != "" && !removeHighlight)
						{
							/* var label:String = itemToLabel(collection[0]);
							var index:Number =  label.toLowerCase().indexOf(_typedText.toLowerCase());
							if(index==0)
							{
							textInput.text = _typedText+label.substr(_typedText.length);
							textInput.setSelection(textInput.text.length,_typedText.length);
							}
							else */
							{
								textInput.text=_typedText;
								textInput.setSelection(cursorPosition, cursorPosition);
								removeHighlight=false;
							}
							
						}
						else
						{
							textInput.text=_typedText;
							textInput.setSelection(cursorPosition, cursorPosition);
							removeHighlight=false;
						}
						
						typedTextChanged=false;
					}
				}
				if (showDropdown && !dropdown.visible)
				{
					//This is needed to control the open duration of the dropdown
					super.open();
					showDropdown=false;
					showingDropdown=true;
					
					if (dropdownClosed)
						dropdownClosed=false;
					
					/* if (dropdown)
					dropdown.contextMenu = createContextMenu(); */
				}
			}
			
			//--------------------------------------------------------------------------
			//
			//  Methods
			//
			//--------------------------------------------------------------------------
			
			/**
			 *  @private
			 *  If keepLocalHistory is enabled, stores the text typed
			 * 	by the user in the local history on the client machine
			 */
			private function addToLocalHistory():void
			{
				if (id != null && id != "" && text != null && text != "")
				{
					var so:SharedObject=SharedObject.getLocal("AutoCompleteData");
					
					var savedData:Array=so.data.suggestions;
					//No shared object has been created so far
					if (savedData == null)
						savedData=new Array();
					
					var i:Number=0;
					var flag:Boolean=false;
					//Check if this entry is there in the previously saved shared object data
					for (i=0; i < savedData.length; i++)
						if (savedData[i] == text)
						{
							flag=true;
							break;
						}
					if (!flag)
					{
						//Also ensure it is not there in the dataProvider
						for (i=0; i < collection.length; i++)
							if (defaultFilterFunction(itemToLabel(ListCollectionView(collection).getItemAt(i)), text))
							{
								flag=true;
								break;
							}
					}
					if (!flag)
						savedData.push(text);
					
					so.data.suggestions=savedData;
					//write the shared object in the .sol file
					so.flush();
				}
			}
			
			/**
			 *  @private
			 */
			protected function defaultFilterFunction(element:*, text:String):Boolean
			{
				//		var checkVsEmail:Boolean;
				var checkVsName:Boolean;
				//	var emailLabel:String=element.email;
				var nameLable:String=element.label;
				//get what the user is currently typing between two valid emails (two ',') or if it's the last
				var currentTypedLable:String=getCurrentlyTypedValue(text.toLowerCase(), textInput != null ? textInput.selectionBeginIndex : 0);
				/* 	if (currentTypedLable != '')
				checkVsEmail=(emailLabel.toLowerCase().substring(0, currentTypedLable.length) == currentTypedLable);
				else
				return false; */
				checkVsName=((nameLable != '') && (nameLable.toLowerCase().substring(0, currentTypedLable.length) == currentTypedLable));
				return checkVsName //|| checkVsEmail); */
				
				return true;
			}
			
			protected function getCurrentlyTypedValue(testText:String, cursorPos:int):String
			{
				var fromCursor:String=testText.substr(cursorPos);
				var tillNextCommaOrEnd:String=fromCursor.substring(0, fromCursor.indexOf(","));
				var fromLastComma:String=testText.substring(0, cursorPos);
				fromLastComma=fromLastComma.substring(fromLastComma.lastIndexOf(',') + 1);
				var currentlyTypedValue:String=mx.utils.StringUtil.trim(fromLastComma + tillNextCommaOrEnd);
				return currentlyTypedValue;
			}
			
			/**
			 *  @private
			 */
			
			private function templateFilterFunction(element:*):Boolean
			{
				var flag:Boolean=false;
				if (filterFunction != null)
					flag=filterFunction(element, typedText);
				return flag;
			}
			
			/**
			 *  @private
			 *  Updates the dataProvider used for showing suggestions
			 */
			private function updateDataProvider():void
			{
				dataProvider=tempCollection;
				collection.filterFunction=templateFilterFunction;
				collection.refresh();
				
				//In case there are no suggestions, check there is something in the localHistory
				if (collection.length == 0 && keepLocalHistory)
				{
					var so:SharedObject=SharedObject.getLocal("AutoCompleteData");
					usingLocalHistory=true;
					dataProvider=so.data.suggestions;
					usingLocalHistory=false;
					collection.filterFunction=templateFilterFunction;
					collection.refresh();
				}
			}
		}

}