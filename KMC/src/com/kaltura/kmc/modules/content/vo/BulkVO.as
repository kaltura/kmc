package com.kaltura.kmc.modules.content.vo
{
	[Bindable]
	public class BulkVO
	{
		public var uploadedBy : String;
		public var uploadedOn : String;
		public var numOfEntries : uint;
		public var status : String;
		public var error : String;
		public var logFileUrl : String;
		public var csvFileUrl : String;
		public var page : uint = 1;
		public var page_size : uint = 10;
	}
}