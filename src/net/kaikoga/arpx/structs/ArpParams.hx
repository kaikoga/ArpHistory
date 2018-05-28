package net.kaikoga.arpx.structs;

import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.utils.ArpStringUtil;
import net.kaikoga.arpx.structs.ArpDirection;
import net.kaikoga.arpx.structs.macro.ArpParamsMacros;

@:forward
abstract ArpParamsProxy(ArpParams) from ArpParams to ArpParams {

	inline public function new(value:ArpParams) this = value;

	@:arrayAccess inline private function arrayGet(k:String):Dynamic return this.get(k);
	@:arrayAccess inline private function arraySet(k:String, v:Dynamic):Dynamic { this.set(k, v); return v; }
}

@:build(net.kaikoga.arp.ArpDomainMacros.buildStruct("Params"))
class ArpParams implements IPersistable implements IArpParamsRead {
	private var map:StdMap<String, Dynamic>;

	public function new() this.map = new StdMap<String, Dynamic>();

	inline public function get(key:String):Dynamic return this.map.get(key);
	inline public function keys():Iterator<String> return this.map.keys();

	public function getInt(key:String, defaultValue = null):Null<Int> return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloat(key:String, defaultValue = null):Null<Float> return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getString(key:String, defaultValue = null):String return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBool(key:String, defaultValue = null):Null<Bool> return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirection(key:String, defaultValue = null):ArpDirection return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);

	public function getAsString(key:String, defaultValue = null):String return ArpParamsMacros.getAsString(key, defaultValue);

	inline public function set(key:String, value:Dynamic):Void return this.map.set(key, value);
	inline public function clear():Void return this.map.clear();

	public function initWithSeed(seed:ArpSeed):ArpParams {
		if (seed == null) return this;
		return initWithString(seed.value);
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
				default:
					if (ArpStringUtil.isNumeric(value)) {
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

	public function copyFrom(source:IArpParamsRead = null):ArpParams {
		this.clear();
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
			}
		}
		return this;
	}

	public function merge(source:IArpParamsRead = null):ArpParams {
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
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
