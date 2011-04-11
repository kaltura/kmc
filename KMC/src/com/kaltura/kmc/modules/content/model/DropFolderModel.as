package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaDropFolder;
	
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
		
		

	}
}