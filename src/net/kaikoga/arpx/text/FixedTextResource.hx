package net.kaikoga.arpx.text;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("text"))
class FixedTextResource extends TextResource {

	@:arpValue public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:Map<String, Dynamic> = null):String {
		return this.value;
	}
}


