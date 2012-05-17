package com.hillelcoren.assets.skins
{
	import flash.display.Graphics;
	
	import mx.skins.ProgrammaticSkin;
	
	public class UnregisteredFacebookSkin extends ProgrammaticSkin
	{
		public function UnregisteredFacebookSkin()
		{
			super();
		}
		
		protected static const RADIUS:int = 10;
		
		override protected function updateDisplayList( w:Number, h:Number ):void 
		{	
			var color:uint;
			var borderColor:uint;
			
			switch (name) 
			{
				case "upSkin":
					color 		= 0xFFFFFF;
					borderColor = 0xCCD5E4;
					break;
				case "overSkin":
					color		= 0xDDDDDD;
					borderColor = 0xCCD5E4;
					break;
				case "downSkin":
				case "selectedUpSkin":
				case "selectedOverSkin":
				case "selectedDownSkin":
					color 		= 0xAAAAAA;
					borderColor = 0x3B5998;
			}
			
			var g:Graphics = graphics;
			g.clear();
			g.beginFill( color );
			g.lineStyle( 1, borderColor );
			g.drawRoundRect( 0, 1, w, h-2, RADIUS );
			g.endFill();
		}
	}
}