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
package com.kaltura.controls.kobjecthadles.managers
{
	import com.kaltura.controls.kobjecthadles.cursors.LeftRightCursor;
	import com.kaltura.controls.kobjecthadles.cursors.NESWCursor;
	import com.kaltura.controls.kobjecthadles.cursors.NWSECursor;
	import com.kaltura.controls.kobjecthadles.cursors.UpDownCursor;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	
	public class HandleCursorManager
	{
		public static var handleCursorManager : HandleCursorManager;
		
		
		private static var _isDragging : Boolean = false;

		public static const NONE : String = "none";
		public static const LEFT : String = "left";
		public static const RIGHT : String = "right";
		public static const UP : String = "up";
		public static const DOWN : String = "down";
		public static const UP_LEFT : String = "upLeft";
		public static const UP_RIGHT : String = "upRight";
		public static const DOWN_LEFT : String = "downLeft";
		public static const DOWN_RIGHT : String = "downRight";
		public static const MOVE : String = "move";
		public static const Rotate : String = "rotate";
		private static var _action : String = NONE;
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////
		public static const NS_CURSOR_X_OFFSET : Number = -5;
		public static const NS_CURSOR_Y_OFFSET : Number = -10;

		public static const WE_CURSOR_X_OFFSET : Number = -10;
		public static const WE_CURSOR_Y_OFFSET : Number = -5;
	
		public static const MOVE_CURSOR_X_OFFSET : Number = -8;
		public static const MOVE_CURSOR_Y_OFFSET : Number = -8;
		[Embed(source="/com/kaltura/controls/kobjecthadles/assets/cursors/light/SizeAll.png")] [Bindable] public var cursorMoveCls:Class;
		
		public static const NWSE_CURSOR_X_OFFSET : Number = -8;
		public static const NWSE_CURSOR_Y_OFFSET : Number = -8;
		
		public static const NESW_CURSOR_X_OFFSET : Number = -8;
		public static const NESW_CURSOR_Y_OFFSET : Number = -8;
		
		[Embed(source="/com/kaltura/controls/kobjecthadles/assets/cursors/light/cursor-closedhand.png")] [Bindable] public var cursorRotateCls:Class;
		
	
		private var _currentObjectRotation : Number = 0;
		private var _cosAbsRotation : Number = 1;
		private var _sinAbsRotation : Number = 0;
		private var _cursorId : int;
		//private var _draggedIconRef : Sprite;
		private var _currentContainerRef : DisplayObjectContainer;
		///////////////////////////////////////////////////////////////////////////////////////////
		
		public function setCursorHandle( action : String , container : DisplayObjectContainer ) : void
		{
			if(_isDragging)
				return;
			
			if(_action == action)
				return;
			
			CursorManager.removeAllCursors();
			
			_currentContainerRef = container;
						
			if( action == LEFT || action == RIGHT )
			{
				CursorManager.setCursor( LeftRightCursor , CursorManagerPriority.MEDIUM , WE_CURSOR_X_OFFSET  , WE_CURSOR_Y_OFFSET ); 
			}
			else if(  action == UP || action == DOWN )
			{
				CursorManager.setCursor( UpDownCursor , CursorManagerPriority.MEDIUM , NS_CURSOR_X_OFFSET , NS_CURSOR_Y_OFFSET ); 
			}
			else if( action == UP_LEFT || action == DOWN_RIGHT )
			{
				CursorManager.setCursor(  NWSECursor , CursorManagerPriority.MEDIUM , NWSE_CURSOR_X_OFFSET , NWSE_CURSOR_Y_OFFSET ); 
			}
			else if( action == UP_RIGHT || action == DOWN_LEFT)
			{
				CursorManager.setCursor(  NESWCursor , CursorManagerPriority.MEDIUM , NESW_CURSOR_X_OFFSET , NESW_CURSOR_Y_OFFSET ); 
			}
			else if( action == MOVE && (_action == NONE || _action == MOVE))
			{
				CursorManager.setCursor( cursorMoveCls , CursorManagerPriority.MEDIUM , MOVE_CURSOR_X_OFFSET , MOVE_CURSOR_Y_OFFSET ); 
			}
			else if ( action == Rotate)
			{
				CursorManager.setCursor( cursorRotateCls , CursorManagerPriority.MEDIUM , MOVE_CURSOR_X_OFFSET , MOVE_CURSOR_Y_OFFSET ); 
			}
			
			_action = action;
		}
		
		public function setIsDragging( isDragging : Boolean ) : void
		{
			if( !isDragging )
				CursorManager.removeAllCursors();			
			
			_isDragging = isDragging;
		}
		
		public function setRotation( angle : Number ) : void
		{
			_currentObjectRotation = angle;
		}
		
		//getters & setters
		///////////////////////////////////////////////////
		
		public function get isDragging() : Boolean
		{
			return _isDragging
		}
		
		public function get currentObjectRotation() : Number
		{
			return _currentObjectRotation;
		}
		
		// singleton: constructor only allows one HandleCursorManager
		public function HandleCursorManager()
		{
			if ( HandleCursorManager.handleCursorManager != null )
				throw new Error( "Only one HandleCursorManager instance should be instantiated" );	
		}
		
		// singleton: always returns the one existing static instance to itself
		public static function getInstance() : HandleCursorManager 
		{
			if ( handleCursorManager == null )
				handleCursorManager = new HandleCursorManager();
				
			return handleCursorManager;
		}
	}
}
