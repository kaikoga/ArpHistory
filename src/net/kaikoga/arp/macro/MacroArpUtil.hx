package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;

class MacroArpUtil {

	public static function error(message:String, pos:Position):Void {
		Context.error(message, pos);
#if arp_macro_debug
		throw message;
#end
	}

	public static function fatal<T>(message:String, pos:Position):T {
		Context.error(message, pos);
		throw message;
		return null;
	}

	public static function getFqnOfType(type:Type):String {
		switch (TypeTools.follow(type)) {
			case Type.TInst(c, _): return getFqnOfBaseType(c.get());
			case Type.TEnum(c, _): return getFqnOfBaseType(c.get());
			case Type.TType(c, _): return getFqnOfBaseType(c.get());
			case Type.TAbstract(c, _): return getFqnOfBaseType(c.get());
			case _: throw "invalid type " + TypeTools.toString(type);
		}
		return null;
	}

	public static function getFqnOfBaseType(baseType:BaseType):String {
		var p = baseType.module.split(".");
		if (p[p.length - 1] != baseType.name) p.push(baseType.name);
		return p.join(".");
	}
}

#end
