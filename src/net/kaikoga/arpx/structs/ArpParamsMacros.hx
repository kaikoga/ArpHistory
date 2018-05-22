package net.kaikoga.arpx.structs;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

class ArpParamsMacros {

	macro public static function getSafe(key:Expr, defaultValue:Expr, classExpr:Expr):Expr {
		var safeCast:Expr = {
			pos: Context.currentPos(),
			expr: ExprDef.ECast(macro d, TypeTools.toComplexType(Context.getExpectedType()))
		};
		return macro @:mergeBlock {
			var d:Dynamic = this.get($e{ key });
			var v = if (d == null) $e{ defaultValue } else if (!Std.is(d, $e{classExpr})) throw "Wrong type in ArpParams" else $e{ safeCast };
			return v;
		}
	}

	macro public static function getAsString(key:Expr, defaultValue:Expr):Expr {
		return macro @:mergeBlock {
			var d:Dynamic = this.get($e{ key });
			var v = if (d == null) $e{ defaultValue } else Std.string(d);
			return v;
		}
	}
}
