package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.business.ListPartnerPackagesDelegate;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.vo.PackagesVO;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListPartnerPackagesCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			
			var params : Object = _model.context.defaultUrlVars;
			var delegate : ListPartnerPackagesDelegate = new ListPartnerPackagesDelegate( this );
			delegate.listPartnerPackages( params );	
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			if(data is Array)
			{
				for( var i:int=0 ; i<(data as Array).length ; i++ )
				{
					if(((data as Array)[i] as PackagesVO).pId == _model.partnerData.partnerPackage.toString())
					{
						_model.partnerPackage = (data as Array)[i];
					}
				} 
				
				_model.listPackages = new ArrayCollection(data as Array);
			}
		}
		
		public function fault(info:Object):void
		{			
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('kmc', 'error'));
		}
		
	}
}