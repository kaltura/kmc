package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.vo.ListableVo;

	public class SetListableEvent extends CairngormEvent
	{
		public static const SET_NEW_LIST_TO_MODEL:String ="content_setNewListToModel"; 
		
		private var _listableVo:ListableVo;
		
		public function SetListableEvent(type:String , listableVo:ListableVo, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_listableVo = listableVo;
		}

		public function get listableVo():ListableVo
		{
			return _listableVo;
		}

	}
}