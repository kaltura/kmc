package com.kaltura.containers
{
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	import mx.core.Application;
	import mx.events.FlexEvent;
	
	/**
	 * A TitleWindow that cannot be dragged off screen 
	 * @author atar.shadmi
	 * 
	 */	
	public class ConfinedTitleWindow extends TitleWindow
	{
		public function ConfinedTitleWindow()
		{
			super();
			addEventListener("move", doMove, false, 0, true);
		}
		
		
		/**
		 * keeps TW inside layout
		 * */
		private function doMove(event:Event):void { 
			var appW:Number = Application.application.width;
			var appH:Number = Application.application.height;
			if (this.x + this.width > appW) {
				this.x = appW - this.width;
			}
			if (this.x < 0) {
				this.x = 0;
			}
			if (this.y + this.height > appH) {
				this.y = appH - this.height;
			}
			if (this.y < 0) {
				this.y = 0;
			}
		}
	}
}