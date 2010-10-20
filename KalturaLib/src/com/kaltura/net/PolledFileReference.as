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
package com.kaltura.net
{
	import flash.net.FileReference;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	* A fileReference object wrapper that holds its bytesLoaded and bytesTotal as members.
	* This is useful when a recycled item renderer needs to know the loading state.
	*/
	[Event(name="cancel", type="flash.events.Event")]
	[Bindable]
	public class PolledFileReference extends EventDispatcher
	{
		public var fileReference:FileReference;

		/**
		* inidicates if the FileReference object has been opened, means that the upload/download has begun.
		* This is useful if the fileReference needs to be used as data source for itemRenderer in a component that recycles iotem renderers, which forces
		* them to be fully data driven. that means that it can't rely on Event.OPEN because the item renderer data is populated with
		* different FileReference objects.
		*/
		public var hasBeenOpened:Boolean = false;

		public var bytesLoaded:uint = 0;
		public var bytesTotal:uint = 0;


		public function PolledFileReference(fileReference:FileReference):void
		{
			this.fileReference = fileReference
			this.fileReference.addEventListener(ProgressEvent.PROGRESS, onProgress);
			this.fileReference.addEventListener(Event.OPEN, onFileReferenceOpen);
			this.fileReference.addEventListener(Event.COMPLETE, onFileReferenceComplete)
		}

		public function cancel():void
		{
			this.fileReference.cancel();
			dispatchEvent(new Event(Event.CANCEL));
		}
		private function onProgress(evtProgress:ProgressEvent):void
		{
			bytesLoaded = evtProgress.bytesLoaded;
			bytesTotal = evtProgress.bytesTotal;
			trace("FileReference progress: " + bytesLoaded + " / " + bytesTotal + " file name: " + fileReference.name);
		}

		private function onFileReferenceOpen(evtOpen:Event):void
		{
			hasBeenOpened = true;
		}

		private function onFileReferenceComplete(evtComplete:Event):void
		{
			bytesLoaded = 1;
			bytesTotal = 1;
			hasBeenOpened = true;
		}
	}
}