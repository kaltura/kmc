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
package com.kaltura.controls.kobjecthadles.handles
{
	import com.kaltura.controls.kobjecthadles.managers.HandleCursorManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.Container;
	import mx.effects.Rotate;

	/**
	 * Dispatched when the rotation finished a rotate event to all the
	 * handles can calculate the new sin(angle) and cos(angle)
	 */
	[Event(name="rotateFinished", type="mx.events.Event")]

	public class RotateHandle extends HandleBase
	{
		public static const ROTATE_FINISHED : String = "rotateFinished";
		
		private var _rotateEffect : Rotate;
		private var _anchorPoint : Point;
		
		public function RotateHandle( container:Container, 
									  defaultLook:Boolean=true,
									  userIcon:Class=null, 
									  fillColor:uint=0x000000, 
									  fillAlph:Number=1, 
									  squareSize:Number=8, 
									  shapeType:String=HandleBase.CIRCLE )
		{
			super(container, defaultLook, userIcon, fillColor, fillAlph, squareSize, shapeType);
			_rotateEffect = new Rotate( p_containerRef );
			setNewYPosition();
			setNewXPosition();
			
			_rotateEffect.duration = 1;
			_rotateEffect.angleTo = 0;
		}
		
		public function setNewYPosition() : void
		{
			this.y = -4 * this.p_squareSize ; 
			_rotateEffect.originY = p_containerRef.height/2;
		}
		
		public function setNewXPosition() : void
		{
			this.x = p_containerRef.width/2 + 2;
			_rotateEffect.originX = p_containerRef.width/2;
		}
		
		override protected function mouseDownHandler( event : MouseEvent ) :void
		{
			super.mouseDownHandler( event );
			_anchorPoint = p_containerRef.localToGlobal(new Point( p_containerRef.width/2 , p_containerRef.height/2));
		}
		
		override protected function mouseMoveHandler( event : MouseEvent ) : void  
		{
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.Rotate , this.stage );
			event.stopImmediatePropagation();
		}
		
		override protected function stageMouseMoveHandler( event : MouseEvent ) : void
		{	
			if( event.buttonDown )
			{		
				var angle : Number = Math.atan2( event.stageX - _anchorPoint.x, event.stageY - _anchorPoint.y ) * 180/Math.PI + 180; 
				_rotateEffect.end();
				_rotateEffect.angleFrom = p_containerRef.rotation;
				_rotateEffect.angleTo = -angle; 
				_rotateEffect.play(); 
			}
		}
		
		override protected function stageMouseUpHandler( event : MouseEvent ) : void
		{
			super.stageMouseUpHandler( event );
			dispatchEvent( new Event( RotateHandle.ROTATE_FINISHED ) );
		}

	}
}