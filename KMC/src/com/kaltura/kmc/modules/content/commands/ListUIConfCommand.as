package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.UIConfEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.uiConf.UiConfList;
	import com.kaltura.commands.uiConf.UiConfListTemplates;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaUiConf;
	import com.kaltura.vo.KalturaUiConfFilter;
	import com.kaltura.vo.KalturaUiConfListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListUIConfCommand extends KalturaCommand implements ICommand,IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			
		 /* 	getListUIConfs.addEventListener(KalturaEvent.COMPLETE, result);
			getListUIConfs.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListUIConfs);	  */
			
			var mr:MultiRequest = new MultiRequest();
			
			var getUIConfTemplates:UiConfListTemplates = new UiConfListTemplates();
			mr.addAction(getUIConfTemplates);
			
			var filter:KalturaUiConfFilter = (event as UIConfEvent).uiConfFilter;
			var getListUIConfs:UiConfList = new UiConfList(filter);
			mr.addAction(getListUIConfs);
		
	        mr.addEventListener(KalturaEvent.COMPLETE, result);
            mr.addEventListener(KalturaEvent.FAILED, fault);
            _model.context.kc.post(mr); 
	
		}
		
		override public function result(event:Object):void
		{ 
			super.result(event);
			var uiConf:KalturaUiConf;
			
			if(event.error != null)
			{
				Alert.show(ResourceManager.getInstance().getString('cms', 'playersListErrorMsg'), ResourceManager.getInstance().getString('cms', 'error'));
			}
			
			var tempArr:ArrayCollection = new ArrayCollection();
			var response1:KalturaUiConfListResponse = event.data[0] as KalturaUiConfListResponse;
			for each(var uiconf:KalturaUiConf in response1.objects)
			{
				if(uiconf.name.toLocaleLowerCase() == "dark player")
				{
					tempArr.addItemAt(uiconf, 0);
				}
				else
				{
					tempArr.addItem(uiconf);
				}
			}
			
			
			var response2:KalturaUiConfListResponse = event.data[1] as KalturaUiConfListResponse;
			
			for each(var uiconf2:KalturaUiConf in response2.objects)
			{
				uiconf2.name = ((uiconf2.name == null) || (uiconf2.name == '')) ? "Player(" + uiconf2.id + ")" : uiconf2.name;
				tempArr.addItem(uiconf2);
				//trace(uiconf2.objType + ":" + uiconf2.name); 
			}
			_model.extSynModel.uiConfData = tempArr;
			_model.decreaseLoadCounter();
		}
		
		override public function fault(event:Object):void
		{
			_model.decreaseLoadCounter();
			Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
		}

	}
}