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
	import flash.events.MouseEvent;
	
	import mx.core.Container;

	public class FlipHandle extends HandleBase
	{
		public function FlipHandle(container:Container, 
								   defaultLook:Boolean=true, 
								   userIcon:Class=null, 
								   fillColor:uint=0x000000, 
								   fillAlph:Number=1, 
								   squareSize:Number=16, 
								   shapeType:String=SQUARE)
		{
			super(container, defaultLook, userIcon, fillColor, fillAlph, squareSize, shapeType);
			setNewYPosition();
			setNewXPosition();
			addEventListener( MouseEvent.CLICK , flipHandler );
		}
		
		public function setNewYPosition() : void
		{
			this.y = -4 * this.p_squareSize ; 
		}
		
		public function setNewXPosition() : void
		{
			this.x = p_containerRef.width/2 - 20;
		}
		
		private function flipHandler( event : MouseEvent ) : void
		{
			//add code here
		}
	}
}