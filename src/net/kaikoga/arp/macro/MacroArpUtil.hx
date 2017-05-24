package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;
import haxe.macro.Context;

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
}

#end
