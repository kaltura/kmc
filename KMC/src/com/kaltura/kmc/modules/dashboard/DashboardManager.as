package com.kaltura.kmc.modules.dashboard {
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.partner.PartnerGetInfo;
	import com.kaltura.commands.partner.PartnerGetStatistics;
	import com.kaltura.commands.partner.PartnerGetUsage;
	import com.kaltura.commands.report.ReportGetGraphs;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.events.KmcNavigationEvent;
	import com.kaltura.kmc.modules.KmcModule;
	import com.kaltura.vo.KalturaPartner;
	import com.kaltura.vo.KalturaPartnerStatistics;
	import com.kaltura.vo.KalturaPartnerUsage;
	import com.kaltura.vo.KalturaReportGraph;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;

	/**
	 * A singlton class - this class manages the behavior of the controlers and uses as cashe for the server's data
	 * In the first phase of the dashboard this class does it all, later on we will split it to
	 */
	public class DashboardManager extends EventDispatcher {
		public const KALTURA_OFFSET:Number = 21600; //(6 hours * 60 min * 60 sec = 21600)

		///it is set to 30 DAYS just to get some data
		public const SECONDES_IN_30_DAYS:Number = 30 * 24 * 60 * 60; // 7d x 24h x 60m x 60s

		public const TODAY_DATE:Date = new Date();
		public const DATE_30_DAYS_AGO:Date = new Date(new Date().time - (SECONDES_IN_30_DAYS * 1000));

		/** single instanse for this class **/
		private static var _instance:DashboardManager;

		/** kaltura client object - for contacting the server **/
		private var _kc:KalturaClient; //kaltura client that make all kaltura API calls
		public var app:KmcModule;
		
		[Bindable]
		public var showGraphs : Boolean = true;

		/** map for the graphs data **/
		private var dimMap:HashMap = new HashMap();

		/** the selected graph data in a format of ArrayCollection {(X1,Y1), ... , (Xn,Yn)}  **/
		[Bindable]
		private var _selectedDim:ArrayCollection = new ArrayCollection();

		[Bindable]
		public var totalBWSoFar:String = '0';
		[Bindable]
		public var totalPercentSoFar:String = '0';
		[Bindable]
		public var hostingGB:String = '0';
		[Bindable]
		public var partnerPackage:String = '0';
		
		[Bindable]
		/**
		 * publisher name for welcome message
		 * */
		public var publisherName:String;


		public function get kc():KalturaClient {
			return _kc;
		}


		public function set kc(kC:KalturaClient):void {
			_kc = kC;
		}


		/**
		 * Singlton pattern call for this class instance
		 *
		 */
		public static function get instance():DashboardManager {
			if (_instance == null) {
				_instance = new DashboardManager(new Enforcer());
			}

			return _instance;
		}


		/**
		 * Constracture - for a singlton - enforcer class can't be reached outside this class
		 *
		 */
		public function DashboardManager(enforcer:Enforcer, target:IEventDispatcher = null) {
			super(target);
		}


		[Bindable]
		public function get selectedDim():ArrayCollection {
			return _selectedDim;
		}


		public function set selectedDim(selectedDim:ArrayCollection):void {
			_selectedDim = selectedDim;
		}


		/**
		 * Data Calling from the servers
		 *
		 */
		public function getData():void {
			if (showGraphs)
			{
				getGraphData();
			}
			getUsageData();
			getPartnerData();
		}
		
		
		private function getPartnerData():void {
			var getPartnerInfo:PartnerGetInfo = new PartnerGetInfo();
			getPartnerInfo.addEventListener(KalturaEvent.COMPLETE, onPartnerInfo);
			getPartnerInfo.addEventListener(KalturaEvent.FAILED, fault);
			kc.post(getPartnerInfo);	
		}

		
		private function onPartnerInfo(ke:KalturaEvent):void {
			publisherName = (ke.data as KalturaPartner).name;
		}
		

		/**
		 * Calling for the Account usage data from the server
		 *
		 *
		 */
		private function getUsageData():void {
			var now:Date = new Date();
			new KalturaPartnerUsage();
//			var getPartnerUsage:PartnerGetUsage = new PartnerGetUsage(int.MIN_VALUE, int.MIN_VALUE, null);
//			getPartnerUsage.addEventListener(KalturaEvent.COMPLETE, onSrvRes);
//			getPartnerUsage.addEventListener(KalturaEvent.FAILED, onSrvFlt);
//			kc.post(getPartnerUsage);
			var partnerGetStatistics:PartnerGetStatistics = new PartnerGetStatistics();
			partnerGetStatistics.addEventListener(KalturaEvent.COMPLETE, onPartnerStatistics);
			partnerGetStatistics.addEventListener(KalturaEvent.FAILED, fault);
			kc.post(partnerGetStatistics);	
		}
		
		protected function onPartnerStatistics(result:Object):void
		{
			var statistics:KalturaPartnerStatistics = result.data as KalturaPartnerStatistics;
			totalBWSoFar = statistics.bandwidth.toFixed(2);
			totalPercentSoFar = statistics.usagePercent.toFixed();
			hostingGB = statistics.hosting.toFixed(2);
			partnerPackage = statistics.packageBandwidthAndStorage.toFixed();
		}


		/**
		 * In case the usage data call has errors
		 */
		private function onSrvFlt(fault:Object):void {
			Alert.show(ResourceManager.getInstance().getString('kdashboard', 'usageErrorMsg') + ":\n" + fault.error.errorMsg, ResourceManager.getInstance().getString('kdashboard', 'error'));
		}


		/**
		 * Usage data call result, updates the propare vars
		 *
		 *
		 */
		private function onSrvRes(result:Object):void {
			totalBWSoFar = result.data.usageGB;
			totalPercentSoFar = result.data.Percent;
			hostingGB = result.data.hostingGB;
		}


		/**
		 * Calling for the graph's data from the server
		 */
		private function getGraphData():void {
			var ONE_DAY:int = 1000 * 60 * 60 * 24;
			// server needs date in seconds, UTC
			var today:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((today.hoursUTC) * 60 + today.minutesUTC) * 60 + today.secondsUTC) * 1000 + today.millisecondsUTC;
			var toDate:Date = new Date(today.time - todaysHourInMiliSeconds - ONE_DAY);
			var fromDate:Date = new Date(today.time - todaysHourInMiliSeconds - 31 * ONE_DAY);

			var krif:KalturaReportInputFilter = new KalturaReportInputFilter();
			krif.toDate = Math.ceil(toDate.time / 1000);
			krif.fromDate = Math.ceil(fromDate.time / 1000);
			krif.timeZoneOffset = new Date().timezoneOffset;

			var reportGetGraphs:ReportGetGraphs = new ReportGetGraphs(1, krif, 'sum_time_viewed'); //  sum_time_viewed count_plays

			reportGetGraphs.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetGraphs.addEventListener(KalturaEvent.FAILED, fault);
			kc.post(reportGetGraphs);
		}


		/**
		 * The result for the graph's data. Preparing the data as need for the graphs.
		 * Saving it in a map, for easy navigation between the graphs.
		 *
		 */
		private function result(result:Object):void {
			var krpArr:Array = result.data as Array;

			for (var i:int = 0; i < krpArr.length; i++) {
				var krp:KalturaReportGraph = KalturaReportGraph(krpArr[i]);
				var pointsArr:Array = krp.data.split(";");
				var graphPoints:ArrayCollection = new ArrayCollection();

				for (var j:int = 0; j < pointsArr.length; j++) {
					if (pointsArr[j]) {
						var xYArr:Array = pointsArr[j].split(",");
						var year:String = String(xYArr[0]).substring(0, 4);
						var month:String = String(xYArr[0]).substring(4, 6);
						var date:String = String(xYArr[0]).substring(6, 8);
						var newDate:Date = new Date(Number(year), Number(month) - 1, Number(date));
						var timestamp:Number = newDate.time;
						graphPoints.addItem({x: timestamp, y: xYArr[1]});
					}
				}

				dimMap.put(krp.id, graphPoints);
			}

			// set the first AC as the defualt for the graph
			selectedDim = dimMap.getValue('count_plays');
		}


		public function updateSelectedDim(dimCode:String):void {
			selectedDim = dimMap.getValue(dimCode) != null ? dimMap.getValue(dimCode) : new ArrayCollection();
		}


		/**
		 * In case of fault when calling the graph's data
		 * @param info
		 *
		 */
		private function fault(info:Object):void {
			if ((info as KalturaEvent).error) {
				if (info.error.errorCode == APIErrorCode.INVALID_KS) {
					JSGate.expired();
				}
				else if (info.error.errorCode == APIErrorCode.SERVICE_FORBIDDEN) {
					// added the support of non closable window
					
					Alert.show(ResourceManager.getInstance().getString('common', 'forbiddenError'), 
						ResourceManager.getInstance().getString('kdashboard', 'error'), Alert.OK, null, logout);
					//de-activate the HTML tabs
//					ExternalInterface.call("kmc.utils.activateHeader", false);
				}
				else if((info as KalturaEvent).error.errorMsg) {
					Alert.show((info as KalturaEvent).error.errorMsg, ResourceManager.getInstance().getString('kdashboard', 'error'));
				}
			}
		}

		protected function logout(e:Object):void {
			JSGate.expired();
		}


		/**
		 * launch the links by clicking on the linkbuttons in the dashboard application
		 * 
		 * @param linkCode
		 * @param pageNum
		 * 
		 */
		public function launchOuterLink(linkCode:String, pageNum:String=null):void
		{
			var linkStr:String = ResourceManager.getInstance().getString('kdashboard', linkCode);
			linkStr += pageNum ? ('#page=' + pageNum) : '';
			var urlr:URLRequest = new URLRequest(linkStr);
			navigateToURL(urlr, "_blank");
		}

		/**
		 * open a new page with the given url
		 * @param url 	address to open
		 */
		public function launchExactOuterLink(url:String):void {
			var urlr:URLRequest = new URLRequest(url);
			navigateToURL(urlr, "_blank");
		}


		/**
		 * Loading a outer module by calling JS function and the html wrapper of this SWF application
		 */
		public function loadKMCModule(moduleName:String, subModule:String = ''):void {
			dispatchEvent(new KmcNavigationEvent(KmcNavigationEvent.NAVIGATE, moduleName, subModule));
		}

	}
}

class Enforcer {

}