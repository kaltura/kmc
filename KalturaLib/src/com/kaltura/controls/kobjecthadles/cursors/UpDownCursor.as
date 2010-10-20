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
package com.kaltura.controls.kobjecthadles.cursors
{
	import com.kaltura.controls.kobjecthadles.managers.HandleCursorManager;
	
	import flash.display.Sprite;
	
	import mx.core.BitmapAsset;
	import mx.effects.Rotate;

	public class UpDownCursor extends Sprite
	{
		[Embed(source="/com/kaltura/controls/kobjecthadles/assets/cursors/light/SizeNS.png")] [Bindable] public var CursorNSCls:Class;
		private var rottationEffect : Rotate;
		public function UpDownCursor()
		{
			super();
			var bitmapAsset : BitmapAsset = new CursorNSCls();
			
			rottationEffect = new Rotate( bitmapAsset );
			rottationEffect.duration = 1;
			rottationEffect.originX = bitmapAsset.width/2;
			rottationEffect.originY = bitmapAsset.height/2;
			rottationEffect.angleFrom = 0;
			rottationEffect.angleTo = HandleCursorManager.getInstance().currentObjectRotation;
			rottationEffect.play();
			addChild( bitmapAsset );
		}
		
	}
}
