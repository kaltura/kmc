package com.kaltura.commands.storageProfile
{
	import com.kaltura.vo.KalturaPartnerFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.delegates.storageProfile.StorageProfileListByPartnerDelegate;
	import com.kaltura.net.KalturaCall;

	public class StorageProfileListByPartner extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param filter KalturaPartnerFilter
		 * @param pager KalturaFilterPager
		 **/
		public function StorageProfileListByPartner( filter : KalturaPartnerFilter=null,pager : KalturaFilterPager=null )
		{
			service= 'storageprofile_storageprofile';
			action= 'listByPartner';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			if (filter) { 
	 			keyValArr = kalturaObject2Arrays(filter, 'filter');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
 			} 
 			if (pager) { 
	 			keyValArr = kalturaObject2Arrays(pager, 'pager');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
 			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new StorageProfileListByPartnerDelegate( this , config );
		}
	}
}
