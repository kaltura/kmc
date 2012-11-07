package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.DrillDownEvent;
	import com.kaltura.kmc.modules.analytics.control.StateEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;

	public class DrillDownCommand implements ICommand {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var getEntryFlag:Boolean = true;	// should we load a KalturaEntry
			_model.drillDownName = (event as DrillDownEvent).objectName;

			if ((event as DrillDownEvent).newScreen) {
				// got here from filter sub-navigation
				if (_model.currentScreenState == (event as DrillDownEvent).newScreen)
					return;

				_model.currentScreenState = (event as DrillDownEvent).newScreen;
			}
			else {
				// ktable events are dispatched with "0", so we get here.
				switch (_model.currentScreenState) {
					case ScreenTypes.TOP_CONTENT:
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;
						break;
					case ScreenTypes.CONTENT_DROPOFF:
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;

						break;
					case ScreenTypes.CONTENT_INTERACTIONS:
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;

						break;
					case ScreenTypes.CONTENT_CONTRIBUTIONS:
						getEntryFlag = false;
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;
						break;
					case ScreenTypes.MAP_OVERLAY:
						getEntryFlag = false;
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.MAP_OVERLAY_DRILL_DOWN;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;
						break;
					case ScreenTypes.TOP_SYNDICATIONS:
						getEntryFlag = false;
						_model.tableSupportDrillDown = false;
						_model.currentScreenState = ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN;
						_model.selectedEntry = (event as DrillDownEvent).subjectId;
						break;
					case ScreenTypes.END_USER_ENGAGEMENT:
						_model.tableSupportDrillDown = false;
						getEntryFlag = false;
						if (_model.entitlementEnabled)
							if ((event as DrillDownEvent).subjectId) {
								_model.filter.userIds = (event as DrillDownEvent).subjectId;
							}
						_model.currentScreenState = ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN;
						break;
					case ScreenTypes.END_USER_STORAGE:
						_model.tableSupportDrillDown = false;
						getEntryFlag = false;
						if (_model.entitlementEnabled)
							if ((event as DrillDownEvent).subjectId) {
								_model.filter.userIds = (event as DrillDownEvent).subjectId;
							}
						_model.currentScreenState = ScreenTypes.END_USER_STORAGE_DRILL_DOWN;
						break;
				}

			}

			_model.selectedReportData = null; //refresh
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState] = new ReportData();

			//get Entry
			if (getEntryFlag) {
				var getMediaEntry:DrillDownEvent = new DrillDownEvent(DrillDownEvent.GET_MEDIA_ENTRY, _model.selectedEntry);
				getMediaEntry.dispatch();
			}
		}
	}
}
