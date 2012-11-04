package com.kaltura.kmc.modules.analytics.vo.filterMasks
{
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	import mx.events.PropertyChangeEvent;
	
	/**
	 * Base class for all analytics filter masks. <br>
	 * all reports get the same filterVo instance, but each report gets it through a mask
	 * which only allows editing certain attributes, accoring to the report in question. <br>
	 * trying to set other attributes causes an error to be thrown.
	 * 
	 * @see  com.kaltura.kmc.modules.analytics.vo.FilterVo
	 * @author atar.shadmi
	 * 
	 */
	public class BaseMask extends FilterVo
	{
		
		/**
		 * the wrapped filter vo
		 */
		protected var _filterVo:FilterVo;
		
		public function BaseMask(filterVo:FilterVo)
		{
			super();
			_filterVo = filterVo;
			filterVo.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropChanged, false, 0, true);
		}
		
		
		protected function onPropChanged(event:PropertyChangeEvent):void {
			dispatchEvent(event.clone());
		}
		
		
		/**
		 * days / months
		 * @see com.kaltura.types.KalturaReportInterval
		 */
		override public function get interval():String {
			return _filterVo.interval;
		}
		
		
		/**
		 * @private
		 */
		override public function set interval(value:String):void {
			_filterVo.interval = value;
		}
		
		
		/**
		 * comma-seperated string of user ids
		 */
		override public function get userIds():String {
			return _filterVo.userIds;
		}
		
		
		/**
		 * @private
		 */
		override public function set userIds(value:String):void {
			_filterVo.userIds = value;
		}
		
		
		override public function get application():String {
			return _filterVo.application;
		}
		
		
		override public function set application(value:String):void {
			_filterVo.application = value;
		}
		
		
		override public function get keywords():String {
			return _filterVo.keywords;
		}
		
		
		override public function set keywords(value:String):void {
			_filterVo.keywords = value;
		}
		
		
		/**
		 * comma-separated list of categories full-names.
		 *
		 * @internal
		 * when getting report, the command switches between categories and playbackContext according to required report
		 */
		override public function get categories():String {
			return _filterVo.categories;
		}
		
		
		/**
		 * @private
		 */
		override public function set categories(value:String):void {
			_filterVo.categories = value;
		}
		
		
		override public function get toDate():Date {
			return _filterVo.toDate;
		}
		
		
		override public function set toDate(value:Date):void {
			_filterVo.toDate = value;
		}
		
		
		override public function get fromDate():Date {
			return _filterVo.fromDate;
		}
		
		
		override public function set fromDate(value:Date):void {
			_filterVo.fromDate = value;
		}
		
		
		override public function get selectedDate():String {
			return _filterVo.selectedDate;
		}
		
		
		override public function set selectedDate(value:String):void {
			_filterVo.selectedDate = value;
		}

	}
}