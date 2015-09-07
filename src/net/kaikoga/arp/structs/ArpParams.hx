package net.kaikoga.arp.structs;

import net.kaikoga.arp.structs.ArpStructsUtil;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;

typedef ArpParamsImpl = Map<String, Dynamic>;

abstract ArpParams(ArpParamsImpl) from ArpParamsImpl to ArpParamsImpl {

	public function new(value:ArpParamsImpl = null) this = (value == null) ? new ArpParamsImpl() : value;

	public function initWithSeed(seed:ArpSeed):ArpParams {
		if (seed == null) return this;
		return initWithString(seed.value());
	}

	public function initWithString(definition:String):ArpParams {
		if (definition == null) return this;
		for (node in definition.split(",")) {
			var array:Array<String> = node.split(":");
			if (array.length == 1) {
				this["face"] = array[0];
				continue;
			}
			var key:String = array[0];
			var value:String = array[1];
			var type:String = array[2];
			switch (type) {
				case "dir":
					this[key] = new ArpDirection(Std.parseInt(value));
				case "rewire":
					this[key] = new ArpParamRewire(value);
				default:
					if (ArpStructsUtil.isNumeric(value)) {
						this[key] = Std.parseFloat(value);
					} else {
						this[key] = value;
					}
					break;
			}
		}
		return this;
	}

	public function clone():ArpParams {
		var result:ArpParams = new ArpParamsImpl();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpParams = null):ArpParams {
		var name:String;
		for (name in this.keys()) {
			this.remove(name);
		}
		if (source != null) {
			for (name in source.impl().keys()) {
				this[name] = source[name];
			}
		}
		return this;
	}

	public function merge(source:ArpParams = null):ArpParams {
		if (source != null) {
			for (name in source.impl().keys()) {
				this[name] = source[name];
			}
		}
		return this;
	}

	public function filter(source:ArpParams = null):ArpParams {
		if (source != null) {
			for (name in source.impl().keys()) {
				var value:Dynamic = this[name];
				if (Std.is(value, ArpParamRewire)) {
					this[name] = this[value.rewireFrom];
				} else {
					this[name] = source[name];
				}
			}
		}
		return this;
	}

	public function addParam(name:String, value:String):ArpParams {
		this[name] = value;
		return this;
	}

	public function toString():String {
		var result:Array<Dynamic> = [];
		for (name in impl().keys()) {
			var value:Dynamic = this[name];
			if (Std.is(value, ArpDirection)) {
				value = cast(value, ArpDirection).value + ":dir";
			}
			else if (Std.is(value, ArpParamRewire)) {
				value = cast(value, ArpParamRewire).rewireFrom + ":rewire";
			}
			result.push(name + ":" + Std.string(value));
		}
		return result.join(",");
	}

	/*
	public function readSelf(input:IPersistInput):Void {
		this.initWithString(input.readUTF("params"));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUTF("params", Std.string(this));
	}
	*/

	@:arrayAccess inline private function arrayGet(k:String):Dynamic return this[k];
	@:arrayAccess inline private function arraySet(k:String, v:Dynamic):Dynamic return this[k] = v;
	inline private function impl():ArpParamsImpl return this;
}

class ArpParamRewire {
	public var rewireFrom:String;
	public function new(rewireFrom:String) {
		this.rewireFrom = rewireFrom;
	}
}
