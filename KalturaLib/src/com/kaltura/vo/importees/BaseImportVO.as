/*
This file is part of the Kaltura Collaborative Media Suite which allows users
to do with audio, video, and animation what Wiki platfroms allow them to do with
text.

Copyright (C) 2006-2008  Kaltura Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

@ignore
*/
package com.kaltura.vo.importees
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.MediaMetaDataVO;

	[Bindable]
	public class BaseImportVO implements IValueObject
	{
		public var metaData:MediaMetaDataVO = new MediaMetaDataVO();
		/**
		*This media provider id (e.g 0, which can be the code for NewHype fictional provider).
		*This is an extra info which isn't always delivered by the search service:
		*	For example, when the user searches in video\youtube the search results necessarily are retrieved from youtube service and the client saves that
		*	information so when the search results come back, it injects the media provider id into the search results, so that when the entries are added,
		*	The add entries service can know, which media provider they belong to.
		*
		* However, the search service can be used to grab images from URL, In this case,
		* the provider is different every time (e.g www.google.com / www.dzone.com), and when getting this service media info,
		* the service might be kind enough to supply metadata from that source, if it's capable of doing so.
		* In that case, the mediaProviderCode is given when the search results comes back from the server
		*/
		public var mediaProviderCode:String;


		//public var thumbURL:String;
		public function set thumbURL(value:String):void
		{
			_thumbURL = value;
		}
		public function get thumbURL():String
		{
			return _thumbURL;
		}
		/**
		 * this search result media type
		 * @param mediaCode
		 *
		 */
		public function set mediaTypeCode(mediaCode:int):void
		{
			_mediaTypeCode = mediaCode;
		}
		public function get mediaTypeCode():int
		{
			return _mediaTypeCode;
		}

		public var state:ImportVOState = new ImportVOState();

		private var _mediaTypeCode:int = -1;

		private var _thumbURL:String;

		//TODO: implement an abstract function pattern
		public function BaseImportVO(metaData:MediaMetaDataVO = null, mediaProviderCode:String = null, mediaTypeCode:int = -1):void
		{
			this.metaData = (metaData == null ? new MediaMetaDataVO() : metaData);
			this.mediaProviderCode = mediaProviderCode;
			this.mediaTypeCode = mediaTypeCode;
		}

		public function mergeWith(mergeFrom:BaseImportVO):void
		{
			if (!this.thumbURL)
				this.thumbURL = mergeFrom.thumbURL;
			metaData.mergeWith(mergeFrom.metaData);
		}
	}
}