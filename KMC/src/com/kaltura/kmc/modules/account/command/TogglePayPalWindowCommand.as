package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.events.ModalWindowEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.model.states.WindowsStates;
	import com.kaltura.kmc.modules.account.vo.PackagesVO;
	
	public class TogglePayPalWindowCommand implements ICommand
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var e : ModalWindowEvent = event as ModalWindowEvent;
			if( e.openWin )
			{
				_model.modalWinData = e.data;
				_model.windowState = e.windowState;
				_model.paymentDetailsVo.packageId = (e.data as PackagesVO).pId;
				_model.openPayPalWindowFlag = true;
				
				if( (e.data as PackagesVO).cycleFee > _model.partnerPackage.cycleFee )
					_model.gaTrackUrl = "kmc/account/packages/open_upgrade/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;
				else if( (e.data as PackagesVO).cycleFee < _model.partnerPackage.cycleFee )
					_model.gaTrackUrl = "kmc/account/packages/open_downgrade/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;
				else
					_model.gaTrackUrl = "kmc/account/packages/open_update_billing_info/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;		
			}
			else
			{
				_model.openPayPalWindowFlag = false;
				_model.modalWinData = null;
				_model.windowState = WindowsStates.NONE;
				
				if(e.data)
				{
					if( (e.data as PackagesVO).cycleFee > _model.partnerPackage.cycleFee )
						_model.gaTrackUrl = "kmc/account/packages/close_upgrade/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;
					else if( (e.data as PackagesVO).cycleFee < _model.partnerPackage.cycleFee )
						_model.gaTrackUrl = "kmc/account/packages/close_downgrade/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;
					else
						_model.gaTrackUrl = "kmc/account/packages/close_update_billing_info/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;
				}
			}
		}
	}
}