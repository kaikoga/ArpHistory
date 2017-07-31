package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("paramsOp", "paramsOp")

class ParamsOp implements IArpObject {

	@:arpField public var copy:Bool;
	@:arpField public var fixedParams:ArpParams;
	@:arpField public var rewireParams:ArpParams;

	public function new() {
	}

	public function filter(source:ArpParams, out:ArpParams = null):ArpParams {
		if (out == null) out = new ArpParams();
		out.clear();
		if (this.copy) out.copyFrom(source);
		for (k in fixedParams.keys()) {
			out.set(k, fixedParams.get(k));
		}
		for (k in rewireParams.keys()) {
			out.set(k, source.get(rewireParams.get(k)));
		}
		return out;
	}
}


