package net.kaikoga.arpx.faceList;

import net.kaikoga.arp.iter.ERegIterator;
import net.kaikoga.arp.structs.ArpRange;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("faceList", "faceList"))
class FaceList implements IArpObject
{
	@:arpField public var isVertical:Bool;
	@:arpField public var extraFaces:Array<String>;
	@:arpField public var chars:String;
	@:arpField public var range:ArpRange;
	@:arpField("value") public var csvFaces:String;

	public function new() {
	}

	public function toArray():Array<String> {
		var result:Array<String> = [];
		if (this.chars != null) for (char in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, this.chars)) result.push(char);
		if (this.range.hasValue) result = result.concat(this.range.split());
		if (this.csvFaces != null) result = result.concat(~/\s/g.replace(this.csvFaces, "").split(","));
		if (this.extraFaces != null) result = result.concat(this.extraFaces);
		return result;
	}
}
