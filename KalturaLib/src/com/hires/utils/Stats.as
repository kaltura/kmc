/**
 * Hi-ReS! Stats v1.3
 *
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * How to use:
 *
 * 	addChild( new Stats() );
 *
 * version log:
 *
 *	08.07.12		1.3		Mr.doob			+ Some speed and code optimisations
 *	08.02.15		1.2		Mr.doob			+ Class renamed to Stats (previously FPS)
 *	08.01.05		1.2		Mr.doob			+ Click changes the fps of flash (half up increases,
 *									  half down decreases)
 *	08.01.04		1.1		Mr.doob & Theo		+ Log shape for MEM
 * 									+ More room for MS
 * 									+ Shameless ripoff of Alternativa's FPS look ;)
 * 	07.12.13		1.0		Mr.doob			+ First version
 **/

package com.hires.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class Stats extends UIComponent
	{
		private var graph : BitmapData;

		private var fpsText : TextField, msText : TextField, memText : TextField, format : TextFormat;

		private var fps :int, timer : int, ms : int, msPrev	: int = 0;
		private var mem : Number = 0;

		public function Stats( ):void
		{
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplete);
		}

		private function creationComplete (event:FlexEvent):void
		{
			buildStatsMonitor ();
		}

		private function buildStatsMonitor ():void
		{
			graph = new BitmapData( 60, 50, false, 0x333 );
			var gBitmap:Bitmap = new Bitmap( graph );
			gBitmap.y = 35;
			addChild(gBitmap);

			format = new TextFormat( "_sans", 9 );

			graphics.beginFill(0x333);
			graphics.drawRect(0, 0, 60, 50);
			graphics.endFill();

			fpsText = new TextField();
			msText = new TextField();
			memText = new TextField();

			fpsText.defaultTextFormat = msText.defaultTextFormat = memText.defaultTextFormat = format;
			fpsText.width = msText.width = memText.width = 60;
			fpsText.selectable = msText.selectable = memText.selectable = false;

			fpsText.textColor = 0xFFFF00;
			fpsText.text = "FPS: ";
			addChild(fpsText);

			msText.y = 10;
			msText.textColor = 0x00FF00;
			msText.text = "MS: ";
			addChild(msText);

			memText.y = 20;
			memText.textColor = 0x00FFFF;
			memText.text = "MEM: ";
			addChild(memText);

			addEventListener(MouseEvent.CLICK, mouseHandler);
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function mouseHandler( e:MouseEvent ):void
		{
			if (this.mouseY > this.height * .35)
				stage.frameRate --;
			else
				stage.frameRate ++;

			fpsText.text = "FPS: " + fps + " / " + stage.frameRate;
		}

		private function update( e:Event ):void
		{
			timer = getTimer();
			fps++;

			if( timer - 1000 > msPrev )
			{
				msPrev = timer;
				//show memory in MB
				mem = Number( ( System.totalMemory / 1048576 ).toFixed(3) );

				var fpsGraph : int = Math.min( 50, 50 / stage.frameRate * fps );
				var memGraph:Number =  Math.min( 50, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;

				graph.scroll( 1, 0 );
				graph.fillRect( new Rectangle( 0, 0, 1, graph.height ), 0x333 );
				graph.setPixel( 0, graph.height - fpsGraph, 0xFFFF00);
				graph.setPixel( 0, graph.height - ( ( timer - ms ) >> 1 ), 0x00FF00 );
				graph.setPixel( 0, graph.height - memGraph, 0x00FFFF);

				fpsText.text = "FPS: " + fps + " / " + stage.frameRate;
				memText.text = "MEM: " + mem;

				fps = 0;
			}

			msText.text = "MS: " + (timer - ms);
			ms = timer;
		}
	}
}