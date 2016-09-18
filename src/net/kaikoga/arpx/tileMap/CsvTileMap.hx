package net.kaikoga.arpx.tileMap;

import net.kaikoga.arpx.faceList.FaceList;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("tileMap", "csv"))
class CsvTileMap extends ArrayTileMap {

	@:arpField("value") public var data:String;
	@:arpBarrier @:arpField public var faceList:FaceList;

	public function new() {
		super();
	}

	private function arrayContentToInt(item:String):Int {
		return faceList != null ? faceList.indexOf(item) : Std.parseInt(item);
	}

	override private function heatUp():Bool {
		if (!this.map) {
			this.map = [];
			for (row in ~/\s*(?:\r|\n|\r\n)+\s*/g.split(this.data || "")) {
				if (row != "") {
					var rowData:Array<Int> = row.split(~/\s*,\s*/g.map(arrayContentToInt));
					this.map.push(rowData);
					if (this.width < rowData.length) this.width = rowData.length;
				}
			}
		}
		if (this.height < this.map.length) this.height = this.map.length;
		return true;
	}
}


