package net.kaikoga.arpx.logger;

import net.kaikoga.arp.domain.events.ArpLogEvent;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("logger", "trace"))
class TraceLogger extends Logger {

	public function new() {
		super();
	}

	override public function log(event:ArpLogEvent):Void {
		if (!this.respondsTo(event.category)) return;
		trace("[" + event.category + "]", event.message);
	}
}


