package com.kaltura.core
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.Security;

	import mx.core.Application;
	import mx.events.FlexEvent;

	public class KApplication extends Application
	{
		import com.kaltura.events.WrapperEvent;
		import mx.events.FlexEvent;

		public function KApplication()
		{
			addEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
		}

		override public function get parameters():Object
		{
			//if this swf is loaded into wrapper swf that implements the marker interface IFlexWrapper
			var sm:MovieClip = MovieClip(systemManager);
			var loaderRoot:DisplayObject = sm.parent.root
			var params:Object;
			if (loaderRoot.hasOwnProperty("NAME") && loaderRoot["NAME"] == "flexWrapper")
			{
				params = loaderRoot.loaderInfo.parameters;
			}
			else
			{
				//the swf is either embedded directly into the page or it's loaded by unkown swf
				params = super.parameters;
			}
			if (params.hasOwnProperty("bgColor"))
				setStyle("backgroundColor", params.bgColor);
			return params;
		}

		private function preinitializeHandler(preinitializeEvent:FlexEvent):void
		{
			systemManager.addEventListener(Event.ADDED, smAddedHandler);
		}

		private function addedHandler(addedEvent:Event):void
		{
			if (stage)
			{
				this.removeEventListener(Event.ADDED, addedHandler);
				setSecurityPermissions();
			}
		}
		private function smAddedHandler(addedEvent:Event):void
		{
			systemManager.removeEventListener(Event.ADDED, smAddedHandler);
			setSecurityPermissions();
		}

		private function setSecurityPermissions():void
		{
			Security.allowDomain("*");
			systemManager.dispatchEvent(new WrapperEvent(WrapperEvent.SECURITY_PERMISSIONS_ALLOWED, true));
		}
	}
}