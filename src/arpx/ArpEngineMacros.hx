package arpx;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;

class ArpEngineMacros {

	public static function init():Void {
		if (getFlag("arp_engine_init")) return;
		setFlag("arp_engine_init");

		if (getFlag("arp_backend_flash")) setDefine("arp_backend", "flash");
		if (getFlag("arp_backend_openfl")) setDefine("arp_backend", "openfl");
		if (getFlag("arp_backend_heaps")) setDefine("arp_backend", "heaps");

		var dArpBackend:String = getDefine("arp_backend");
		if (dArpBackend == null) {
			if (getFlag("flash") ) {
				setFlag("arp_backend_flash");
			} else {
				setFlag("arp_backend_openfl");
			}
		}
	}

	inline private static function getDefine(name:String):String {
		return Context.definedValue(name);
	}
	inline private static function getFlag(name:String):Bool {
		return getDefine(name) != null;
	}

	inline private static function setDefine(name:String, value:String):String {
		if (getDefine(name) != null) throw 'Failed to set ${name} to ${value}, was ${getDefine(name)}'
		Compiler.define(name, value);
		return value;
	}
	inline private static function setFlag(name:String, value:Bool = true):Bool {
		setDefine(name, value ? "1" : null);
		return value;
	}

}

#end
