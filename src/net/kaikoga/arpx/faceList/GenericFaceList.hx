package net.kaikoga.arpx.faceList;

import net.kaikoga.arp.iterators.ERegIterator;
import net.kaikoga.arp.structs.ArpRange;

@:arpType("faceList", "faceList")
class GenericFaceList extends FaceList {

	@:arpField public var isVertical:Bool;
	@:arpField public var extraFaces:Array<String>;
	@:arpField public var chars:String;
	@:arpField public var range:ArpRange;
	@:arpField("value") public var csvFaces:String;

	private var arrayValue:Array<String>;

	public function new() super();

	@:arpHeatUp
	private function heatUp():Bool {
		var result:Array<String> = [];
		if (this.chars != null) for (char in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, this.chars)) result.push(char);
		if (this.range.hasValue) result = result.concat(this.range.split());
		if (this.csvFaces != null) result = result.concat(~/\s/g.replace(this.csvFaces, "").split(","));
		if (this.extraFaces != null) result = result.concat(this.extraFaces);
		if (result.length == 0) result.push("");
		this.arrayValue = result;
		return true;
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		return true;
	}

	override private function get_length():Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.length;
	}

	override public function indexOf(name:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.indexOf(name);
	}

	override public function get(index:Int):String {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue[index];
	}

	override public function iterator():Iterator<String> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}
}
