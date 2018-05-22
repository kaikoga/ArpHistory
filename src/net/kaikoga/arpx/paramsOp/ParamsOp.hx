package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.structs.IArpParamsRead;

@:arpType("paramsOp", "null")

class ParamsOp implements IArpObject {

	public function new() {
	}

	public function filter(source:IArpParamsRead):IArpParamsRead return source;
}
