package com.kaltura.edw.components.fltr.indicators {
	import com.kaltura.containers.BoundedFlowBox;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.controls.ButtonLabelPlacement;
	import mx.core.ScrollPolicy;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

		
	[Event(name="boxClicked", type="com.kaltura.edw.components.fltr.indicators.IndicatorsEvent")]
	
	public class Indicators extends BoundedFlowBox {

		
		/**
		 * all the data for the component.
		 * IndicatorVo objects 
		 */
		protected var collection:ArrayCollection;

		/**
		 * Indicator objects for all vos. 
		 */
		protected var indicators:Array;

		/**
		 * Constructor
		 *
		 */
		public function Indicators() {
			super();
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			if (!collection) {
				dataProvider = new ArrayCollection();
			}
				
			addEventListener(BoundedFlowBox.ROWS_LIMIT_EXCEEDED, onExceeded, false, 0, true);
		}


		[Bindable("collectionChange")]
		public function get dataProvider():ArrayCollection {
			return collection;
		}


		public function set dataProvider(value:ArrayCollection):void {
			if (collection) {
				collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
			}

			collection = value;
			collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);

			var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			event.kind = CollectionEventKind.RESET;
			collectionChangeHandler(event);
			dispatchEvent(event);

			invalidateProperties();
			invalidateSize();
//			invalidateDisplayList();
		}


		/**
		 * Handles CollectionEvents dispatched from the data provider as the data changes.
		 * @param event The CollectionEvent.
		 */
		private function collectionChangeHandler(e:CollectionEvent):void {
			var wrapVo:Indicator;
			// remove any existing buttons from view
			for each (wrapVo in indicators) {
				if (wrapVo.button.parent == this) {
					removeChild(wrapVo.button);
				}
			}
			
			if (e.kind == CollectionEventKind.RESET) {
				// reset array
				indicators = new Array();
			}
			// create buttons for all vos in collection:
			var hasBtn:Boolean;
			for each (var ivo:IndicatorVo in collection) {
				hasBtn = false;
				for each (wrapVo in indicators) {
					if (wrapVo.vo == ivo) {
						hasBtn = true;
						break;
					}
				}
				if (!hasBtn) {
					wrapVo = new Indicator();
					wrapVo.vo = ivo;
					wrapVo.button = createButton(ivo);
					indicators.push(wrapVo);
				}
				addChild(wrapVo.button);
			}
			// do layout 
			invalidateDisplayList();
		}

		private function createButton(ivo:IndicatorVo):Button {
			var box:Button = new Button();
			box.label = ivo.label;
			box.toolTip = ivo.tooltip;
			box.labelPlacement = ButtonLabelPlacement.LEFT;
			box.setStyle("styleName", "indicatorBoxStyle");
			box.addEventListener(MouseEvent.CLICK, handleBoxClicked, false, 0, true);
			return box;
		}
		
		
		/**
		 * let the world know the box was clicked
		 * @param e
		 */
		private function handleBoxClicked(e:MouseEvent):void {
			for each (var wrap:Indicator in indicators) {
				if (wrap.button == e.target) {
					dispatchEvent(new IndicatorsEvent(IndicatorsEvent.BOX_CLICKED, wrap.vo));
					break;
				}
			} 
		}

		private function onExceeded(e:Event):void {
			e.stopImmediatePropagation();
			trace("exceeded:", numChildren, collection.length - numChildren);
		}
	}
}

import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
import mx.controls.Button;

class Indicator {
	public var button:Button;
	public var vo:IndicatorVo;
}