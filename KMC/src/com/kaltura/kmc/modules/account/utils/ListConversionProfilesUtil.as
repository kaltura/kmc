package com.kaltura.kmc.modules.account.utils
{
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfile;
	
	import mx.collections.ArrayCollection;

	/**
	 * This util class will contain methods related to listConversionProfiles request 
	 * @author Michal
	 * 
	 */	
	public class ListConversionProfilesUtil
	{
		
		private static var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		/**
		 * Sets the given list on the model, set the default conversion profile first in list 
		 * @param arr the new list to set on the model
		 * 
		 */		
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