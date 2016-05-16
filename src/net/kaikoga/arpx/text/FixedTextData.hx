package net.kaikoga.arpx.text;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("text"))
class FixedTextData extends TextData {

	@:arpField public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:Map<String, Dynamic> = null):String {
		return this.value;
	}
}


