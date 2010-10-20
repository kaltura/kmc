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
	
	public class DownHandle extends HandleBase
	{
		public const MIN_HEIGHT : Number = 4;

		private var _deltaY : Number = 1;
		
		public function DownHandle( container : Container , 
									defaultLook : Boolean = true , 
									userIcon : Class = null ,
									fillColor : uint = 0x000000 ,
									fillAlph : Number = 1 ,
									squareSize : Number = 8,
									shapeType:String=SQUARE)
		{
			super( container ,defaultLook , userIcon , fillColor , fillAlph , squareSize , shapeType);
			setNewYPosition(); 
			setNewXPosition();
		}
		
		public function setNewYPosition() : void
		{
			this.y = p_containerRef.height - this.p_squareSize/2 + 2; // +2 is the border thikness TODO: Pass border thickness to this function
		}
		
		public function setNewXPosition() : void
		{
			this.x = p_containerRef.width/2 - this.p_squareSize/2 + 2; // +2 is the border thikness TODO: Pass border thickness to this function
		}
		
		//override functions
		//////////////////////////////////////////////////////////////////////////////
		override protected function mouseMoveHandler( event : MouseEvent ) : void
		{
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.DOWN , this.stage );
			event.stopImmediatePropagation();
		}
		
		override protected function stageMouseMoveHandler( event : MouseEvent ) : void
		{	
			if( event.buttonDown )
			{
				_deltaY = globalToLocal( new Point( event.stageX , event.stageY ) ).y;
				
				if(p_containerRef.height > MIN_HEIGHT || _deltaY > 0)
					p_containerRef.height += _deltaY  ; 
				else if( p_containerRef.height <= MIN_HEIGHT)
					p_containerRef.height = MIN_HEIGHT;
			}
		}
	}
}