package com.kaltura.kmc.business {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.modules.ModuleLoader;

	/**
	 * this class is responsible for the visual aspecs of the add menu 
	 * (creating, showing, hiding and positioning..) 
	 * @author Atar
	 */	
	public class MenuHandler extends EventDispatcher {
		
		public static var MENU_REMOVED:String = "menu_removed";
		
		protected var _approot:DisplayObjectContainer;


		/**
		 * the menu panel 
		 */
		protected var _panel:IPopupMenu;

		/**
		 * @param panel 	the flex module to handle
		 * @param positionJsCallback	name of JS method that positions the panel
		 */
		public function MenuHandler(panel:IPopupMenu, positionJsCallback:String) {
			super(this);
			_panel = panel;
			ExternalInterface.addCallback(positionJsCallback, positionPanel);
		}
		
		public function setRoot(doc:DisplayObjectContainer):void {
			_approot = doc;
		}
		
		/**
		 * Position will be determined by triggering a JS function (via JSGate) – 
		 * getPanelPosition(). 
		 * Add a stage listener to hide the popup. 
		 */
		public function showPanel():void {
			if (!_panel.parent || _panel.parent is ModuleLoader){
				PopUpManager.addPopUp(_panel, _approot);
				positionPanel(JSGate.getPanelPosition());
				
				// add stage listener
				(Application.application as DisplayObjectContainer).addEventListener(MouseEvent.CLICK, _panel.hidePanel);
			}
		}
		
					
		/**
		 * Remove stage listener and hide the popup. 
		 */
		public function hidePanel(e:Event = null):void {
			if (_panel && _panel.parent && !(_panel.parent is ModuleLoader)) {
				PopUpManager.removePopUp(_panel);
				// remove stage listener
				(Application.application as DisplayObjectContainer).removeEventListener(MouseEvent.MOUSE_OVER, _panel.hidePanel);
				dispatchEvent(new Event(MENU_REMOVED));
			}
		}
		
		/**
		 * if the panel is visible hide it, if it is hidden show it
		 * */
		public function togglePanel():void {
			if (!_panel.parent || _panel.parent is ModuleLoader){
				_panel.showPanel();
			}
			else {
				_panel.hidePanel();
			}
		}
		
		/**
		 * An externalInterface method that will allow HTML to position the menu. 
		 * @param right
		 */
		public function positionPanel(right:Number):void {
			_panel.x = right - _panel.width;
			_panel.y = 0;
		}
		
	}
}