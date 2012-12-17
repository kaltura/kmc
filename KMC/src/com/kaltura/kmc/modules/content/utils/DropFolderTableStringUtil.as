package com.kaltura.kmc.modules.content.utils
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import com.kaltura.vo.KalturaDropFolderFile;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	import com.kaltura.types.KalturaDropFolderFileStatus;
	import com.kaltura.types.KalturaDropFolderFileErrorCode;

	public class DropFolderTableStringUtil {
		
		/**
		 * used to convert to MegaByetes
		 * */
		private static const MB_MULTIPLIER:int = 1024*1024;
		
		/**
		 * in files size: number of digits to show after the decimal point
		 * */
		private static const DIGITS_AFTER_DEC_POINT:int = 2;
		
		
		/**
		 * date formatter for "created at" column 
		 */
		private static var dateDisplay:DateFormatter; 
		
		private static function initDateFormatter():void {
			dateDisplay = new DateFormatter();
			dateDisplay.formatString = "MM/DD/YYYY JJ:NN";
		}
			
		private static function formatDate(timestamp:int):String {
			if (timestamp == int.MIN_VALUE)
				return ResourceManager.getInstance().getString('dropfolders', 'n_a');
			var date:Date = new Date(timestamp * 1000);
			if (!dateDisplay) initDateFormatter();
			return dateDisplay.format(date);
		}
		
		
		/**
		 * creates the string to show as tooltip for "created at" column
		 * */
		public static function getDatesInfo(item:Object):String {
			var rm:IResourceManager = ResourceManager.getInstance();
			var file:KalturaDropFolderFile = item as KalturaDropFolderFile;
			var str:String = rm.getString('dropfolders', 'dfUploadStart' , [formatDate(file.uploadStartDetectedAt)] );
			str += '\n' + rm.getString('dropfolders', 'dfUploadEnd',  [formatDate(file.uploadEndDetectedAt)] );
			str += '\n' + rm.getString('dropfolders', 'dfTranserStart',  [formatDate(file.importStartedAt)] );
			str += '\n' + rm.getString('dropfolders', 'dfTransferEnd',  [formatDate(file.importEndedAt)] );
			return str;
		}
		
		/**
		 * Create suitable string to display in the "Created at" column
		 * */
		public static function dateCreatedLabelFunc(item:Object, column:DataGridColumn): String {
			var curFile:KalturaDropFolderFile = item as KalturaDropFolderFile;
			return formatDate(curFile.createdAt);
		}
		
		
		/**
		 * Create suitable string to display in the "File Size" column
		 * */
		public static function fileSizeLabelFunc(item:Object, column:DataGridColumn): String {
			var curFile:KalturaDropFolderFile = item as KalturaDropFolderFile;
			if (curFile.fileSize==int.MIN_VALUE)
				return '';
			return ((curFile.fileSize/MB_MULTIPLIER).toFixed(DIGITS_AFTER_DEC_POINT)) + ' ' + ResourceManager.getInstance().getString('dropfolders','megaBytes');
			
		}
		
		
		/**
		 * creates the string to show as tooltip for "status" column
		 * */
		public static function getStatusInfo(item:Object):String {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var file:KalturaDropFolderFile = item as KalturaDropFolderFile;
			var str:String = file.status.toString();	// original value as default
			switch (file.status) {
				case KalturaDropFolderFileStatus.UPLOADING:
					str = resourceManager.getString('dropfolders','transferringDesc');
					break;
				case KalturaDropFolderFileStatus.DOWNLOADING:
					str = resourceManager.getString('dropfolders','downloadingDesc');
					break;
				case KalturaDropFolderFileStatus.PENDING:
					str = resourceManager.getString('dropfolders','pendingDesc');
					break;
				case KalturaDropFolderFileStatus.PROCESSING:
					str = resourceManager.getString('dropfolders','processingDesc');
					break;
				case KalturaDropFolderFileStatus.PARSED:
					str = resourceManager.getString('dropfolders','parsedDesc');
					break;
				case KalturaDropFolderFileStatus.WAITING:
					str = resourceManager.getString('dropfolders','waitingDesc');
					break;
				case KalturaDropFolderFileStatus.NO_MATCH:
					str = resourceManager.getString('dropfolders','noMatchDesc');
					break;
				case KalturaDropFolderFileStatus.ERROR_HANDLING:
					str = resourceManager.getString('dropfolders','errHandlingDesc');
					break;
				case KalturaDropFolderFileStatus.ERROR_DELETING:
					str = resourceManager.getString('dropfolders','errDeletingDesc');
					break;
				case KalturaDropFolderFileStatus.HANDLED:
					str = resourceManager.getString('dropfolders','handledDesc');
					break;
				case KalturaDropFolderFileStatus.ERROR_DOWNLOADING:
					str = resourceManager.getString('dropfolders','errDnldDesc');
					break;
			}
			return str;
		}
		
		
		/**
		 * Create suitable string to display in the "Status" column
		 * */
		public static function statusLabelFunc(item:Object, column:DataGridColumn): String {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var curFile:KalturaDropFolderFile = item as KalturaDropFolderFile;
			switch (curFile.status) {
				case KalturaDropFolderFileStatus.UPLOADING:
					return resourceManager.getString('dropfolders','transferringBtn');
				case KalturaDropFolderFileStatus.DOWNLOADING:
					return resourceManager.getString('dropfolders','downloadingBtn');
				case KalturaDropFolderFileStatus.PENDING:
					return resourceManager.getString('dropfolders','pendingBtn');
				case KalturaDropFolderFileStatus.PROCESSING:
					return resourceManager.getString('dropfolders','processingBtn');
				case KalturaDropFolderFileStatus.PARSED:
					return resourceManager.getString('dropfolders','parsedBtn');
				case KalturaDropFolderFileStatus.WAITING:
					return resourceManager.getString('dropfolders','waitingBtn');
				case KalturaDropFolderFileStatus.NO_MATCH:
					return resourceManager.getString('dropfolders','noMatchBtn');
				case KalturaDropFolderFileStatus.ERROR_HANDLING:
					return resourceManager.getString('dropfolders','errHandlingBtn');
				case KalturaDropFolderFileStatus.ERROR_DELETING:
					return resourceManager.getString('dropfolders','errDeletingBtn');
				case KalturaDropFolderFileStatus.HANDLED:
					return resourceManager.getString('dropfolders','handledBtn');
				case KalturaDropFolderFileStatus.ERROR_DOWNLOADING:
					return resourceManager.getString('dropfolders','errDnldBtn');
			}
			return '';
		}
		
		
		/**
		 * Create suitable string to display in the "error desctiption" column
		 * */
		public static function getErrorDescription(item:Object) : String {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var file:KalturaDropFolderFile = item as KalturaDropFolderFile;
			var err:String = file.errorDescription;	// keep server string as default description
			
			switch (file.errorCode) {
				case KalturaDropFolderFileErrorCode.ERROR_ADDING_BULK_UPLOAD :
					err = resourceManager.getString('dropfolders','dfErrAddBulk');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_IN_BULK_UPLOAD :
					err = resourceManager.getString('dropfolders','dfErrBulkUpload');
					break;
//				case KalturaDropFolderFileErrorCode.ERROR_WRITING_TEMP_FILE :
//				case KalturaDropFolderFileErrorCode.LOCAL_FILE_WRONG_CHECKSUM :
//				case KalturaDropFolderFileErrorCode.LOCAL_FILE_WRONG_SIZE :
//					// not supposed to happen
//					break;
				case KalturaDropFolderFileErrorCode.ERROR_UPDATE_ENTRY : 
					err = resourceManager.getString('dropfolders','dfErrUpdateEntry');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_ADD_ENTRY : 
					err = resourceManager.getString('dropfolders','dfErrAddEntry');
					break;
				case KalturaDropFolderFileErrorCode.FLAVOR_NOT_FOUND : 
					err = resourceManager.getString('dropfolders','dfErrFlavorNotFound', [file.parsedFlavor]);
					break;
				case KalturaDropFolderFileErrorCode.FLAVOR_MISSING_IN_FILE_NAME : 
					err = resourceManager.getString('dropfolders','dfErrFlavorMissingInFile');
					break;
				case KalturaDropFolderFileErrorCode.SLUG_REGEX_NO_MATCH : 
					err = resourceManager.getString('dropfolders','dfErrSlugRegex');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_READING_FILE :
					err = resourceManager.getString('dropfolders','dfErrReadFile');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_DOWNLOADING_FILE :
					err = resourceManager.getString('dropfolders','dfErrDnldFile');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_UPDATE_FILE :
					err = resourceManager.getString('dropfolders','dfErrUpdateFile');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_ADD_CONTENT_RESOURCE :
					err = resourceManager.getString('dropfolders','dfErrAddResource');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_ADDING_CONTENT_PROCESSOR :
					err = resourceManager.getString('dropfolders','dfErrAddProc');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_IN_CONTENT_PROCESSOR :
					err = resourceManager.getString('dropfolders','dfErrProc');
					break;
				case KalturaDropFolderFileErrorCode.ERROR_DELETING_FILE :
					err = resourceManager.getString('dropfolders','dfErrDelFile');
					break;
				case KalturaDropFolderFileErrorCode.MALFORMED_XML_FILE :
					err = resourceManager.getString('dropfolders','dfErrMalformXml');
					break;
				case KalturaDropFolderFileErrorCode.XML_FILE_SIZE_EXCEED_LIMIT :
					err = resourceManager.getString('dropfolders','dfErrXmlSize');
					break;
					
			}
			
			return err;
		}
	}
}