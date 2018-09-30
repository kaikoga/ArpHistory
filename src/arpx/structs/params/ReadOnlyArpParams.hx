package arpx.structs.params;

import arp.ds.impl.StdMap;
import arpx.structs.ArpDirection;
import arpx.structs.macro.ArpParamsMacros;

class ReadOnlyArpParams implements IArpParamsRead {

	private var impl:StdMap<String, Dynamic>;

	public function new() this.impl = new StdMap<String, Dynamic>();

	inline public function get(key:String):Dynamic return this.impl.get(key);
	inline public function keys():Iterator<String> return this.impl.keys();

	public function getInt(key:String, defaultValue = null):Null<Int> return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloat(key:String, defaultValue = null):Null<Float> return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getString(key:String, defaultValue = null):String return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBool(key:String, defaultValue = null):Null<Bool> return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirection(key:String, defaultValue = null):ArpDirection return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);

	public function getAsString(key:String, defaultValue = null):String return ArpParamsMacros.getAsString(key, defaultValue);

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
}
