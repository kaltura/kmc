package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaConversionProfile;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class ConversionProfileVO extends EventDispatcher implements IValueObject
	{
		
		/**
		 * The ConversionProfileVO.SELECTED_CHANGED_EVENT constant defines the 
		 * value of the type property of a selected changed event object.  
		 */		
		public static const SELECTED_CHANGED_EVENT : String = "transcodeProfileSelectedChanged";
		
		
		private var _selected:Boolean = false;
		
		/**
		 * conversion profile 
		 */		
		public var profile:KalturaConversionProfile;
		

		/**
		 * Constructor. 
		 */		
		public function ConversionProfileVO()
		{
			profile = new KalturaConversionProfile();
		}
		
		/**
		 * indicates this profile is selected 
		 */		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * @private
		 */		
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}
		
		/**
		 * returns a clone of this vo 
		 */		
		public function clone():ConversionProfileVO
		{
			var newConversionProfile:ConversionProfileVO = new ConversionProfileVO();
			
			newConversionProfile.selected = this.selected;
			newConversionProfile.profile.createdAt = this.profile.createdAt;
			newConversionProfile.profile.description = this.profile.description
			newConversionProfile.profile.flavorParamsIds = this.profile.flavorParamsIds;
			newConversionProfile.profile.id = this.profile.id;
			newConversionProfile.profile.name = this.profile.name;
			newConversionProfile.profile.partnerId = this.profile.partnerId;
			newConversionProfile.profile.isDefault = this.profile.isDefault;
			return newConversionProfile;
		} 

	}
}