package net.kaikoga.arp.structs;

import net.kaikoga.arp.ds.access.IMapWrite;
import net.kaikoga.arp.ds.access.IMapRead;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.utils.ArpStringUtil;

@:forward
abstract ArpParamsProxy(ArpParams) from ArpParams to ArpParams {

	inline public function new(value:ArpParams) this = value;

	@:arrayAccess inline private function arrayGet(k:String):Dynamic return this.get(k);
	@:arrayAccess inline private function arraySet(k:String, v:Dynamic):Dynamic { this.set(k, v); return v; }
}

@:build(net.kaikoga.arp.ArpDomainMacros.buildStruct("Params"))
class ArpParams
implements IPersistable
implements IMapRead<String, Dynamic>
implements IMapWrite<String, Dynamic>
{
	public var isUniqueKey(get, never):Bool;
	inline private function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	inline private function get_isUniqueValue():Bool return false;

	private var map:Map<String, Dynamic>;

	inline public function isEmpty():Bool return !this.map.iterator().hasNext();

	inline public function keys():Iterator<String> return this.map.keys();
	inline public function iterator():Iterator<Dynamic> return this.map.iterator();

	inline public function hasKey(k:String):Bool return this.map.exists(k);
	public function hasValue(v:Dynamic):Bool { for (x in this.map) if (x == v) return true; return false; }

	inline public function get(k:String):Dynamic return this.map.get(k);
	inline public function set(k:String, v:Dynamic):Void this.map.set(k, v);

	public function removeKey(k:String):Bool {
		if (this.map.exists(k)) {
			this.map.remove(k); return true;
		}
		return false;
	}
	inline public function clear():Void this.map = new Map<String, Dynamic>();

	public function new() {
		this.map = new Map<String, Dynamic>();
	}

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

	public function copyFrom(source:ArpParams = null):ArpParams {
		this.clear();
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
