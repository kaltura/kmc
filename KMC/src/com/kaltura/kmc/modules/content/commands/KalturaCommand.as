package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.view.window.ForbidenBox;

	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;

	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class KalturaCommand implements ICommand, IResponder {
		protected var _model:CmsModelLocator = CmsModelLocator.getInstance();


		/**
		 * @inheritDocs
		 */
		public function fault(info:Object):void {
			_model.decreaseLoadCounter();
			if (info && info.error && info.error.errorMsg &&
				info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				ExternalInterface.call("kmc.functions.expired");
			}
			else if (info && info.error && info.error.errorCode &&
				info.error.errorCode.toString() == "SERVICE_FORBIDDEN") {
				// added the support of non closable window
				var forbiddenBox:ForbidenBox = new ForbidenBox();
				//de-activate the HTML tabs
				ExternalInterface.call("kmc.utils.activateHeader", false);
				PopUpManager.addPopUp(forbiddenBox, (_model.app as DisplayObject), true);
				PopUpManager.centerPopUp(forbiddenBox);
			}
			else if (info && info.error && info.error.errorMsg) {
				var alert:Alert = Alert.show(info.error.errorMsg,
											 ResourceManager.getInstance().getString('cms', 'error'),
											 Alert.OK, null, refrehOnClose);
			}
		}


		/**
		 * default implementation for result.
		 * check if call response is data or error, respond to error.
		 * when overriding this method you should always call
		 * <code>super.result(data)</code> first.
		 * @param data data returned from server.
		 *
		 */
		public function result(data:Object):void {
			if (data.error && data.error.code == "INVALID_KS") {
				// redirect to login, or whatever JS does with invalid KS.
				ExternalInterface.call("kmc.functions.expired");
			}
		}


		/**
		 * @inheritDocs
		 */
		public function execute(event:CairngormEvent):void {
			throw new Error("execute() must be implemented");
		}


		protected function refrehOnClose(event:CloseEvent):void {
			ExternalInterface.call("refreshSWF");
		}
	}
}