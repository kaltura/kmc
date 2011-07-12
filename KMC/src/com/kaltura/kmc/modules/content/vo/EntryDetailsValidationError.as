package com.kaltura.kmc.modules.content.vo
{
	public class EntryDetailsValidationError {
		
		public static const ENTRY_NAME_MISSING:String = "entryNameMissingError";
		public static const CATEGORIES_LIMIT:String = "categoriesLimitError";
		public static const SCHEDULING_START_DATE:String = "schedualingStartDateError";
		public static const SCHEDULING_END_DATE:String = "scedualingEndDateError";
		public static const BITRATE:String = "bitrateError";
		public static const CAPTIONS_URL:String = "captionsUrl";
		public static const CAPTIONS_LANGUAGE:String = "captionsLanguage";
		
		
		public var error:String;
		
		public function EntryDetailsValidationError() {}

	}
}