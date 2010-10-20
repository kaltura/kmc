package com.kaltura.controls {
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import mx.events.NumericStepperEvent;

	/**
	 * A NumericStepper for time values. <br/>
	 * extends SM_TimeEntry to support minimum value.
	 * @author Atar
	 */	
	public class TimeStepper extends SM_TimeEntry {

		/**
		 * @copy #minimum 
		 */		
		private var _minimum:int;
		
		
		public function TimeStepper() {
			super();
		}



		/**
		 * transforms time from a single (seconds) value to an object 
		 * @param time	the time in seconds
		 * @return an object with <code>{hour, minute, second}</code> attributes. 
		 * */
		public function getTimeAsObject(time:int):Object {
			var o:Object = new Object();
			var h:int = Math.floor(time / 3600); // 60 * 60 = 3600
			var sh:int = h * 3600;
			var m:int = Math.floor((time - sh) / 60);
			var sm:int = m * 60;
			var s:int = time - sh - sm;
			o.hour = h;
			o.minute = m;
			o.second = s;
			return o;
		}
		
		
		/**
		 * make sure user entered valid text (minimum-wise).
		 * @param event
		 */
		override protected function fixText(event:Event):void {
			if (!(event.currentTarget == hourText && !is24Hour)) {
				_focusArea.text = (_focusArea.text.length < 2) ? "0" + _focusArea.text : _focusArea.text;
			}
			_focusArea.setSelection(0, 2);
			
			if (event.currentTarget == hourText)
				this.hour = Number(event.currentTarget.text);
			if (event.currentTarget == minuteText)
				this.minute = Number(timeStepper.value);
			if (event.currentTarget == secondText)
				this.second = Number(timeStepper.value);
			avoidLessThanMinimum();
		}

		/**
		 * on every change, see the new value is valid.
		 * if it is not, show the closest valid value.
		 */
		override protected function changeStepValue(event:Event):void {
			super.changeStepValue(event);
			avoidLessThanMinimum();
		}
		
		
		/**
		 * checks if curent value is less then the 
		 * minimum value, if so sets value to minimum.
		 * */
		private  function avoidLessThanMinimum():void {
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
			}
		}
		
		
		/**
		 * fix new value if needed, then use it.
		 * */
		override protected function keyHandler(event:KeyboardEvent):void {
			var handleValue:Boolean = false;
			if (event.keyCode == 39 || event.keyCode == 38) {
				handleValue = true;
				if (_focusArea == hourText) {
					_currentStepValue++;
					var tmpMaxValue:Number = (is24Hour) ? (maxHour) : maxHour;
					if (_currentStepValue > tmpMaxValue) {
						_currentStepValue = (is24Hour) ? 0 : 1;
					}
				}
				else /* if (_focusArea == minuteText || _focusArea == secondText) OR NULL */ {
					_currentStepValue++;
					if (_currentStepValue > 59) {
						_currentStepValue = 0;
					}
				}
			}
			if (event.keyCode == 37 || event.keyCode == 40) {
				handleValue = true;
				if (_focusArea == hourText) {
					_currentStepValue--;
					var tmpMinValue:Number = (is24Hour) ? 0 : 1;
					if (_currentStepValue < tmpMinValue) {
						_currentStepValue = (is24Hour) ? 23 : 12;
					}
				}
				else /* if (_focusArea == minuteText || _focusArea == secondText) OR NULL */ {
					_currentStepValue--;
					if (_currentStepValue < 0) {
						_currentStepValue = 59;
					}
				}
			}
			
			if (handleValue) {
				timeStepper.value = _currentStepValue;
				_focusArea.setSelection(0, 2);
				
				// fix minimum:
				var n:Number = timeStepper.value;
				avoidLessThanMinimum();
				// dispatch "change" event only if value has changed
				var dispatch:Boolean = false;
				switch(_focusArea) {
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

		/**
		 * display (and rememebr) minimum value in the component 
		 */		
		protected function setMinValue():void {
			var oMin:Object = getTimeAsObject(_minimum);
			this.hour = oMin.hour;
			this.minute = oMin.minute;
			this.second = oMin.second;
			
			if (timeStepper != null) {
				if (_focusArea == hourText)
					timeStepper.value = this.hour;
				if (_focusArea == minuteText)
					timeStepper.value = this.minute;
				if (_focusArea == secondText)
					timeStepper.value = this.second;
			}
		}
		
		
		override public function set timeValue(value:Object):void {
			this.hour = value.hour;
			this.minute = value.minute;
			this.second = value.second;
			avoidLessThanMinimum();
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


	}
}