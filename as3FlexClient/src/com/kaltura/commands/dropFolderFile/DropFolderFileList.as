package com.kaltura.commands.dropFolderFile
{
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.delegates.dropFolderFile.DropFolderFileListDelegate;
	import com.kaltura.net.KalturaCall;

	public class DropFolderFileList extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param filter KalturaDropFolderFileFilter
		 * @param pager KalturaFilterPager
		 **/
		public function DropFolderFileList( filter : KalturaDropFolderFileFilter=null,pager : KalturaFilterPager=null )
		{
			if(filter== null)filter= new KalturaDropFolderFileFilter();
			if(pager== null)pager= new KalturaFilterPager();
			service= 'dropfolder_dropfolderfile';
			action= 'list';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			keyValArr = kalturaObject2Arrays(filter, 'filter');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
 			keyValArr = kalturaObject2Arrays(pager, 'pager');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new DropFolderFileListDelegate( this , config );
		}
	}
}
