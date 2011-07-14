package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;

	public class RemoveReportCommand implements ICommand {
		
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var i:int;
			// users
			for (i = 0; i<_model.userDtnDp.length; i++) {
				if (_model.userDtnDp[i] == event.data) {
					_model.userDtnDp.removeItemAt(i);
					_model.userDtnDp.refresh();
					return;
				}
			}
			// content
			for (i = 0; i<_model.contentDtnDp.length; i++) {
				if (_model.contentDtnDp[i] == event.data) {
					_model.contentDtnDp.removeItemAt(i);
					_model.contentDtnDp.refresh();
					return;
				}
			}
		}
	}
}