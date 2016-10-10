package net.kaikoga.arpx.tileMap;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("tileMap", "string"))
class StringTileMap extends ArrayTileMap {

	@:arpField("value") public var data:String;

	public function new() {
		super();
	}

	private function arrayContentToInt(item:String):Int {
		return faceList != null ? faceList.indexOf(item) : Std.parseInt(item);
	}

	override private function heatUp():Bool {
		if (this.map == null) {
			this.map = [];
			if (this.data != null) {
				for (row in ~/\s*(?:\r|\n|\r\n)+\s*/g.split(this.data)) {
					if (row != "") {
						var rowData:Array<Int> = row.split("").map(arrayContentToInt);
						this.map.push(rowData);
						if (this.width < rowData.length) this.width = rowData.length;
					}
				}
			}
		}
		if (this.height < this.map.length) this.height = this.map.length;
		return true;
	}
}


