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
	import com.kaltura.controls.kobjecthadles.KObjectHandles;
	import com.kaltura.controls.kobjecthadles.managers.HandleCursorManager;
	import com.kaltura.controls.kobjecthadles.managers.HandleDisplayManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.Container;

	public class HandleBase extends Sprite
	{
		public static const SQUARE : String = "square";
		public static const CIRCLE : String = "circle";
		private var _shapeType : String = SQUARE;
		
		protected var p_containerRef : Container;
		protected var p_squareSize : Number;
		protected var p_color : Number 
		protected var p_isDefaultLook : Boolean;
		protected var p_fillColor : uint;
		protected var p_fillAlph : Number;
		
		public function HandleBase( container : Container , 
									defaultLook : Boolean = true , 
									userIcon : Class = null ,
									fillColor : uint = 0x000000 ,
									fillAlph : Number = 1 ,
									squareSize : Number = 8 ,
									shapeType : String =  SQUARE )
		{
			super();
			
			p_containerRef = container;
			p_isDefaultLook = defaultLook;
			p_fillColor = fillColor;
			p_fillAlph = fillAlph;
			p_squareSize = squareSize;
			
			_shapeType = shapeType;
			
			if( defaultLook )
			{
				createGraphic();
			}
			else
			{
				//set this sprite as userIcon;
			}
			
			container.rawChildren.addChild(this);
			
			this.addEventListener( MouseEvent.MOUSE_MOVE , mouseMoveHandler ); 
			this.addEventListener( MouseEvent.ROLL_OUT , rollOutHandler );
			this.addEventListener( MouseEvent.MOUSE_DOWN , mouseDownHandler );
		}
			
		protected function createGraphic() : void
		{
			if( _shapeType == SQUARE )
			{
				this.graphics.beginFill( p_fillColor ,p_fillAlph );
				this.graphics.drawRect(0, 0, p_squareSize, p_squareSize);
				this.graphics.endFill();
			}
			else if( _shapeType == CIRCLE )
			{
				this.graphics.beginFill( p_fillColor ,p_fillAlph );
				this.graphics.drawCircle(0, 0, p_squareSize/2 );
				this.graphics.endFill();
			}

			
			var hitArea : Sprite = new Sprite();
			hitArea.graphics.beginFill( 0xCCCCCC ,0 );
			hitArea.graphics.drawRect(-p_squareSize, -p_squareSize, 2*p_squareSize, 2*p_squareSize);
			hitArea.graphics.endFill();
			hitArea.mouseEnabled = false;
			this.hitArea = hitArea;
			this.addChild( hitArea );
		}
		
		protected function recreateGraphic() : void
		{
			this.graphics.clear();
			createGraphic();
		}
		
		protected function mouseDownHandler( event : MouseEvent) : void
		{
			if(this.stage)
			{
				HandleCursorManager.getInstance().setIsDragging( true );
				this.removeEventListener( MouseEvent.MOUSE_MOVE , mouseMoveHandler ); 
				this.removeEventListener( MouseEvent.ROLL_OUT , rollOutHandler );
				this.stage.addEventListener( MouseEvent.MOUSE_MOVE , stageMouseMoveHandler , false , 0 , true);
				this.stage.addEventListener( MouseEvent.MOUSE_UP , stageMouseUpHandler , false , 0 , true );
			}	
		}
			
		protected function rollOutHandler( event : MouseEvent ) : void
		{
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.NONE , this.stage ); // disable the cursor before seting the move 
			HandleCursorManager.getInstance().setCursorHandle( HandleCursorManager.MOVE , this.stage );
		}

		protected function stageMouseUpHandler( event : MouseEvent ) : void
		{
			HandleCursorManager.getInstance().setIsDragging( false );
			this.addEventListener( MouseEvent.MOUSE_MOVE , mouseMoveHandler ); 
			this.addEventListener( MouseEvent.ROLL_OUT , rollOutHandler );
			(event.currentTarget).removeEventListener( MouseEvent.MOUSE_MOVE , stageMouseMoveHandler );
			(event.currentTarget).removeEventListener( MouseEvent.MOUSE_UP , stageMouseUpHandler ); 	
		}
		
		protected function mouseMoveHandler( event : MouseEvent ) : void {}
		protected function stageMouseMoveHandler( event : MouseEvent ) : void {}
		
		//getters & setters
		///////////////////////////////////////////////////////////////
		
	}
}