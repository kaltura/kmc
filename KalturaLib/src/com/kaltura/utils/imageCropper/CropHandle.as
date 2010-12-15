/*
Copyright 2010 Terrence Curran - Approaching Pi

Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package com.kaltura.utils.imageCropper {
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.core.*;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;

	public class CropHandle extends UIComponent {
		public var borderColor:Number = 0x000000;
		public var borderOverColor:Number = 0xFF0000;
		public var fillAlpha:Number = .5;
		public var fillColor:Number = 0xFFFFFF;
		public var size:Number = 10;

		private var _over:Boolean;
		private var _selected:Boolean;
		
		public function CropHandle() {
		}

		private function onMouseOver(param1:MouseEvent) : void {
			_over = true;
			invalidateDisplayList();
		}

		public function set selected(param1:Boolean) : void {
			_selected = param1;
			invalidateDisplayList();
		}

		override protected function createChildren() : void {
			super.createChildren();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}

		private function onMouseOut(param1:MouseEvent) : void {
			_over = false;
			invalidateDisplayList();
			return;
		}

		override protected function updateDisplayList(param1:Number, param2:Number) : void {
			super.updateDisplayList(param1, param2);
			graphics.clear();

			if (_over || _selected){
				graphics.lineStyle(1, borderOverColor, 0.4, true, LineScaleMode.NONE);
			} else{
				graphics.lineStyle(1, borderColor, 1, true, LineScaleMode.NONE);
			}

			graphics.moveTo(0, 0);
			graphics.beginFill(fillColor, fillAlpha);
			graphics.drawRect(-size/2, -size/2, size, size);

			graphics.endFill();
			graphics.beginFill(16777215, 1);
			graphics.endFill();
		}
	}
}