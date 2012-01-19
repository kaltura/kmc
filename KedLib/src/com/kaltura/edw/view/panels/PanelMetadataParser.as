package com.kaltura.edw.view.panels
{
	public class PanelMetadataParser
	{
		static public function parse(xml:XML):PanelMetadataVO{
			var vo:PanelMetadataVO = new PanelMetadataVO();
			var panelNodes:XMLList = xml.panel;
			for each (var node:XML in panelNodes){
				vo.urlMapping[node.@id] = String(node.@url);
				vo.orderMapping[node.@id] = uint(node.@index);
				
				if (node.attribute("styleName").length() > 0){
					vo.styleMapping[node.@id] = String(node.@styleName);
				}
				
				vo.panelNames.push(node.@id);
			}
			
			vo.panelNames = vo.panelNames.sort(
				function (itemA:String, itemB:String): int{
					var indexA:uint = vo.orderMapping[itemA] as uint;
					var indexB:uint = vo.orderMapping[itemB] as uint;
					return indexA - indexB;
				});
			
			return vo;
		}
	}
}