package com.kaltura.edw.constants
{
	import mx.resources.ResourceManager;

	public class FileTypes
	{
		public static var VIDEO_TYPES:String = "*.flv;*.asf;*.qt;*.mov;*.mpg;*.avi;*.wmv;*.mp4;*.3gp;*.f4v;*.m4v";
		public static var AUDIO_TYPES:String = "*.flv;*.asf;*.qt;*.mov;*.mpg;*.avi;*.wmv;*.mp3;*.wav";
		
		public static function setFileTypes(filters:XMLList):void {
			var filter:XML = filters.(@name=="video_files")[0];
			FileTypes.VIDEO_TYPES = filter.@ext;
			filter = filters.(@name=="audio_files")[0];
			FileTypes.AUDIO_TYPES = filter.@ext;
		}
	}
}