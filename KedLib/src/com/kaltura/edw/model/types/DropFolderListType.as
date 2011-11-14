package com.kaltura.edw.model.types
{
	public class DropFolderListType {
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_LEAVE</code>, <code>ADD_NEW</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const MATCH_OR_NEW:uint = 0x0001;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_NEW</code>, <code>ADD_NEW</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const MATCH_OR_KEEP:uint = 0x0002;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_NEW</code>, <code>MATCH_OR_LEAVE</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const ADD_NEW:uint = 0x0004;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag with the 
		 *  <code>MATCH_OR_NEW</code>, <code>MATCH_OR_LEAVE</code>, <code>ADD_NEW</code> flags.
		 */
		public static const XML_FOLDER:uint = 0x0008;
	}
}