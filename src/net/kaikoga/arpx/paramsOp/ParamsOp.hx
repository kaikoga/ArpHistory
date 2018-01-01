package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("paramsOp", "paramsOp")

class ParamsOp implements IArpObject {

	@:arpField public var copy:Bool;
	@:arpField public var fixedParams:ArpParams;
	@:arpField public var rewireParams:ArpParams;

	public function new() {
	}

	public function filter(source:IArpParamsRead):IArpParamsRead return new ParamsOpFilter(this, source);
}

class ParamsOpFilter extends ArpParamsFilter {
	private var paramsOp:ParamsOp;

	public function new(paramsOp:ParamsOp, source:IArpParamsRead) {
		super(source);
		this.paramsOp = paramsOp;
	}

	override public function get(key:String):Dynamic {
		var value:Dynamic;
		if (this.paramsOp.copy) {
			value = super.get(key);
			if (value != null) return value;
		}
		value = this.paramsOp.fixedParams.get(key);
		if (value != null) return value;
		value = super.get(this.paramsOp.rewireParams.get(key));
		if (value != null) return value;
		return null;
	}

	override public function keys():Iterator<String> {
		return if (this.paramsOp.copy) {
			new ArpParams().merge(this.paramsOp.fixedParams).merge(this.paramsOp.rewireParams).keys();
		} else {
			new ArpParams().merge(this.params).merge(this.paramsOp.fixedParams).merge(this.paramsOp.rewireParams).keys();
		}
	}
}
