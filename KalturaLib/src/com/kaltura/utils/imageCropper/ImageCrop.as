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
	import mx.events.PropertyChangeEvent;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;

	public class ImageCrop extends UIComponent {
		public static var LOADED:String = "imagecrop.loaded";
		
		private var imageLoader:Loader = new Loader();
		private var _image:Bitmap;
		public var cropBox:CropBox = new CropBox();
		public var maxImageHeight:int;
		public var maxImageWidth:int;

		
		public function ImageCrop() {
		}

		public function get image():Bitmap
		{
			return _image;
		}

		public function set image(value:Bitmap):void
		{
			_image = value;
		}

		public function loadImage(imageUri:String):void {
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageComplete); 
			ExternalInterface.call( "console.log", "loading:" + imageUri);
			imageLoader.load(new URLRequest(imageUri));
		}

		private function loadImageComplete(e:Event):void {
			ExternalInterface.call( "console.log", "loading complete");
			ExternalInterface.call( "console.log", "size width:" + this.width + " height:" + this.height);
			image = Bitmap(e.target.loader.content);
			if ((maxImageHeight > 0) && (image.height>maxImageHeight)) {
				cropBox.heightRatio = maxImageHeight/image.height;
				image.height = maxImageHeight;
			}
			if ((maxImageWidth > 0) && (image.width>maxImageWidth)) {
				cropBox.widthRatio = maxImageWidth/image.width;
				image.width = maxImageWidth;
			}

			imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImageComplete); 

			this.width = image.width;
			this.height = image.height;
			
			this.addChild(image);

			//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			this.addChild(cropBox);
			cropBox.width = width;
			cropBox.height = height;

			ExternalInterface.call( "console.log", "size width:" + this.width + " height:" + this.height);
			this.dispatchEvent(new Event(LOADED));
			
			
		}
		
		public function mouseMoveEvent(me:MouseEvent):void {
			cropBox.mouseMoveEvent(me);
		}
		public function mouseUpEvent(me:MouseEvent):void {
			cropBox.mouseUpEvent(me);
		}
	}
}