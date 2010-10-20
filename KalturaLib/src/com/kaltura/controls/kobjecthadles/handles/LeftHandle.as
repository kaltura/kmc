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
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.Container;
	
	public class LeftHandle extends HandleBase
	{	
		public const MIN_WIDTH : Number = 4;
		
		private var _deltaX : Number = 1;
		private var _deltaY : Number = 1;
		private var _sinRotation : Number = 0;
		private var _cosRotation : Number = 1;
		
		public static const WE_CURSOR_X_OFFSET : Number = -10;
		public static const WE_CURSOR_Y_OFFSET : Number = -5;

		public function LeftHandle( container : Container , 
									 defaultLook : Boolean = true , 
									 userIcon : Class = null ,
									 fillColor : uint = 0x000000 ,
									 fillAlph : Number = 1 ,
									 squareSize : Number = 8 )
		{
			super( container ,defaultLook , userIcon , fillColor , fillAlph , squareSize);	
			setNewXPosition();
			setNewYPosition();
		}
		
		public function setNewXPosition() : void
		{
			this.x = -this.p_squareSize/2;
		}
		
		public function setNewYPosition() : void
		{
			this.y = p_containerRef.height/2 - this.p_squareSize/2;
		}
		
		public function setNewRotation() : void
		{
			_sinRotation = Math.sin(Math.PI*p_containerRef.rotation/180);
			_cosRotation = Math.cos(Math.PI*p_containerRef.rotation/180);
		}
		
		//override functions
		//////////////////////////////////////////////////////////////////////////////
		override protected function mouseMoveHandler( event : MouseEvent ) : void
		{		
		    HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.LEFT , this.stage );
			event.stopImmediatePropagation();
		}
		
		override protected function stageMouseMoveHandler( event : MouseEvent ) : void
		{	
			if( event.buttonDown )
			{
				var _localPoint : Point = globalToLocal( new Point( event.stageX , event.stageY ) );
				_deltaX = _localPoint.x;
								
				if((p_containerRef.width-_deltaX > MIN_WIDTH || _deltaX < 0))
				{
					p_containerRef.width -= _deltaX  ;
					p_containerRef.x += _deltaX * _cosRotation;
					p_containerRef.y +=  _deltaX * _sinRotation;
				} 
				else if( p_containerRef.width < MIN_WIDTH)
					p_containerRef.width = MIN_WIDTH; 
			}
		}	
	}
}