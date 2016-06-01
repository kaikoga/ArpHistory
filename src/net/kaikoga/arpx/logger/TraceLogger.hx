package net.kaikoga.arpx.logger;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("logger", "trace"))
class TraceLogger extends Logger {

	public function new() {
		super();
	}

	override public function log(category:String, message:String):Void {
		if (!this.respondsTo(category)) return;
		trace("[" + category + "]", message);
	}
}


