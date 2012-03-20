package com.kaltura.edw.components.fltr.panels
{
	import com.kaltura.edw.components.fltr.IMultiAttributeFilterComponent;
	
	public class MultiAttributeFilter extends AdditionalFilter implements IMultiAttributeFilterComponent {
		
		
		/**
		 * keys are attribute names, values are respective filter values
		 * */
		protected var _vo:Object = {};
		
		
		protected var _attributes:Array;
		
		public function set attributes(value:Array):void {
			_attributes = value;
		}
		
		public function get attributes():Array {
			return _attributes;
		}
		
		
		public function set kfilters(value:Array):void {
			// update vo:
			_vo = {};
			for (var i:int = 0; i<_attributes.length; i++) {
				_vo[_attributes[i]] = value[i];
			}
		}
		
		public function get kfilters():Array {
			var result:Array = [];
			for (var i:int = 0; i<_attributes.length; i++) {
				result.push(_vo[_attributes[i]]);
			}
			return result;
		} 
		
		/**
		 * override to do nothing
		 * */
		override public function set filter(value:Object):void {}
		
		override public function get filter():Object {
			return null;
		}

		
	}
}