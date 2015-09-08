package net.kaikoga.arp.structs;

import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.domain.seed.ArpSeed;

#if openfl
import openfl.geom.ColorTransform;
#elseif flash
import flash.geom.ColorTransform;
#end

#if (!(flash || cpp)) DONTCOMPILE #end

/**
	handled as mutable
*/
class ArpColor {

	public var value32:Int;

	public var value(get, set):Int;
	private function get_value():Int {
		return this.value32 & 0xffffff;
	}
	private function set_value(value:Int):Int {
		this.value32 = (value32 & 0xff000000) | (value & 0xffffff);
		return value;
	}

	public var alpha(get, set):Int;
	private function get_alpha():Int {
		return value32 >> 24;
	}
	private function set_alpha(value:Int):Int {
		this.value32 = (value << 24) | (value32 & 0xffffff);
		return value;
	}

	public function new(value:Int = 0x000000) {
		this.value32 = value | 0xff000000;
	}

	public function initWithSeed(seed:ArpSeed):ArpColor {
		if (seed == null) return this;
		return initWithString(seed.value());
	}

	public function initWithString(definition:String):ArpColor {
		if (definition == null) return this;
		var array:Array<String> = definition.split("@");
		var value:Int = ArpStructsUtil.parseHex(array[0].substring(1));
		var alpha:Int = (array[1] != null) ? ArpStructsUtil.parseHex(array[1]) : 0xff;
		this.value32 = (alpha << 24) | value;
		return this;
	}

	public function clone():ArpColor {
		return new ArpColor(this.value32);
	}

	public function copyFrom(source:ArpColor = null):ArpColor {
		this.value32 = source.value32;
		return this;
	}

	public function toString():String {
		return "[ArpColor #" + Std.string(this.value32) + " ]";
	}

	#if (flash || openfl)

	public function toMultiplier():ColorTransform {
		return new ColorTransform(
			((this.value32 >> 16) & 0xff) / 0xff,
			((this.value32 >> 8) & 0xff) / 0xff,
			((this.value32 >> 0) & 0xff) / 0xff,
			((this.value32 >> 24) & 0xff) / 0xff
		);
	}

	public function toOffset():ColorTransform {
		return new ColorTransform(
			0,
			0,
			0,
			0,
			((this.value32 >> 16) & 0xff),
			((this.value32 >> 8) & 0xff),
			((this.value32 >> 0) & 0xff),
			((this.value32 >> 24) & 0xff)
		);
	}

	public function toColorize():ColorTransform {
		var a:Float = ((this.value32 >> 24) & 0xff) / 0xff;
		var b:Float = 1 - a;
		return new ColorTransform(
			b,
			b,
			b,
			1,
			((this.value32 >> 16) & 0xff) * a,
			((this.value32 >> 8) & 0xff) * a,
			((this.value32 >> 0) & 0xff) * a,
			0
		);
	}

	#end

	public function readSelf(input:IPersistInput):Void {
		this.value32 = input.readUInt32("color");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUInt32("color", this.value32);
	}
}


