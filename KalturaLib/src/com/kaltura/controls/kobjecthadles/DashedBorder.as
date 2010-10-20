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
	import flash.display.DisplayObject;
	import flash.display.Shape;

	public class DashedBorder extends Shape
	{
		private var _verticalGap : Number;
		private var _horizintalGap : Number;
		private var _verticalDash : Number;
		private var _horizintalDash : Number;
		private var _dashedBorderObjectRef : DisplayObject;
		private var _dashedStrokeColor : uint;
		private var _dashedStrokeAlpha : Number;
		private var _dashedThickness : Number; 
		
		
		public function DashedBorder( dashedBorderObject : DisplayObject , 
									  dashedStrokeColor : uint = 0x000000 ,
									  verticalGap : Number = 2 , 
									  horizintalGap : Number = 2 ,
									  verticalDash : Number = 2 , 
									  horizintalDash: Number = 2 ,
									  dashedStrokeAlpha : Number = 1,
									  dashedThickness : Number = 1 )
		{
			super();
			_dashedBorderObjectRef = dashedBorderObject;
			_dashedStrokeColor = dashedStrokeColor;
			_verticalGap = verticalGap;
			_horizintalGap = horizintalGap;
			_verticalDash = verticalDash;
			_horizintalDash = horizintalDash;
			_dashedStrokeAlpha = dashedStrokeAlpha;
			_dashedThickness = dashedThickness;
			drawDashedLine();
		}
		
		public function redrawDhasedLine() : void
		{
			this.graphics.clear();
			drawDashedLine();
		}
		
		private function drawDashedLine() : void
		{
			var currentX : Number;
			var currentY : Number;
			
			this.graphics.lineStyle( _dashedThickness , _dashedStrokeColor , _dashedStrokeAlpha );
			this.graphics.beginFill( _dashedStrokeColor , _dashedStrokeAlpha);
			
			for( currentX = 0 ;  
				 currentX < _dashedBorderObjectRef.width ; 
				 currentX = currentX + _horizintalDash + _horizintalGap )
			{
				this.graphics.moveTo( currentX , currentY );
				
				if(currentX + _horizintalDash <= _dashedBorderObjectRef.width)
					this.graphics.lineTo( currentX + _horizintalDash , currentY );
				else
					this.graphics.lineTo( _dashedBorderObjectRef.width , currentY );
			}
			
			for( currentY =0 , currentX = _dashedBorderObjectRef.width ;
				 currentY < _dashedBorderObjectRef.height ;
				 currentY = currentY + _verticalDash + _verticalGap )
			{
				this.graphics.moveTo( currentX , currentY );
				if(currentY + _verticalDash < _dashedBorderObjectRef.height)
					this.graphics.lineTo( currentX , currentY + _verticalDash );
				else
					this.graphics.lineTo( currentX , _dashedBorderObjectRef.height);
			}
			
			for( currentY =  _dashedBorderObjectRef.height /* currentX = _dashedBorderObjectRef.width */ ;  
				 currentX > _horizintalDash ; 
				 currentX = currentX - _horizintalDash - _horizintalGap )
			{
				this.graphics.moveTo( currentX , currentY );
				if(currentX - _horizintalDash > 0)
					this.graphics.lineTo( currentX - _horizintalDash , currentY );
				else
					this.graphics.lineTo( 0 , currentY );
			}
			
			for( currentX = 0 /* currentY = currentY */;
				 currentY > _verticalDash ;
				 currentY = currentY - _verticalDash - _verticalGap )
			{
				this.graphics.moveTo( currentX , currentY );
				if(currentY - _verticalDash > 0)
					this.graphics.lineTo( currentX , currentY - _verticalDash );
				else
					this.graphics.lineTo( currentX , 0 );	
			}
		
			this.graphics.endFill();
		}
		
		//getters & setters
		///////////////////////////////////////////////
		public function get verticalDash() : Number
		{
			return _verticalDash;
		}
		
		public function get horizintalDash() : Number
		{
			return _horizintalDash;
		}
	}
}