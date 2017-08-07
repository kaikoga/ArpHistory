package net.kaikoga.arp.structs;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

class ArpParamsMacros {

	@:allow(net.kaikoga.arp.structs.ArpParams)
	macro private static function getSafe():Expr {
		var safeCast:Expr = {
			pos: Context.currentPos(),
			expr: ExprDef.ECast(macro d, TypeTools.toComplexType(Context.getExpectedType()))
		};
		return macro @:mergeBlock {
			var d:Dynamic = this.get(key);
			var v = if (d == null) null else $e{ safeCast };
			return v;
		}
	}

	@:allow(net.kaikoga.arp.structs.ArpParams)
	macro private static function getAsString():Expr {
		return macro @:mergeBlock {
			var d:Dynamic = this.get(key);
			var v = if (d == null) null else Std.string(d);
			return v;
		}
	}
}

