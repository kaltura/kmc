package com.kaltura.edw.model
{
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class DropFolderModel {
		
		/**
		 * currently selected drop folder 
		 */		
		public var selectedDropFolder:KalturaDropFolder;	
		
		/**
		 * list of DropFolders 
		 */
		public var dropFolders:ArrayCollection;
		
		/**
		 * list of files in the selected DropFolder
		 */
		public var dropFolderFiles:ArrayCollection;
		
		/**
		 * list of files from all drop folders
		 */
		public var files:ArrayCollection;
		
		/**
		 * drop folders files filter
		 * */
		public var filter:KalturaDropFolderFileFilter;

		/**
		 * drop folders files pager
		 * */
		public var pager:KalturaFilterPager;
		
		/**
		 * total amount of drop folder files
		 * */
		public var filesTotalCount:int;
	
	}
}