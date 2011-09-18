package com.kaltura.kmc.modules.studio.vo {
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
	import mx.controls.NumericStepper;
	import mx.controls.TextInput;
	import mx.core.UIComponent;

	public class ApsOptionItemVo extends Object {

		private var _xml:XML;
		private var _type:String;
		private var _component:UIComponent;
		private var _name:String;


		public function ApsOptionItemVo(xml:XML, type:String, componnt:UIComponent, name:String) {
			super();
			_type = type;
			_xml = xml;
			_component = componnt;
			_name = name;
		}


		public function get type():String {
			return _type;
		}


		public function get component():UIComponent {
			return _component;
		}


		public function get name():String {
			return _name;
		}


		public function get xml():XML {
			return _xml;
		}


		public function dispose():void {
			_xml = null;
			_component = null;
		}


		public function get parameter():String {
			switch (_type) {
				case "ComboBox":
					return (component as ComboBox).selectedItem.data.toString();
					break;
				case "Input":
					return (component as TextInput).text as String;
					break;
				case "CheckBox":
					return (component as CheckBox).selected as String;
					break;
				case "NumericStepper":
					return (component as NumericStepper).value as String;
					break;
			}
			return "";
		}


		public function get hasParam():Boolean {
			if (_xml.@k_param.length() > 0) {
				return true
			}
			return false
		}


		public function set parameter(value:String):void {
			switch (_type) {
				case "ComboBox":
					break;
				case "Input":
					_xml.@k_value = value;
					break;
				case "CheckBox":
					_xml.@k_value = _xml.@selected = value;
					break;
				case "NumericStepper":
					_xml.@k_value = value;
					break;
			}
		}

	}
}