package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.RelatedFileVO;
	import com.kaltura.vo.KalturaAsset;

	public class ListRelatedFilesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			//TODO sent server call
			//dummy
			var tempArray:Array = new Array();
			for (var i:int = 0; i<3; i++) {
				var bla:RelatedFileVO  = new RelatedFileVO();
				bla.file = {name: 'bla', type: 'document', size: 100000, id: '1234'}
				tempArray.push(bla);
			}
			_model.entryDetailsModel.relatedFilesArray = tempArray;
			
		}
	}
}