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

	public class DownRightHandle extends HandleBase
	{
		public const MIN_WIDTH : Number = 4;
		public const MIN_HEIGHT : Number = 4;
		private var _deltaY : Number = 1;
		private var _deltaX : Number = 1;
		public var maintainAspectRatio:Boolean = false;

		public function DownRightHandle(container:Container,
										defaultLook:Boolean=true,
										userIcon:Class=null,
										fillColor:uint=0x000000,
										fillAlph:Number=1,
										squareSize:Number=8,
										 shapeType:String=SQUARE)
		{
			super(container, defaultLook, userIcon, fillColor, fillAlph, squareSize);
			setNewYPosition();
			setNewXPosition();
		}

		public function setNewYPosition() : void
		{
			this.y = p_containerRef.height - this.p_squareSize/2 + 2; // +2 is the border thikness TODO: Pass border thickness to this function
		}

		public function setNewXPosition() : void
		{
			this.x = p_containerRef.width - this.p_squareSize/2 + 2; // +2 is the border thikness TODO: Pass border thickness to this function
		}

		//override functions
		//////////////////////////////////////////////////////////////////////////////
		override protected function mouseMoveHandler( event : MouseEvent ) : void
		{
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.DOWN_RIGHT , this.stage );
			event.stopImmediatePropagation();
		}

		override protected function stageMouseMoveHandler( event : MouseEvent ) : void
		{
			if( event.buttonDown )
			{
				var currentPoint : Point = globalToLocal( new Point( event.stageX , event.stageY ) );
				_deltaX = currentPoint.x;
				_deltaY = currentPoint.y;
				var compWidth:Number, compHeight:Number;

				if(p_containerRef.height > MIN_HEIGHT || _deltaY > 0)
					compHeight = p_containerRef.height + _deltaY;
				else if( p_containerRef.height < MIN_HEIGHT)
					compHeight = MIN_HEIGHT; //fix the bug if you drag under min

				if(p_containerRef.width > MIN_WIDTH || _deltaX > 0)
					compWidth = p_containerRef.width + _deltaX;
				else if( p_containerRef.width < MIN_WIDTH)
					compWidth = MIN_WIDTH; //0.01 fix the bug if you drag under min

				if (maintainAspectRatio)
				{
					if (compWidth * 0.75 > compHeight)
					{
						compWidth = compHeight / 0.75;
					} else {
						compHeight = compWidth * 0.75;
					}
				}

				p_containerRef.width = compWidth;
				p_containerRef.height = compHeight;
			}
		}

	}
}