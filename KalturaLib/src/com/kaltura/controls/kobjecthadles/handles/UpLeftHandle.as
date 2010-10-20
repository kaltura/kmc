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

	public class UpLeftHandle extends HandleBase
	{
		public const MIN_WIDTH : Number = 4;
		public const MIN_HEIGHT : Number = 4;
		private var _deltaY : Number = 1;
		private var _deltaX : Number = 1;

		private var _sinRotation : Number = 0;
		private var _cosRotation : Number = 1;
		public var maintainAspectRatio:Boolean = false;

		public function UpLeftHandle( container:Container,
									  defaultLook:Boolean=true,
									  userIcon:Class=null,
									  fillColor:uint=0x000000,
									  fillAlph:Number=1,
									  squareSize:Number=8 )
		{
			super(container, defaultLook, userIcon, fillColor, fillAlph, squareSize);
			setNewYPosition();
			setNewXPosition();
		}

		public function setNewYPosition() : void
		{
			this.y = - this.p_squareSize/2 ;
		}

		public function setNewXPosition() : void
		{
			this.x = - this.p_squareSize/2 ;
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
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.UP_LEFT , this.stage );
			event.stopImmediatePropagation();
		}

		override protected function stageMouseMoveHandler( event : MouseEvent ) : void
		{
			if( event.buttonDown )
			{
				_deltaX = globalToLocal( new Point( event.stageX , event.stageY ) ).x;
				_deltaY = globalToLocal( new Point( event.stageX , event.stageY ) ).y;
				var compWidth:Number, compHeight:Number;

				if(p_containerRef.height-_deltaY > MIN_HEIGHT || _deltaY < 0)
				{
					compHeight = p_containerRef.height - _deltaY  ;
				}
				else if( p_containerRef.height <= MIN_HEIGHT)
					compHeight = MIN_HEIGHT;

				if(p_containerRef.width -_deltaX > MIN_WIDTH || _deltaX < 0)
				{
					compWidth = p_containerRef.width - _deltaX  ;
				}
				else if( p_containerRef.width <= MIN_WIDTH)
					compWidth = MIN_WIDTH;

				if (maintainAspectRatio)
				{
					if (compWidth * 0.75 > compHeight)
					{
						compWidth = compHeight / 0.75;
					} else {
						compHeight = compWidth * 0.75;
					}
				}

				//TODO:fix the x and y of the content
				//_deltaX = compWidth - p_containerRef.width;
				//_deltaY = compHeight - p_containerRef.height;

				if(p_containerRef.height-_deltaY > MIN_HEIGHT || _deltaY < 0)
				{
					p_containerRef.y += _deltaY * _cosRotation;
					p_containerRef.x -= _deltaY * _sinRotation;
				}
				if(p_containerRef.width -_deltaX > MIN_WIDTH || _deltaX < 0)
				{
					p_containerRef.x += _deltaX * _cosRotation;
					p_containerRef.y +=  _deltaX * _sinRotation;
				}

				p_containerRef.width = compWidth;
				p_containerRef.height = compHeight;
			}
		}

	}
}