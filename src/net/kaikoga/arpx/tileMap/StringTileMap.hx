package net.kaikoga.arpx.tileMap;

import net.kaikoga.arpx.faceList.FaceList;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("tileMap", "string"))
class StringTileMap extends ArrayTileMap {

	@:arpField public var data:String;
	@:arpBarrier @:arpField public var faceList:FaceList;

	public function new() {
		super();
	}

	private function arrayContentToInt(item:String):Int {
		return faceList.indexOf(item);
	}

	override private function heatUp():Bool {
		if (!this.map) {
			this.map = [];
			for (row in ~/\s*(?:\r|\n|\r\n)+\s*/g.split(this.data || "")) {
				if (row != null) {
					var rowData:Array<Int> = row.split("").map(arrayContentToInt);
					this.map.push(rowData);
					if (this.width < rowData.length) this.width = rowData.length;
				}
			}
		}
		if (this.height < this.map.length) this.height = this.map.length;
		return true;
	}
}


