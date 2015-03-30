package com.kaltura.controls {
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	import mx.controls.NumericStepper;
	import mx.controls.Spacer;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	import mx.events.NumericStepperEvent;
	import mx.validators.NumberValidator;

	[Event(name="change", type="mx.events.FlexEvent")]
	
	/**
	 * A NumericStepper for time values. <br/>
	 * extends SM_TimeEntry to support minimum/maximum value + miliseconds.
	 * @author Atar
	 */	
	public class TimeStepper extends SM_TimeEntry {

		/**
		 * use the miliseconds part of the stepper 
		 */
		public var showMiliseconds:Boolean;
		
		/**
		 * text input for showing ms 
		 */
		public var msText:TextInput;
		
		protected var spacer1:Spacer;
		protected var spacer2:Spacer;
		protected var separator:Label;
		
		public var msValidator:NumberValidator;
		
		
		
		public var defaultMilisecond:Number = 0;
		
		
		/**
		 * current hour value
		 * */
		[Bindable] public var milisecond:Number = 0;
		
		/**
		 * @copy #minimum 
		 */		
		private var _minimum:int;
		
		/**
		 * @copy #maximum 
		 */		
		private var _maximum:int;
		
		
		public function TimeStepper() {
			super();
		}

		
		/**
		 * transform time from object properties to a single secnods value.
		 * */
		public function getTimeAsSeconds():Number {
			var h:int = hour * 3600; // 60 * 60 = 3600
			var m:int = minute * 60;
			return second + m + h + milisecond/1000;
		}

		/**
		 * transforms time from a single (seconds) value to an object 
		 * @param time	the time in seconds
		 * @return an object with <code>{hour, minute, second}</code> attributes. 
		 * */
		public function getTimeAsObject(time:Number):Object {
			var secondsForCalc:Number = Math.floor(time);
			var o:Object = new Object();
			var h:Number = Math.floor(secondsForCalc / 3600); // 60 * 60 = 3600
			var sh:Number = h * 3600;
			var m:Number = Math.floor((secondsForCalc - sh) / 60);
			var sm:Number = m * 60;
			var s:Number = secondsForCalc - sh - sm;
			
			o.hour = h%24;
			o.minute = m;
			o.second = s;
			o.milisecond = Math.floor(time*1000 - secondsForCalc*1000);  // (time - secondsForCalc)*1000 causes rounding error!!!
//			trace("time as object: ", time, "[",h,m,s,o.milisecond,"]");
			return o;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			var insertionIndex:int = timeBox.getChildIndex(secondText) + 1;
			if (!spacer1) {
				spacer1 = new Spacer();
				spacer1.width = -8;
				BindingUtils.bindProperty(spacer1, "visible", this, "showMiliseconds");
				BindingUtils.bindProperty(spacer1, "includeInLayout", this, "showMiliseconds");
				timeBox.addChildAt(spacer1, insertionIndex++);
			}
			if (!separator) {
				separator = new Label();
				separator.text = ".";
				BindingUtils.bindProperty(separator, "visible", this, "showMiliseconds");
				BindingUtils.bindProperty(separator, "includeInLayout", this, "showMiliseconds");
				timeBox.addChildAt(separator, insertionIndex++);
			}
			if (!spacer2) {
				spacer2 = new Spacer();
				spacer2.width = -16;
				BindingUtils.bindProperty(spacer2, "visible", this, "showMiliseconds");
				BindingUtils.bindProperty(spacer2, "includeInLayout", this, "showMiliseconds");
				timeBox.addChildAt(spacer2, insertionIndex++);
			}
			if (!msText) {
				msText = new TextInput();
				msText.id = "msText";
				msText.percentHeight = 100;
				msText.maxChars = 3;
				msText.addEventListener(Event.CHANGE, setValues, false, 0, true);
				msText.addEventListener(FocusEvent.FOCUS_IN, setTextFocus, false, 0, true);
				msText.addEventListener(FocusEvent.FOCUS_OUT, fixText, false, 0, true);
				msText.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler, false, 0, true);
				msText.addEventListener(MouseEvent.MOUSE_DOWN, setTextFocus, false, 0, true);
				msText.addEventListener(MouseEvent.MOUSE_UP, setTextFocus, false, 0, true);
				msText.setStyle("backgroundAlpha", 0);
				msText.setStyle("backgroundColor", 0xff0000);
				msText.setStyle("textAlign", "center");
				msText.setStyle("borderStyle", "none");
				msText.setStyle("borderThickness", 0);
				msText.setStyle("focusAlpha", 0);
				BindingUtils.bindProperty(msText, "visible", this, "showMiliseconds");
				BindingUtils.bindProperty(msText, "includeInLayout", this, "showMiliseconds");
				BindingUtils.bindSetter(formatMilisecondText, this, "milisecond");
				timeBox.addChildAt(msText, insertionIndex++);
			}
		}
		
		
		
		private function formatMilisecondText(value:Object):void {
			msText.text = formatText(String(milisecond), 'msText');
		}
		
		
		private function invalidMSValue(e:Event):void {
			msText.text = '999';
		}
		
		override protected function createComplete():void {
			timeStepper.minimum = -1;
			timeStepper.maximum = 1000;
			// create ms validator
			msValidator = new NumberValidator();
			msValidator.source = secondText; 
			msValidator.addEventListener("invalid", invalidMSValue, false, 0, true);
			msValidator.exceedsMaxError = ""; 
			msValidator.lowerThanMinError = ""; 
			msValidator.integerError = "";
			msValidator.property = "text";
			msValidator.maxValue = 999;
			msValidator.minValue = 0;
			msValidator.allowNegative = false;
			msValidator.trigger = msText; 
			msValidator.triggerEvent = "change"; 
				
			// set value
			if (!this.milisecond) {
				if (defaultMilisecond < 10) {
					msText.text = "00" + String(defaultMilisecond);
				}
				else if (defaultMilisecond < 100){
					msText.text = "0" + String(defaultMilisecond);
				}
				else {
					msText.text = String(defaultMilisecond);
				}
				
				this.milisecond = Number(msText.text);
			}
			
			// trigger super
			super.createComplete();
		}
		
		
		override public function get timeValue():Object {
			var o:Object = super.timeValue;
			if (!is24Hour && am_pm == "pm" && o.hour < 12) {
				// add 12 hours so hour value will be correct
				o.hour += 12;
			}
			o.milisecond = this.milisecond;
			return o;
		}
		
		/**
		 * make sure user entered valid text (minimum-wise).
		 * @param event
		 */
		override protected function fixText(event:Event):void {
			var changed:Boolean = false;
			var newVal:Number;
			if (!(event.currentTarget == hourText && !is24Hour)) {
				_focusArea.text = (_focusArea.text.length < 2) ? "0" + _focusArea.text : _focusArea.text;
			}
			_focusArea.setSelection(0, 3);
			
			if (event.currentTarget == hourText) {
				newVal = Number(event.currentTarget.text);
				if (newVal != this.hour) {
					this.hour = newVal; 
					changed = true;
				}
			}
			else if (event.currentTarget == minuteText) {
				newVal = Number(timeStepper.value);
				if (newVal != this.minute) {
					this.minute = newVal;
					changed = true;
				}
			}
			else if (event.currentTarget == secondText) {
				newVal = Number(timeStepper.value);
				if (newVal != this.second ) {
					this.second = newVal;
					changed = true;
				}
			}
			else if (event.currentTarget == msText) {
				newVal = Number(timeStepper.value);
				if (newVal != this.milisecond ) {
					this.milisecond = newVal;
					changed = true;
				}
			}
				
			avoidLessThanMinimum();
			avoidMoreThanMaximum();
			
			// dispatch change event if needed
			if (changed) {
				dispatchEvent(new FlexEvent("change"));	
			}
		}

		/**
		 * on every change, see the new value is valid.
		 * if it is not, show the closest valid value.
		 */
		override protected function changeStepValue(event:Event):void {
			super.changeStepValue(event);
			if (_focusArea == msText) {
				if (NumericStepper(event.target).value > 999) {
					NumericStepper(event.target).value = 0;
				}
				else if (NumericStepper(event.target).value < 0) {
					NumericStepper(event.target).value = 999;
				}
				this.milisecond = NumericStepper(event.target).value;
			}
			avoidLessThanMinimum();
			avoidMoreThanMaximum();
			dispatchEvent(new FlexEvent("change"));
		}
		
		override protected function setValues(event:Event):void {
			super.setValues(event);
			if (event.currentTarget == msText) {
				if (msValidator.validate(Number(event.currentTarget.text)))
					timeStepper.value = Number(event.currentTarget.text);
			}
		}
		
		/**
		 * checks if curent value is less than the 
		 * minimum value, if so sets value to minimum.
		 * */
		private  function avoidLessThanMinimum():void {
			if (!_minimum) return;
			var oMin:Object = getTimeAsObject(_minimum);
			if (hour < oMin.hour) {
				setMinValue();
			}
			else if (hour == oMin.hour) {
				if (minute < oMin.minute) {
					setMinValue();
				}
				else if (minute == oMin.minute) {
					if (second < oMin.second) {
						setMinValue();
					}
					//TODO support minimal ms value
				}
			}
			// correct _currentStepValue:
			switch (_focusArea) {
				case hourText:
					_currentStepValue = this.hour;
					break;
				case minuteText:
					_currentStepValue = this.minute;
					break;
				case secondText:
					_currentStepValue = this.second;
					break;
				case msText:
					_currentStepValue = this.milisecond;
					break;
			}
		}
		
		/**
		 * checks if curent value is more than the 
		 * maximum value, if so sets value to maximum.
		 * */
		private  function avoidMoreThanMaximum():void {
			if (!_maximum) return;
			var oMax:Object = getTimeAsObject(_maximum);
			if (hour > oMax.hour) {
				setMaxValue(); 
			}
			else if (hour == oMax.hour) {
				if (minute > oMax.minute) {
					setMaxValue();
				}
				else if (minute == oMax.minute) {
					if (second > oMax.second) {
						setMaxValue();
					}
					//TODO support maximal ms value
				}
			}
			// correct _currentStepValue:
			switch (_focusArea) {
				case hourText:
					_currentStepValue = this.hour;
					break;
				case minuteText:
					_currentStepValue = this.minute;
					break;
				case secondText:
					_currentStepValue = this.second;
					break;
				case msText:
					_currentStepValue = this.milisecond;
					break;
			}
		}
		
		
		/**
		 * fix new value if needed, then use it.
		 * */
		override protected function keyHandler(event:KeyboardEvent):void {
			var handleValue:Boolean = false;
			if (event.keyCode == 39 || event.keyCode == 38) {
				handleValue = true;
				_currentStepValue++;
				if (_focusArea == hourText) {
					var tmpMaxValue:Number = (is24Hour) ? (maxHour) : maxHour;
					if (_currentStepValue > tmpMaxValue) {
						_currentStepValue = (is24Hour) ? 0 : 1;
					}
				}
				else if (_focusArea == minuteText || _focusArea == secondText) {
					if (_currentStepValue > 59) {
						_currentStepValue = 0;
					}
				}
				else {
					if (_currentStepValue > 999) {
						_currentStepValue = 0;
					}
				}
			}
			if (event.keyCode == 37 || event.keyCode == 40) {
				handleValue = true;
				_currentStepValue--;
				if (_focusArea == hourText) {
					var tmpMinValue:Number = (is24Hour) ? 0 : 1;
					if (_currentStepValue < tmpMinValue) {
						_currentStepValue = (is24Hour) ? 23 : 12;
					}
				}
				else  if (_focusArea == minuteText || _focusArea == secondText) {
					if (_currentStepValue < 0) {
						_currentStepValue = 59;
					}
				}
				else {
					if (_currentStepValue < 0) {
						_currentStepValue = 999;
					}
				}
			}
			
			if (handleValue) {
				timeStepper.value = _currentStepValue;
				_focusArea.setSelection(0, 3);
				
				// fix boundaries:
				var n:Number = timeStepper.value;
				avoidLessThanMinimum();
				avoidMoreThanMaximum();
				// dispatch "change" event only if value has changed
				var dispatch:Boolean = false;
				switch(_focusArea) {
					case msText:
						if (this.milisecond != n) {
							dispatch = true;
						}
						break;
					case secondText:
						if (this.second != n) {
							dispatch = true;
						}
						break;
					case minuteText:
						if (this.minute != n) {
							dispatch = true;
						}
						break;
					case hourText:
						if (this.hour != n) {
							dispatch = true;
						}
						break;
				}
				if (dispatch) {
					timeStepper.dispatchEvent(new NumericStepperEvent('change'));
				}
			}
		}
		
		override protected function amPMKeyHandler(event:KeyboardEvent):void {
			super.amPMKeyHandler(event);
			if (event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 37 || event.keyCode == 39) {
				// notify any listeners of the change
				dispatchEvent(new FlexEvent('change'));
			}
		}
		
		override protected function formatText(value:String, theField:String):String {
			if (_focusArea) {
				_focusArea.setSelection(0, 3);
			}
			// hours when not is24Hours - use hour % 12
			if (theField == 'hourText' && !is24Hour ) {
				if (Number(value) > 12) {
					value = String(Number(value) % 12);
				}
				return value;
			}
			// hours when is24Hours, minutes, seconds - add trailing 0 to 2 digits
			else if (theField != 'msText') {
				return (value.length < 2) ? ("0" + value) : value;
			}
			// miliseconds - add trailing 0 to 3 digits
			else if (theField == 'msText') {
				if (value.length < 2) {
					return "00" + value;
				}
				else if (value.length < 3){
					return "0" + value;
				}
				else {
					return value;
				}
			}
			return '';
		}

		/**
		 * display (and rememebr) minimum value in the component 
		 */		
		protected function setMinValue():void {
//			trace("set min value");
			var oMin:Object = getTimeAsObject(_minimum);
			this.hour = oMin.hour;
			this.minute = oMin.minute;
			this.second = oMin.second;
			this.milisecond = oMin.milisecond;
			
			if (timeStepper != null) {
				if (_focusArea == hourText)
					timeStepper.value = this.hour;
				if (_focusArea == minuteText)
					timeStepper.value = this.minute;
				if (_focusArea == secondText)
					timeStepper.value = this.second;
				if (_focusArea == msText)
					timeStepper.value = this.milisecond;
			}
		}
		/**
		 * display (and rememebr) maximum value in the component 
		 */		
		protected function setMaxValue():void {
//			trace("set max value");
			var oMin:Object = getTimeAsObject(_maximum);
			this.hour = oMin.hour;
			this.minute = oMin.minute;
			this.second = oMin.second;
			this.milisecond = oMin.milisecond;
			
			if (timeStepper != null) {
				if (_focusArea == hourText)
					timeStepper.value = this.hour;
				if (_focusArea == minuteText)
					timeStepper.value = this.minute;
				if (_focusArea == secondText)
					timeStepper.value = this.second;
				if (_focusArea == msText)
					timeStepper.value = this.milisecond;
			}
		}
		
		
		override public function set timeValue(value:Object):void {
			hour = value.hour ? value.hour : 0;
			if (is24Hour) {
				am_pm = "am";
			}
			else {
				am_pm = (value.hour >= 12) ? "pm" : "am";
			}
			
			minute = value.minute ? value.minute : 0;
			second = value.second ? value.second : 0;
			milisecond = value.milisecond ? value.milisecond : 0;
			avoidLessThanMinimum();
			avoidMoreThanMaximum();
		}
		
		/**
		 * minimum value for this component (in seconds) 
		 */
		public function get minimum():int
		{
			return _minimum;
		}

		/**
		 * @private
		 */
		public function set minimum(value:int):void
		{
			_minimum = value;
		}
		
		/**
		 * maximum value for this component (in seconds) 
		 */
		public function get maximum():int
		{
			return _maximum;
		}

		/**
		 * @private
		 */
		public function set maximum(value:int):void
		{
			_maximum = value;
		}

				
		
	}
}