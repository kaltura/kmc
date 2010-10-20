package com.kaltura.controls.tooltips
{
	 import flash.display.Bitmap;
	 import flash.events.Event;

	 import mx.containers.*;
	 import mx.controls.Image;
	 import mx.controls.Label;
	 import mx.core.*;

     public class ExtendToolTip extends VBox implements IToolTip
     {
         private var image:Bitmap = new Bitmap();
         private var lbl:Label;
         private var imageHolder:Image;
         private var tipText:String;

         
         public function set ImageTip(img:*):void{
             if(img is Class){
             imageHolder.source = new img().bitmapData;
             }
             if(img as String){
                 imageHolder.load(img);
             }
         }

         [Bindable]
         public function set TipText(txt:String):void{
             lbl.text = txt;
         }
         public function get TipText():String{
             return tipText;
         }
         public function ExtendToolTip()
         {
             mouseEnabled = false;
             mouseChildren = false;
             setStyle("paddingLeft",0);
             setStyle("paddingRight",0);
             setStyle("paddingTop",0);
             setStyle("paddingBottom",0);
             setStyle("backgroundAlpha",0);
             setStyle("backgroundColor",0xffffff);
             imageHolder = new Image();
             lbl  = new  Label();
             imageHolder.addEventListener(Event.COMPLETE, imageLoaded, false, 0, true);
             imageHolder.source = image;
             addChild(imageHolder);
             addChild(lbl);
         }
         private function imageLoaded (event:Event):void
         {
         	this.minWidth = imageHolder.contentWidth;
         	this.minHeight = imageHolder.contentHeight;
         }
         public function get text():String
         {
             return null;
         }
         [Bindable]
         public function set text(value:String):void    {
             tipText = value;
         }
     }
}