package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.paramsOp.filters.RewireParamsOpFilter;

@:arpType("paramsOp", "rewire")
class RewireParamsOp extends ParamsOp {

	@:arpField public var copy:Bool;
	@:arpField public var fixedParams:ArpParams;
	@:arpField public var rewireParams:ArpParams;

	public function new() super();

	override public function filter(source:IArpParamsRead):IArpParamsRead return new RewireParamsOpFilter(this, source);
}
