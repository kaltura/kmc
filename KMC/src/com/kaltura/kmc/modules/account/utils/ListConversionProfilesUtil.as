package com.kaltura.kmc.modules.account.utils
{
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfile;
	
	import mx.collections.ArrayCollection;

	public class ListConversionProfilesUtil
	{
		
		private static var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		public static function handleConversionProfilesList(arr:Array):void {
			var tempArrCol:ArrayCollection = new ArrayCollection();
			
			for each(var cProfile:KalturaConversionProfile in arr)
			{
				var cp:ConversionProfileVO = new ConversionProfileVO();
				cp.profile = cProfile;
				if(cp.profile.isDefault)
				{
					tempArrCol.addItemAt(cp, 0);
				}
				else
				{
					tempArrCol.addItem(cp);
				}
			}
			
			_model.conversionData = tempArrCol;
		}
	}
}