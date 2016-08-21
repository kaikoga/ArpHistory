package net.kaikoga.arp.structs;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.structs.ArpStructsUtil;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;

@:forward(
	keys,
	get,
	set,
	remove,
	initWithSeed,
	initWithString,
	clone,
	copyFrom,
	merge,
	filter,
	toString,
	readSelf,
	writeSelf
)
abstract ArpParamsProxy(ArpParams) from ArpParams to ArpParams {

	inline public function new(value:ArpParams) this = value;

	@:arrayAccess inline private function arrayGet(k:String):Dynamic return this.get(k);
	@:arrayAccess inline private function arraySet(k:String, v:Dynamic):Dynamic return this.set(k, v);
}

@:build(net.kaikoga.arp.ArpDomainMacros.buildStruct("Params"))
class ArpParams implements IPersistable {

	private var map:Map<String, Dynamic>;

	inline private function keys():Iterator<String> return this.map.keys();
	inline public function get(key:String):Dynamic return this.map.get(key);
	inline public function set(key:String, value:Dynamic):Dynamic {
		this.map.set(key, value);
		return value;
	}
	inline public function remove(key:String):Void this.map.remove(key);

	public function new() {
		this.map = new Map<String, Dynamic>();
	}


	public function initWithSeed(seed:ArpSeed):ArpParams {
		if (seed == null) return this;
		return initWithString(seed.value());
	}

	public function initWithString(definition:String):ArpParams {
		if (definition == null) return this;
		for (node in definition.split(",")) {
			var array:Array<String> = node.split(":");
			if (array.length == 1) {
				this.set("face", array[0]);
				continue;
			}
			var key:String = array[0];
			var value:String = array[1];
			var type:String = array[2];
			switch (type) {
				case "dir":
					this.set(key, new ArpDirection().initWithString(value));
				case "idir":
					this.set(key, new ArpDirection(Std.parseInt(value)));
				case "rewire":
					this.set(key, new ArpParamRewire(value));
				default:
					if (ArpStructsUtil.isNumeric(value)) {
						this.set(key, Std.parseFloat(value));
					} else {
						this.set(key, value);
					}
			}
		}
		return this;
	}

	public function clone():ArpParams {
		var result:ArpParams = new ArpParams();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpParams = null):ArpParams {
		for (name in this.keys()) {
			this.remove(name);
		}
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
			}
		}
		return this;
	}

	public function merge(source:ArpParams = null):ArpParams {
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
			}
		}
		return this;
	}

	public function filter(source:ArpParams = null):ArpParams {
		if (source != null) {
			for (name in source.keys()) {
				var value:Dynamic = this.get(name);
				if (Std.is(value, ArpParamRewire)) {
					this.set(name, this.get(value.rewireFrom));
				} else {
					this.set(name, source.get(name));
				}
			}
		}
		return this;
	}

	public function toString():String {
		var result:Array<Dynamic> = [];
		for (name in this.keys()) {
			var value:Dynamic = this.get(name);
			if (Std.is(value, ArpDirection)) {
				value = cast(value, ArpDirection).value + ":idir";
			}
			else if (Std.is(value, ArpParamRewire)) {
				value = cast(value, ArpParamRewire).rewireFrom + ":rewire";
			}
			result.push(name + ":" + Std.string(value));
		}
		return result.join(",");
	}

	public function readSelf(input:IPersistInput):Void {
		initWithString(input.readUtf("params"));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUtf("params", toString());
	}
}

class ArpParamRewire {
	public var rewireFrom:String;
	public function new(rewireFrom:String) {
		this.rewireFrom = rewireFrom;
	}
}
