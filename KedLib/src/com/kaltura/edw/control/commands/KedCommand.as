package com.kaltura.edw.control.commands
{
	import com.kaltura.KalturaClient;
	import com.kaltura.edw.business.KedJSGate;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.commands.ICommand;
	import com.kaltura.kmvc.control.KMvCController;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.kmvc.model.KMvCModel;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class KedCommand implements ICommand, IResponder {
		/**
		 * allows saving a reference to the controller on which the event who
		 * triggered the command was dispatched, to allow dispatching future events.
		 * saving the reference is the developer's responsibility
		 * */
		protected var _dispatcher:KMvCController;
		
		/**
		 * application data model
		 * */
		protected var _model:KMvCModel = KMvCModel.getInstance();
		
		/**
		 * KalturaClient for making server calls
		 */		
		protected var _client:KalturaClient = (_model.getDataPack(ContextDataPack) as ContextDataPack).kc;
		
		/**
		 * @inheritDocs
		 */
		public function fault(info:Object):void {
			_model.decreaseLoadCounter();
			var er:KalturaError = (info as KalturaEvent).error;
			if (!er) return;
			if (er.errorCode == APIErrorCode.INVALID_KS) {
				KedJSGate.expired();
			}
			else if (er.errorCode == APIErrorCode.SERVICE_FORBIDDEN) {
				// added the support of non closable window
				Alert.show(ResourceManager.getInstance().getString('common','forbiddenError',[er.errorMsg]), 
					ResourceManager.getInstance().getString('common', 'forbiden_error_title'), Alert.OK, null, logout);
			}
			else if (er.errorMsg) {
				var alert:Alert = Alert.show(er.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
			}
		}
		
		protected function logout(e:Object):void {
			KedJSGate.expired();
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
			var er:KalturaError = (data as KalturaEvent).error;
			if (er && er.errorCode == APIErrorCode.INVALID_KS) {
				// redirect to login, or whatever JS does with invalid KS.
				KedJSGate.expired();
			}
		}
		
		
		/**
		 * @inheritDocs
		 */
		public function execute(event:KMvCEvent):void {
			throw new Error("execute() must be implemented");
		}
	}
}