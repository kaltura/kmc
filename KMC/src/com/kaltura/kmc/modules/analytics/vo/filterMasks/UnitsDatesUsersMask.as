package com.kaltura.kmc.modules.analytics.vo.filterMasks
{
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	public class UnitsDatesUsersMask extends BaseMask
	{
		
		public function UnitsDatesUsersMask(filterVo:FilterVo) {
			super(filterVo);
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
		
		
	}
}