/*
This file is part of the Kaltura Collaborative Media Suite which allows users
to do with audio, video, and animation what Wiki platfroms allow them to do with
text.

Copyright (C) 2006-2008  Kaltura Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

@ignore
*/
package com.kaltura.controls.kobjecthadles
{
	import com.kaltura.controls.kobjecthadles.events.KPropChangeEvent;
	import com.kaltura.controls.kobjecthadles.events.RotateKohEvent;
	import com.kaltura.controls.kobjecthadles.handles.DownHandle;
	import com.kaltura.controls.kobjecthadles.handles.DownLeftHandle;
	import com.kaltura.controls.kobjecthadles.handles.DownRightHandle;
	import com.kaltura.controls.kobjecthadles.handles.FlipHandle;
	import com.kaltura.controls.kobjecthadles.handles.LeftHandle;
	import com.kaltura.controls.kobjecthadles.handles.RightHandle;
	import com.kaltura.controls.kobjecthadles.handles.RotateHandle;
	import com.kaltura.controls.kobjecthadles.handles.UpHandle;
	import com.kaltura.controls.kobjecthadles.handles.UpLeftHandle;
	import com.kaltura.controls.kobjecthadles.handles.UpRightHandle;
	import com.kaltura.controls.kobjecthadles.managers.HandleCursorManager;
	import com.kaltura.controls.kobjecthadles.managers.HandleDisplayManager;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.binding.utils.ChangeWatcher;
	import mx.containers.Canvas;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;

	/**
	 * Dispatched when object handles rotateion occour.
	 */
	[Event(name="rotate", type="com.kaltura.kobjecthandles.events.RotateKohEvent")]
	[Event(name="selectonChanged", type="com.kaltura.kobjecthandles.events.SelectionKohEvent")]
	[Event(name="widthChangedEvent", type="com.kaltura.controls.kobjecthadles.events.KPropChangeEvent")]
	[Event(name="heightChangedEvent", type="com.kaltura.controls.kobjecthadles.events.KPropChangeEvent")]

	/**
	* Defines the Dash Stroke Color.
	*/
	[Style(name="dashStrokeColor", type="uint", inherit="no")]

	[Style(name="dashHorizintalGap", type="Number", format="Length" , inherit="no")]
	[Style(name="dashVerticalGap", type="Number", format="Length" , inherit="no")]
	[Style(name="verticalDashWidth", type="Number", format="Length" , inherit="no")]
	[Style(name="horizintalDashHeight", type="Number", format="Length", inherit="no")]
	[Style(name="dashStrokeAlpha", type="Number", inherit="no")]
	[Style(name="dashThickness", type="Number", format="Length", inherit="no")]

	[Style(name="handleFillColor", type="uint", inherit="no")]
	[Style(name="handleAlpha", type="Number", inherit="no")]

	public class KObjectHandles extends Canvas implements ISelectable
	{
		/**
		*the handles display manager give the hid to the object by referance count
		*
		*@default NaN
		*/
		public var hid : int; //the handles display manager give the hid to the object by referance count

		private var _selectable : Boolean = true;
		private var _selected : Boolean = false;
		private var _handlerControlFlag : Boolean = true;
		private var _customHandles : Boolean = false;
		private var _autoDrag : Boolean = true;
		private var _userHandleIcon : Class = null;

		private var _handleChildIndex : int = 0; // currently i support only 1 child in object handles
		private var _childIsInteractive : Boolean;

		private var _containedChildRef : DisplayObject;
		private var _dashedBorder : DashedBorder;

		private var _rightHandle : RightHandle;
		private var _leftHandle : LeftHandle;
		private var _downHandle : DownHandle;
		private var _upHandle : UpHandle;
		private var _upLeftHandle : UpLeftHandle;
		private var _upRightHandle : UpRightHandle;
		private var _downRightHandle : DownRightHandle;
		private var _downLeftHandle : DownLeftHandle;
		private var _rotateHandle : RotateHandle;

		private var _flipHandle : FlipHandle = null;
		private var _customFlipHandle : Class = null;

		private var _maintainAspectRatio:Boolean = true;
		//constructor
		//////////////////////////////////////////////////////////////////

		public function KObjectHandles()
		{
			super();

			creationPolicy = "all";
			horizontalScrollPolicy = ScrollPolicy.OFF;
			verticalScrollPolicy = ScrollPolicy.OFF;
			giveControlToHandler();

			addEventListener( FlexEvent.CREATION_COMPLETE , init );
			addEventListener( MouseEvent.MOUSE_DOWN , mouseDownHandler);
			addEventListener( MouseEvent.MOUSE_UP , mouseUpHandler );
			addEventListener( MouseEvent.CLICK , mouseClickHandler );
			addEventListener( MouseEvent.ROLL_OUT , rollOutHandler );
			addEventListener( MouseEvent.ROLL_OVER , rollOverHandler );
		}

		//override functions
		////////////////////////////////////////////////////////////////////
		override public function addChild( child : DisplayObject ) : DisplayObject
		{
			if(this.numChildren >= 1)
			{
				throw new Error("KObjectHandler Can't handle more than 1 child");
			}
			_containedChildRef = child;
			if( child is InteractiveObject )
			{
				_childIsInteractive = true;
			}

			super.addChild( child );

			return child;
		}

		//public functions
		/////////////////////////////////////////////////////////////////////

		/**
		 *determines whether or not maintain aspect ratio when scaling from the corner handles.
		 * @param value		true to maintain aspect ratio.
		 */
		public function set maintainAspectRatio (value:Boolean):void
		{
			_maintainAspectRatio = value;
			_upLeftHandle.maintainAspectRatio = _maintainAspectRatio;
			_upRightHandle.maintainAspectRatio = _maintainAspectRatio;
			_downRightHandle.maintainAspectRatio = _maintainAspectRatio;
			_downLeftHandle.maintainAspectRatio = _maintainAspectRatio;
		}
		public function get maintainAspectRatio ():Boolean
		{
			return _maintainAspectRatio;
		}
		/**
		* use to select the object
		*/
		public function select() : void
		{
			if( _selectable)
			{
				showHandles();
				_selected = true;
				rotateFinishedHandler(null);
			}
		}

		/**
		* use to deselect the object
		*/
		public function deselect() : void
		{
			hideHandler();
			_selected = false;
		}

		/**
		* hide all the hadles of the object handles
		*/
		public function hideHandler() : void
		{
			_rightHandle.visible = false;
			_leftHandle.visible = false;
			_downHandle.visible = false;
			_upHandle.visible = false;
			_upLeftHandle.visible = false;
			_upRightHandle.visible = false;
			_downRightHandle.visible = false;
			_downLeftHandle.visible = false;
			_rotateHandle.visible = false;
			_dashedBorder.visible = false;
		}

		/**
		* show all the hadles of the object handles
		*/
		public function showHandles() : void
		{
			if (_rightHandle) _rightHandle.visible = true;
			if (_leftHandle) _leftHandle.visible = true;
			if (_downHandle) _downHandle.visible = true;
			if (_upHandle) _upHandle.visible = true;
			if (_upLeftHandle) _upLeftHandle.visible = true;
			if (_upRightHandle) _upRightHandle.visible = true;
			if (_downRightHandle) _downRightHandle.visible = true;
			if (_downLeftHandle) _downLeftHandle.visible = true;
			if (_rotateHandle) _rotateHandle.visible = true;
			if (_dashedBorder) _dashedBorder.visible = true;
		}

		/**
		* Used to give the control to the child of the object handels
		* <p>use <code>giveControlToHandler</code> when you want to bring back the control
		* to the object handles
		* @see giveControlToChild
		*/
		public function giveControlToChild() : void
		{
			if(!_handlerControlFlag)
				return;

			if(_childIsInteractive)
			{
				var interactiveObj : InteractiveObject = _containedChildRef as InteractiveObject;
				interactiveObj.mouseEnabled = true;
			}

			_handlerControlFlag = false;
		}

		/**
		* Used to give the control to the handler if it is
		* given to the object handle content
		* <p>use <code>giveControlToHandler</code> when you want to bring back the control
		* after using <code>giveControlToChild</code></p>
		* @see giveControlToChild
		*/

		public function giveControlToHandler() : void
		{
			if(_handlerControlFlag)
				return;

			if(_childIsInteractive)
			{
				var interactiveObj : InteractiveObject = _containedChildRef as InteractiveObject;
				interactiveObj.mouseEnabled = false;
			}

			_handlerControlFlag = true;
		}

		///private functions
		/////////////////////////////////////////////////////////////////////
		private function init( event : FlexEvent ) : void
		{
			createGraphicHandles();
			ChangeWatcher.watch( this , "width" , widthChangeHandler );
			ChangeWatcher.watch( this , "height" , heightChangeHandler );

			HandleDisplayManager.getInstance().setHId( this );

			maintainAspectRatio = _maintainAspectRatio;
		}

		private function createGraphicHandles() : void
		{
			//adding visual rawChildren
			///////////////////////
    		createDashedBorder();// add the dashed lines to the rawChildren
			///////////////////////

			//add interactive rawChildren
			///////////////////////////
			addInteractiveHandlers();// add interactiveHandlers handles
			///////////////////////////

			//create rottate effect
			//////////////////
			createRotate(); // add rotate handle
			//////////////////

			//create flip icon
			//////////////////
			//createFlip();   // add flip handle
			//////////////////
		}

		private function rotateFinishedHandler( event : Event ) : void
		{
			if (_leftHandle) _leftHandle.setNewRotation();
			if (_upLeftHandle) _upLeftHandle.setNewRotation();
			if (_upHandle) _upHandle.setNewRotation();
			if (_upRightHandle) _upRightHandle.setNewRotation();
			if (_downLeftHandle) _downLeftHandle.setNewRotation();

			HandleCursorManager.getInstance().setRotation( this.rotation );
			dispatchEvent( new RotateKohEvent("rotate" , this.rotation ) );
		}

		private function createDashedBorder() : void
		{
			var dashedStrokeColor : uint = getStyle("dashStrokeColor");
			if(dashedStrokeColor == 0)
				dashedStrokeColor= 0x000000;

			var verticalGap : Number = getStyle("dashVerticalGap");
			if(isNaN(verticalGap))
				verticalGap = 2;

			var horizintalGap : Number = getStyle("dashHorizintalGap");
			if(isNaN(horizintalGap))
				horizintalGap  = 2;

			var verticalDash : Number = getStyle("verticalDashWidth");
			if(isNaN(verticalDash))
				verticalDash  = 2;

			var horizintalDash : Number = getStyle("horizintalDashHeight");
			if(isNaN(horizintalDash))
				horizintalDash  = 2;

			var dashedStrokeAlpha : Number = getStyle("dashStrokeAlpha");
			if(isNaN(dashedStrokeAlpha))
				dashedStrokeAlpha  = 1;

			var dashedThickness : Number = getStyle("dashThickness");
			if(isNaN(dashedThickness))
				dashedThickness  = 1;

			_dashedBorder = new DashedBorder(this ,
											 dashedStrokeColor ,
											 verticalGap ,
											 horizintalGap ,
											 verticalDash ,
											 horizintalDash ,
											 dashedStrokeAlpha ,
											 dashedThickness );

			this.rawChildren.addChild(_dashedBorder);
		}

		private function createRotate() : void
		{
			var fillColor : uint = getStyle("handleFillColor");
			if(fillColor == 0)
				fillColor= 0x000000;

			_rotateHandle = new RotateHandle( this , !_customHandles , _userHandleIcon , fillColor );
			_rotateHandle.addEventListener( RotateHandle.ROTATE_FINISHED , rotateFinishedHandler );
		}

		//TODO: Finish...
		/////////////////////////////////////////////////////////
		private function createFlip() : void
		{
			var fillColor : uint = getStyle("handleFillColor");
			if(fillColor == 0)
				fillColor= 0x000000;

			var isDefualtLook : Boolean = _customFlipHandle == null;
			_flipHandle= new FlipHandle( this , isDefualtLook , _customFlipHandle , fillColor);
		}

		private function scaleXChangedHandler( event : Event ) : void
		{
			//TODO: set a parameter to determine if we want to change the child or not.
			//_containedChildRef.scaleX = this.scaleX;
			_dashedBorder.redrawDhasedLine();
		}
		//////////////////////////////////////////////////////////

		private function widthChangeHandler( event : Event ) : void
		{
			//TODO: set a parameter to determine if we want to change the child or not.
			//_containedChildRef.width = this.width;
			_dashedBorder.redrawDhasedLine();

			_leftHandle.setNewXPosition();
			_rightHandle.setNewXPosition();
			_downHandle.setNewXPosition();
			_upHandle.setNewXPosition();
			_upLeftHandle.setNewXPosition();
			_upRightHandle.setNewXPosition();
			_downRightHandle.setNewXPosition();
			_downLeftHandle.setNewXPosition();
			_rotateHandle.setNewXPosition();

			dispatchEvent( new KPropChangeEvent(KPropChangeEvent.WIDTH_CHANGED_EVENT ,  this.width ) );
		}

		private function heightChangeHandler( event : Event ) : void
		{
			//TODO: set a parameter to determine if we want to change the child or not.
			//_containedChildRef.height = this.height;
			_dashedBorder.redrawDhasedLine();

			_downHandle.setNewYPosition();
			_rightHandle.setNewYPosition();
			_leftHandle.setNewYPosition();
			_upHandle.setNewYPosition();
			_upLeftHandle.setNewYPosition();
			_upRightHandle.setNewYPosition();
			_downRightHandle.setNewYPosition();
			_downLeftHandle.setNewYPosition();
			_rotateHandle.setNewYPosition();

			dispatchEvent( new KPropChangeEvent(KPropChangeEvent.HEIGHT_CHANGED_EVENT ,  this.height ) );
		}

		private function addInteractiveHandlers() : void
		{
			var fillColor : uint = getStyle("handleFillColor");
			if(fillColor == 0)
				fillColor= 0x000000;

			_rightHandle = new RightHandle( this , !_customHandles , _userHandleIcon , fillColor);
			_leftHandle = new LeftHandle( this , !_customHandles , _userHandleIcon , fillColor);
			_downHandle = new DownHandle( this , !_customHandles , _userHandleIcon , fillColor);
			_upHandle = new UpHandle ( this , !_customHandles , _userHandleIcon , fillColor);

			_upLeftHandle = new UpLeftHandle( this , !_customHandles , _userHandleIcon , fillColor);
			_upRightHandle = new UpRightHandle ( this , !_customHandles , _userHandleIcon , fillColor);
			_downRightHandle = new DownRightHandle ( this , !_customHandles , _userHandleIcon , fillColor);
			_downLeftHandle = new DownLeftHandle ( this , !_customHandles , _userHandleIcon , fillColor);
		}

		//handlers
		/////////////////////////////////////////////////////////
		private function mouseDownHandler( event : MouseEvent ) : void
		{
			addEventListener( MouseEvent.MOUSE_MOVE , mouseMoveHandler );
		}

		private function mouseClickHandler( event : MouseEvent ) : void
		{
			if(_selectable)
			{
				HandleDisplayManager.getInstance().setSelected( this );
			}
		}

		private function mouseMoveHandler( event : MouseEvent ) : void
		{
			if(!_handlerControlFlag || !_selected || !_autoDrag)
				return;

			//trace("mouseMoveHandler");

			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.MOVE , this.stage );

			if(event.buttonDown && !HandleCursorManager.getInstance().isDragging )
			{
				HandleCursorManager.getInstance().setIsDragging(true);
				this.startDrag();
				event.updateAfterEvent();
			}
		}

		private function mouseUpHandler( event : MouseEvent ) : void
		{
			removeEventListener( MouseEvent.MOUSE_MOVE , mouseMoveHandler );

			if(!_handlerControlFlag)
				return;

			this.stopDrag();
			HandleCursorManager.getInstance().setIsDragging(false);
		}

		private function rollOverHandler( event : MouseEvent ) : void
		{
			if(!_handlerControlFlag || !_selected || !_autoDrag)
				return;

			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.MOVE , this.stage );
		}

		private function rollOutHandler( event : MouseEvent ) : void
		{
			if(!_handlerControlFlag)
				return;

			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.NONE , this.stage );
		}

		//getters & setters
		////////////////////////////////////////////////////////////////////////////
		/**
		* Indicates whether or not the handler has the control
		*/
		public function get handlerControlFlag() : Boolean
		{
			return _handlerControlFlag;
		}

		public function set handlerControlFlag( handlerControlFlag : Boolean ) : void
		{
			_handlerControlFlag = handlerControlFlag;
		}

		/**
		* Indicates whether or not the handler uses a custom handles
		*/
		public function get customHandles( ) : Boolean
		{
			return _customHandles ;
		}

		public function set customHandles( customHandles : Boolean ) : void
		{
			_customHandles = customHandles;
		}

		public function get selectable() : Boolean
		{
			return _selectable;
		}

		public function set selectable( selectable : Boolean ) : void
		{
			_selectable = selectable;
		}

		public function get autoDrag() : Boolean
		{
			return _autoDrag;
		}

		public function set autoDrag( autoDrag : Boolean ) : void
		{
			_autoDrag = autoDrag;
		}



		//read only
		/////////////////////////////////////////////////////////////////////////
		/**
		* Indicates whether or not the object handler is selected
	 	* @read
		*/
		public function get selected() : Boolean
		{
			return _selected;
		}
	}
}