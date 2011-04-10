package com.kaltura.commands.dropFolder
{
	import com.kaltura.vo.KalturaDropFolderFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.delegates.dropFolder.DropFolderListDelegate;
	import com.kaltura.net.KalturaCall;

	public class DropFolderList extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param filter KalturaDropFolderFilter
		 * @param pager KalturaFilterPager
		 **/
		public function DropFolderList( filter : KalturaDropFolderFilter=null,pager : KalturaFilterPager=null )
		{
			if(filter== null)filter= new KalturaDropFolderFilter();
			if(pager== null)pager= new KalturaFilterPager();
			service= 'dropfolder_dropfolder';
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
			delegate = new DropFolderListDelegate( this , config );
		}
	}
}
