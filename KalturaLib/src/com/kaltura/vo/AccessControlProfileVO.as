package com.kaltura.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaBaseRestriction;
	import com.kaltura.vo.KalturaCountryRestriction;
	import com.kaltura.vo.KalturaDirectoryRestriction;
	import com.kaltura.vo.KalturaPreviewRestriction;
	import com.kaltura.vo.KalturaSessionRestriction;
	import com.kaltura.vo.KalturaSiteRestriction;
	
	import flash.events.Event;
	
	import mx.utils.ObjectProxy;
	
	/**
	 * This class is a wrapper for the KalturaAccessControl VO.
	 * 
	 * 
	 * 
	 */	
	[Bindable]
	public class AccessControlProfileVO extends ObjectProxy implements IValueObject 
	{
		public static const SELECTED_CHANGED_EVENT : String = "accessControlSelectedChanged";
		/**
		 * marks if this object is selected in the UI controller 
		 */		
		private var _selected:Boolean = false;
		
		/**
		 *  KalturaAccessControl VO, hold all the profile properties
		 */		
		public var profile:KalturaAccessControl;
		
		/**
		 * Constructor 
		 * 
		 */				
		public function AccessControlProfileVO()
		{
			profile = new KalturaAccessControl();
		}
		
		/**
		 *  
		 * @return true if it was selected by the UI controller
		 * 
		 */		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * set the selected parameter 
		 * @param selected - Boolean
		 * 
		 */		
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}
		
		/**
		 * Creates a AccessControlProfileVO  
		 * @return a new AccessControlProfileVO object
		 * 
		 */		
		public function clone():AccessControlProfileVO
		{
			var newAcp:AccessControlProfileVO = new AccessControlProfileVO();
			newAcp.selected = this.selected;
			newAcp.profile.name = this.profile.name.slice();
			newAcp.profile.description = this.profile.description.slice();
			newAcp.profile.createdAt = this.profile.createdAt;
			newAcp.profile.id = this.profile.id;
			newAcp.profile.isDefault = this.profile.isDefault;
			
			for each(var restriction:KalturaBaseRestriction in this.profile.restrictions)
			{
				if(restriction is KalturaSiteRestriction)
				{
					var ksr:KalturaSiteRestriction = new KalturaSiteRestriction();
					ksr.siteRestrictionType = (restriction as KalturaSiteRestriction).siteRestrictionType;
					ksr.siteList = (restriction as KalturaSiteRestriction).siteList;
					newAcp.profile.restrictions.push(ksr);
				}
				else if(restriction is KalturaCountryRestriction)
				{
					var kcr:KalturaCountryRestriction = new KalturaCountryRestriction();
					kcr.countryRestrictionType = (restriction as KalturaCountryRestriction).countryRestrictionType;
					kcr.countryList = (restriction as KalturaCountryRestriction).countryList;
					newAcp.profile.restrictions.push(kcr);
				}
				else if(restriction is KalturaPreviewRestriction)
				{
					var kpr:KalturaPreviewRestriction = new KalturaPreviewRestriction();
					kpr.previewLength = (restriction as KalturaPreviewRestriction).previewLength;
					newAcp.profile.restrictions.push(kpr);
				}
				else if(restriction is KalturaSessionRestriction)
				{
					var kser:KalturaSessionRestriction = new KalturaSessionRestriction();
					newAcp.profile.restrictions.push(kser);
				}
				else if(restriction is KalturaDirectoryRestriction)
				{
					var kdr:KalturaDirectoryRestriction = new KalturaDirectoryRestriction();
					kdr.directoryRestrictionType = (restriction as KalturaDirectoryRestriction).directoryRestrictionType;
					newAcp.profile.restrictions.push(kdr);
				}
			}

			
			return newAcp;
		}
	
	}
}