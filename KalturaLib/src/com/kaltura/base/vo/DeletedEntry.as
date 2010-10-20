package com.kaltura.base.vo
{
	public class DeletedEntry
	{
		public var entryId:String;
		public var entryName:String;
		public var durationInRoughcut:Number;
		public var attachedTransitionId:String;
		public var attachedTransitionDuration:Number;

		public function DeletedEntry(entry_id:String, entry_name:String, duration_in_roughcut:Number, attached_transition_id:String, attached_transition_duration:Number):void
		{
			entryId = entry_id;
			entryName = entry_name;
			durationInRoughcut = duration_in_roughcut;
			attachedTransitionId = attached_transition_id;
			attachedTransitionDuration = attached_transition_duration;
		}
	}
}