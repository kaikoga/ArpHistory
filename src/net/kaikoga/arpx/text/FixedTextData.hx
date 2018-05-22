package net.kaikoga.arpx.text;

import net.kaikoga.arpx.structs.ArpParams;

@:arpType("text")
class FixedTextData extends TextData {

	@:arpField public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:ArpParams = null):String {
		return this.value;
	}
}


