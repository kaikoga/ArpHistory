package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;
import arpx.text.TextData;

@:arpType("faceList", "text")
class TextDataFaceList extends ArrayFaceList {

	@:arpField public var format:String;
	@:arpField public var text:ISet<TextData>;

	public function new() super();

	override private function heatUp():Bool {
		if (!super.heatUp()) return false;
		for (v in text) {
			var text:String = v.publish();
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(text, "").split(",")) this.add(face);
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, text)) this.add(face);
			}
		}
		return true;
	}
}
