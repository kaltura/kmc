package com.kaltura.kmc.modules.create
{
	import com.kaltura.KalturaClient;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReferenceList;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class MultipleMediaFilesSelector extends EventDispatcher {
		
		public static const VIDEO_TYPES:String = "*.flv;*.asf;*.qt;*.mov;*.mpg;*.avi;*.wmv;*.mp4;*.3gp;*.f4v;*.m4v";
		public static const AUDIO_TYPES:String = "*.flv;*.asf;*.qt;*.mov;*.mpg;*.avi;*.wmv;*.mp3;*.wav";
		public static const IMAGE_TYPES:String = "*.jpg;*.jpeg;*.gif;*.png";
		
		public static const FILES_SELECTED:String = "filesSelected";
		
		/**
		 * files reference for files upload
		 * */
		private var _fileReferenceList:FileReferenceList;
		
		
		public function MultipleMediaFilesSelector() {
			
		}
		
		
		/**
		 * will open a browse window and allow multiple selection
		 * */
		public function doFileUpload():void {
			_fileReferenceList = new FileReferenceList();
			_fileReferenceList.addEventListener(Event.SELECT, onFilesSelected);
			_fileReferenceList.browse(getFileFilters());
		}
		
		/**
		 * create file filters for uploading files
		 * */
		private function getFileFilters():Array {
			var rm:IResourceManager = ResourceManager.getInstance();
			var	vidFilter:FileFilter = new FileFilter(rm.getString('create', 'video_files') + "(" + VIDEO_TYPES + ")", VIDEO_TYPES);
			var	audFilter:FileFilter = new FileFilter(rm.getString('create', 'audio_files') + "(" + AUDIO_TYPES + ")", AUDIO_TYPES);
			var	imgFilter:FileFilter = new FileFilter(rm.getString('create', 'image_files') + "(" + IMAGE_TYPES + ")", IMAGE_TYPES);
			
			return [vidFilter, audFilter, imgFilter];
		}
		
		/**
		 * handle user files selection to upload
		 * */
		private function onFilesSelected(event:Event):void {
//			trace("MultipleMediaFilesSelector.onFilesSelected");
			_fileReferenceList.removeEventListener(Event.SELECT, onFilesSelected);
			
			dispatchEvent(new Event(FILES_SELECTED));
			
		}
		
		public function getFiles():Array {
			return _fileReferenceList.fileList;
		}
	}
}