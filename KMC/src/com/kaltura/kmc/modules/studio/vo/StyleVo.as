package com.kaltura.kmc.modules.studio.vo {

	/**
	 * StyleVo holds data concerning player colors and font.
	 * It is used as data object for <code>ApsWizStyle</code>.
	 * @author Atar
	 */	
	public class StyleVo {

		private var _color1:uint;
		private var _color2:uint;
		private var _color3:uint;
		private var _color4:uint;
		private var _color5:uint;
		private var _themeId:String;
		private var _themeFriendlyName:String;
		private var _fontName:String;
		private var _skinPath:String;



		public function get color1():uint {
			return _color1;
		}


		public function set color1(value:uint):void {
			_color1 = value;
		}


		public function get color2():uint {
			return _color2;
		}


		public function set color2(value:uint):void {
			_color2 = value;
		}


		public function get color3():uint {
			return _color3;
		}


		public function set color3(value:uint):void {
			_color3 = value;
		}


		public function get color4():uint {
			return _color4;
		}


		public function set color4(value:uint):void {
			_color4 = value;
		}


		public function get color5():uint {
			return _color5;
		}


		public function set color5(value:uint):void {
			_color5 = value;
		}


		public function get themeId():String {
			return _themeId;
		}


		public function set themeId(value:String):void {
			_themeId = value;
		}


		public function get fontName():String {
			return _fontName;
		}


		public function set fontName(value:String):void {
			_fontName = value;
		}

		public function get skinPath():String
		{
			return _skinPath;
		}

		public function set skinPath(value:String):void
		{
			_skinPath = value;
		}

		public function get themeFriendlyName():String
		{
			return _themeFriendlyName;
		}

		public function set themeFriendlyName(value:String):void
		{
			_themeFriendlyName = value;
		}


	}
}