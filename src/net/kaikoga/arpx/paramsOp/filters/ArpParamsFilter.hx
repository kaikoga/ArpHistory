package net.kaikoga.arpx.paramsOp.filters;

import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.ArpParamsMacros;
import net.kaikoga.arp.structs.IArpParamsRead;

@:access(net.kaikoga.arp.structs.ArpParamsMacros)
class ArpParamsFilter implements IArpParamsRead {
	private var params:IArpParamsRead;
	public function new(params:IArpParamsRead) this.params = params;

	public function getInt(key:String, defaultValue:Int = null):Null<Int> return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloat(key:String, defaultValue:Float = null):Null<Float> return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getString(key:String, defaultValue:String = null):String return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBool(key:String, defaultValue:Bool = null):Null<Bool> return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirection(key:String, defaultValue:ArpDirection = null):ArpDirection return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);

	public function getAsString(key:String, defaultValue:String = null):String return ArpParamsMacros.getAsString(key, defaultValue);

	public function get(key:String):Dynamic return this.params.get(key);
	public function keys():Iterator<String> return this.params.keys();

	public function toString():String return this.params.toString();
}

