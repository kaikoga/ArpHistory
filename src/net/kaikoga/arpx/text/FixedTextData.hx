package net.kaikoga.arpx.text;

@:arpType("text")
class FixedTextData extends TextData {

	@:arpField public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:Map<String, Dynamic> = null):String {
		return this.value;
	}
}


