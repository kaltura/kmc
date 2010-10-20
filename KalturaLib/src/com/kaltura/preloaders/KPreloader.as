package com.kaltura.preloaders
{
	import com.kaltura.wrapper.IFlexWrapper;

	import flash.display.DisplayObject;
	import flash.events.Event;

	import mx.managers.SystemManager;
	import mx.preloaders.DownloadProgressBar;

	public class KPreloader extends DownloadProgressBar
	{
		private var _wrapperRoot:DisplayObject;

		private var _isFlexWrapper:Boolean = false;

		private var _stageWidth:Number;
		private var _stageHeight:Number;

		public function KPreloader()
		{
			super();
			//set the default stageSize, which determines the preloader position on the screen
			_stageWidth = super.stageWidth;
			_stageHeight = super.stageHeight;

			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		override public function get stageWidth():Number
		{
			return _stageWidth;
		}

		override public function set stageWidth(value:Number):void
		{
			if (_isFlexWrapper)
				return; //avoids wrong size assignment from the SystemManager
			else
				_stageWidth = value;
		}

		override public function get stageHeight():Number
		{
			return _stageHeight;
		}

		override public function set stageHeight(value:Number):void
		{
			if (_isFlexWrapper)
				return; //avoids wrong size assignment from the SystemManager
			else
				_stageHeight = value;
		}

		private function addedToStageHandler(e:Event):void
		{
			var sm:SystemManager = this.root as SystemManager;

			/* This swf's parent swf's root, which can be one of these:
				-Stage 					- if this swf is the top level swf
				-FlexWrapper instance 	- if this swf is loaded into FlexWrapper
				-other swf's root 		- if this swf is loaded directly into other swf which is not FlexWrapper */
			_wrapperRoot = sm.parent.root

			if (_wrapperRoot is IFlexWrapper)
			{
				_isFlexWrapper = true;
				useWrapperDimensions();
				center(stageWidth, stageHeight);
			}
		}

		private function useWrapperDimensions():void
		{
			_stageWidth		= _wrapperRoot.width;
			_stageHeight	= _wrapperRoot.height;
		}
	}
}