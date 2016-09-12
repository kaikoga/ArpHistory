package net.kaikoga.arpx.faceList;

import net.kaikoga.arp.iter.ERegIterator;
import net.kaikoga.arp.structs.ArpRange;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("faceList", "faceList"))
class FaceList implements IArpObject {

	@:arpField public var isVertical:Bool;
	@:arpField public var extraFaces:Array<String>;
	@:arpField public var chars:String;
	@:arpField public var range:ArpRange;
	@:arpField("value") public var csvFaces:String;

	private var arrayValue:Array<String>;

	public function new() {
	}

	@:arpHeatUp
	private function heatUp():Bool {
		var result:Array<String> = [];
		if (this.chars != null) for (char in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, this.chars)) result.push(char);
		if (this.range.hasValue) result = result.concat(this.range.split());
		if (this.csvFaces != null) result = result.concat(~/\s/g.replace(this.csvFaces, "").split(","));
		if (this.extraFaces != null) result = result.concat(this.extraFaces);
		this.arrayValue = result;
		return true;
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		return true;
	}

	public var length(get, never):Int;
	public function get_length():Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.length;
	}

	public function indexOf(name:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.indexOf(name);
	}

	public function get(index:Int):String {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue[index];
	}

	public function toArray():Array<String> {
		return this.arrayValue.copy();
	}
}
