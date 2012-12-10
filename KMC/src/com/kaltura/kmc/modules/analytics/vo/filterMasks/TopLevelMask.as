package com.kaltura.kmc.modules.analytics.vo.filterMasks {
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;

	public class TopLevelMask extends BaseMask {



		public function TopLevelMask(filterVo:FilterVo) {
			super(filterVo);
		}
		

		override public function get interval():String {
			return null;
		}

		override public function set interval(value:String):void {
			throw new Error("trying to set invalid value on filter: interval");
			_filterVo.interval = null;
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

		override public function get playbackContext():String {
			return null;
		}
		
		override public function set playbackContext(value:String):void {
			throw new Error("trying to set invalid value on filter: playbackContext");
			_filterVo.playbackContext = value;
		}

	}
}
