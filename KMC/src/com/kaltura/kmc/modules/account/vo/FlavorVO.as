package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaFlavorParams;
	
	import flash.events.Event;
	
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class FlavorVO extends ObjectProxy implements IValueObject
	{
		public static const SELECTED_CHANGED_EVENT : String = "flavorSelectedChanged";
		
		private var _selected:Boolean = false;
		public var kFlavor:KalturaFlavorParams = new KalturaFlavorParams();
		
		/**
		 * should the line in the conversion settings table representing this item be editable
		 * */
		public var editable:Boolean = true;
				
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}
		
		public function clone():FlavorVO
		{
			var newFlavor:FlavorVO = new FlavorVO();
			
			newFlavor.selected = this.selected;
			newFlavor.kFlavor.name = this.kFlavor.name;
			newFlavor.kFlavor.audioBitrate = this.kFlavor.audioBitrate;
			newFlavor.kFlavor.audioCodec = this.kFlavor.audioCodec;
			newFlavor.kFlavor.conversionEngines = this.kFlavor.conversionEngines;
			newFlavor.kFlavor.conversionEnginesExtraParams = this.kFlavor.conversionEnginesExtraParams;
			newFlavor.kFlavor.createdAt = this.kFlavor.createdAt;
			newFlavor.kFlavor.description = this.kFlavor.description;
			newFlavor.kFlavor.format = this.kFlavor.format;
			newFlavor.kFlavor.frameRate = this.kFlavor.frameRate;
			newFlavor.kFlavor.gopSize = this.kFlavor.gopSize;
			newFlavor.kFlavor.height = this.kFlavor.height;
			newFlavor.kFlavor.id = this.kFlavor.id;
			newFlavor.kFlavor.partnerId = this.kFlavor.partnerId;
			newFlavor.kFlavor.tags = this.kFlavor.tags;
			newFlavor.kFlavor.videoBitrate = this.kFlavor.videoBitrate;
			newFlavor.kFlavor.videoCodec = this.kFlavor.videoCodec;
			newFlavor.kFlavor.width = this.kFlavor.width;
	
			return newFlavor;
		}

	}
}