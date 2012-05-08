package com.kaltura.kmc.modules.content.business
{
	import com.kaltura.kmc.modules.content.events.CatTrackEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	/**
	 * samples the server to see what is the current update status of categories
	 * and set the locked / updating flags on filterModel accordingly 
	 * @author atar.shadmi
	 */
	public class CategoriesStatusTracker {
		
		/**
		 * the timer used to time samples 
		 */		
		private var _timer:Timer;
		
		private var _sampleRate:int;
		
		/**
		 * sample rate in ms
		 */		
		public function set sampleRate(value:int):void {
			_sampleRate = value;
			startTracking();
		}
		
		
		/**
		 * activate the timer 
		 */		
		private function startTracking():void {
			if (_timer) {
				_timer.stop();
				_timer.delay = _sampleRate;
			}
			else {
				_timer = new Timer(_sampleRate);
				_timer.addEventListener(TimerEvent.TIMER, handleTick, false, 0, true);
			}
			
			_timer.start();
			setTimeout(handleTick, 0, null);
		}
		
		
		/**
		 * sample server 
		 */		
		private function handleTick(e:TimerEvent):void {
			var cgEvent:CatTrackEvent = new CatTrackEvent(CatTrackEvent.UPDATE_STATUS);
			cgEvent.dispatch();
		}
	}
}