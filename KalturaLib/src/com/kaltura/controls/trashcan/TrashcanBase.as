package com.kaltura.controls.trashcan
{
	import com.kaltura.controls.trashcan.events.TrashcanEvent;

	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;

	import mx.containers.HBox;
	import mx.core.EventPriority;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;

	/**
	* dispatched when an item was dropped to indicate a deletion of item.
	* @eventType com.kaltura.controls.trashcan.events.TrashcanEvent.REMOVE_ITEM
	*/
	[Event(name="removeItem", type="com.kaltura.controls.trashcan.events.TrashcanEvent")]
	/**
	* dispatched when the clear all button was clicked.
	* @eventType com.kaltura.controls.trashcan.events.TrashcanEvent.REMOVE_ALL
	*/
	[Event(name="removeAll", type="com.kaltura.controls.trashcan.events.TrashcanEvent")]

	public class TrashcanBase extends HBox
	{
		static public function getShadowFilter ():DropShadowFilter
		{
            var distance:Number = 1;
            var angle:Number = 45;
            var color:Number = 0x000000;
            var alpha:Number = 1;
            var blurX:Number = 6;
            var blurY:Number = 6;
            var strength:Number = 0.65;
            var quality:Number = BitmapFilterQuality.LOW;
            var inner:Boolean = true;
            var knockout:Boolean = false;

            return new DropShadowFilter(distance, angle, color, alpha,
                blurX, blurY, strength, quality, inner, knockout);
        }

		[Bindable]
		[Inspectable]
		/**
		 * the height of the trashcan on opened state.
		 */
		public var openHeight:Number = 50;

		[Bindable]
		[Inspectable]
		/**
		 * the height of the trashcan on closed state.
		 */
		public var closeHeight:Number = 25;

		[Bindable]
		[Inspectable]
		/**
		 * duration of the resize effect.
		 */
		public var resizeDuration:Number = 350;

		[Bindable]
		[Inspectable]
		/**
		 * the text of the lable.
		 */
		public var deletLable:String = "Drag here to delete.";

		///////////////////////////////////////////////////////
		[Bindable]
		[Inspectable]
		/**
		 * the text is the style name of the label.
		 */
		public var lblStyleName:String = trashCanTextStyle;

		public static const trashCanTextStyle : String = "trashCanTextStyle";
		public static const trashCanOpenTextStyle : String = "trashCanOpenTextStyle";
		///////////////////////////////////////////////////////

		protected var _trashcanOpen:Boolean = false;
		/**
		 * indicates whether can is in open or closed state.
		 */
		[Bindable]
		[Inspectable]
		public function get trashcanOpen ():Boolean
		{
			return _trashcanOpen;
		}
		public function set trashcanOpen (value:Boolean):void
		{
			if (_trashcanOpen == value)
				return;
			if (value)
				openCan();
			else
				closeCan();
		}

		[Bindable]
		[Inspectable]
		public var enableDragBehaviours:Boolean = true;

		public var openCloseCan:Resize;

		protected function dragEnterHandler( event : DragEvent ) : void
		{
			if (enabled)
			{
				if (event.dragSource.hasFormat('items'))
				{
					if (enableDragBehaviours)
						trashcanOpen = true;
		           	DragManager.acceptDragDrop(this);
		           	DragManager.showFeedback(DragManager.MOVE);
		  		}
		 	}
        }

        protected function dragOverHandler ( event : DragEvent ) : void
		{
			if (enabled)
			{
				if (event.dragSource.hasFormat('items'))
				{
		           	DragManager.acceptDragDrop(this);
		           	DragManager.showFeedback(DragManager.MOVE);
		  		}
		 	}
        }

		protected function dragDropHandler( event : DragEvent ) : void
		{
			if (enabled)
			{
				DragManager.showFeedback(DragManager.COPY);
				if (event.dragSource.hasFormat('items'))
				{
					var items:Array = event.dragSource.dataForFormat('items') as Array;
					dispatchEvent (new TrashcanEvent (TrashcanEvent.REMOVE_ITEM, items));
					if (enableDragBehaviours)
						trashcanOpen = false;
				}
			}
		}

		protected function dragCompleteHandler (event:DragEvent):void
		{
			//nothing here.
		}

		protected function dragExitHandler (event:DragEvent):void
		{
			if (enabled)
			{
				if (enableDragBehaviours)
					trashcanOpen = false;
			}
		}

		public function openCan ():void
		{
			playEffect (height, openHeight);
			_trashcanOpen = true;
			lblStyleName = trashCanOpenTextStyle; //Boaz
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp, false, EventPriority.BINDING, true);
		}

		public function closeCan ():void
		{
			playEffect (height, closeHeight);
			_trashcanOpen = false;
			lblStyleName = trashCanTextStyle; //Boaz
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}

		protected function playEffect (heightFrom:Number, heightTo:Number):void
		{
			if (openCloseCan.isPlaying)
				openCloseCan.stop();
			openCloseCan.heightFrom = height;
			openCloseCan.heightTo = heightTo;
			openCloseCan.play ();
		}

		protected function stageMouseUp (event:MouseEvent):void
		{
			trashcanOpen = false;
		}

		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			setListeners (value);
		}

		protected function setListeners (listen:Boolean):void
		{
			if (listen)
			{
				addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false, 0, true);
				addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false, 0, true);
				addEventListener(DragEvent.DRAG_DROP, dragDropHandler, false, 0, true);
				addEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false, 0, true);
				addEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler, false, 0, true);
			} else {
				removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
				removeEventListener(DragEvent.DRAG_OVER, dragOverHandler);
				removeEventListener(DragEvent.DRAG_DROP, dragDropHandler);
				removeEventListener(DragEvent.DRAG_EXIT, dragExitHandler);
				removeEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler);
			}
		}

		/**
		 * Constructor.
		 */
		public function TrashcanBase():void
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}

		private function onCreationComplete (event:FlexEvent):void
		{
			setListeners (enabled);
			if (dropCanShadow)
				this.filters = [TrashcanBase.getShadowFilter ()];
		}

		private var _dropCanShadow:Boolean = true;
		public function get dropCanShadow ():Boolean {
			return _dropCanShadow;
		}
		public function set dropCanShadow (value:Boolean):void
		{
			if (value)
				this.filters = [TrashcanBase.getShadowFilter ()];
			_dropCanShadow = value;
		}
	}
}