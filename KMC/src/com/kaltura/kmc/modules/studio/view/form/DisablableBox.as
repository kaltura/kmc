package com.kaltura.kmc.modules.studio.view.form
{
	import flash.display.DisplayObject;
	
	import mx.containers.Box;
	import mx.core.Container;
	import mx.core.UIComponent;
	
	/**
	 * when this box is disabled it disables all its children recoursively
	 * (instead of showing its content grayed out). 
	 * @author Atar
	 */	
	public class DisablableBox extends Box {
		
		public function DisablableBox()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function set enabled(value:Boolean):void {
			super.enabled = true;
			enableHelper(value, this);
		}
		
		private function enableHelper(value:Boolean, container:Container):void {
			var nChildren:int = container.numChildren;
			var child:DisplayObject; 
			for (var i:int = 0; i<nChildren; i++) {
				child = container.getChildAt(i);
				if (child is UIComponent) {
					if (child is Container) {
						enableHelper(value, child as Container);
					}
					else {
						child["enabled"] = value;
					}
				}
			}
		}
	}
}