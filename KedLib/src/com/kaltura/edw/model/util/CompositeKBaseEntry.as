package com.kaltura.edw.model.util
{
	import com.kaltura.vo.KalturaBaseEntry;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.PropertyChangeEvent;
	
	public class CompositeKBaseEntry extends KalturaBaseEntry
	{
		
		private var _entries:Vector.<KalturaBaseEntry>;
		
		public function CompositeKBaseEntry(entries:Vector.<KalturaBaseEntry>)
		{
			super();
		
			_entries = entries;
			
//			bindToComponents("id");
//			bindToComponents("name");
//			bindToComponents("description");
//			bindToComponents("partnerId");
//			bindToComponents("userId");
//			bindToComponents("tags");
//			bindToComponents("adminTags");
//			bindToComponents("categories");
//			bindToComponents("categoriesIds");
//			bindToComponents("status");
//			bindToComponents("moderationStatus");
//			bindToComponents("moderationCount");
//			bindToComponents("type");
//			bindToComponents("createdAt");
//			bindToComponents("updatedAt");
//			bindToComponents("rank");
//			bindToComponents("totalRank");
//			bindToComponents("votes");
//			bindToComponents("groupId");
//			bindToComponents("partnerData");
//			bindToComponents("downloadUrl");
//			bindToComponents("searchText");
//			bindToComponents("licenseType");
//			bindToComponents("version");
//			bindToComponents("thumbnailUrl");
//			bindToComponents("accessControlId");
//			bindToComponents("startDate");
//			bindToComponents("endDate");
//			bindToComponents("referenceId");
//			bindToComponents("replacingEntryId");
//			bindToComponents("replacedEntryId");
//			bindToComponents("replacementStatus");
//			bindToComponents("replacementStatus");
			
			addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChanged);
		}
		
		protected function onPropertyChanged(event:PropertyChangeEvent):void
		{
			var propName:String = event.property as String;
			setBoundValue(propName, event.newValue);
		}
		
		private function bindToComponents(prop:String):void{
			BindingUtils.bindSetter(
				function (value:String):void{
					setBoundValue(prop, value);
				}, this, prop);
		}
		
		private function setBoundValue(prop:String, value:Object):void{
			for each(var entry:KalturaBaseEntry in _entries){
				entry[prop] = value;
			}
		}
	}
}