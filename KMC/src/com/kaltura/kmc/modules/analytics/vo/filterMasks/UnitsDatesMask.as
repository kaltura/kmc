package com.kaltura.kmc.modules.analytics.vo.filterMasks
{
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	public class UnitsDatesMask extends BaseMask
	{
		
		
		
		public function UnitsDatesMask(filterVo:FilterVo) {
			super(filterVo);
		}
		
		
		override public function get userIds():String {
			return null;
		}
		
		override public function set userIds(value:String):void {
			throw new Error("trying to set invalid value on filter: userIds");
			_filterVo.userIds = null;
		}
		
		
		override public function get application():String {
			return null;
		}
		
		override public function set application(value:String):void {
			throw new Error("trying to set invalid value on filter: application");
			_filterVo.application = null;
		}
		
		
		override public function get keywords():String {
			return null;
		}
		
		override public function set keywords(value:String):void {
			throw new Error("trying to set invalid value on filter: keywords");
			_filterVo.keywords = null;
		}
		
		
		override public function get categories():String {
			return null;
		}
		
		override public function set categories(value:String):void {
			throw new Error("trying to set invalid value on filter: categories");
			_filterVo.categories = null;
		}
		
		override public function get playbackContext():String {
			return null;
		}
		
		override public function set playbackContext(value:String):void {
			throw new Error("trying to set invalid value on filter: playbackContext");
			_filterVo.playbackContext = value;
		}
		
		
	}
}