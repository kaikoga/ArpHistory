package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arpx.paramsOp.filters.RewireParamsOpFilter;
import net.kaikoga.arpx.structs.ArpParams;
import net.kaikoga.arpx.structs.IArpParamsRead;

@:arpType("paramsOp", "rewire")
class RewireParamsOp extends ParamsOp {

	@:arpField public var copy:Bool;
	@:arpField public var fixedParams:ArpParams;
	@:arpField public var rewireParams:ArpParams;

	public function new() super();

	override public function filter(source:IArpParamsRead):IArpParamsRead return new RewireParamsOpFilter(this, source);
}
