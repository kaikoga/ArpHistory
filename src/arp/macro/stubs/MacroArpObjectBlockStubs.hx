package arp.macro.stubs;

import arp.macro.MacroArpObjectRegistry;
import haxe.macro.Context;
import haxe.macro.Expr;

@:noDoc @:noCompletion
class MacroArpObjectBlockStubs {

#if macro

	private static function getTemplate():MacroArpObject {
		return MacroArpObjectRegistry.getLocalMacroArpObject();
	}

#end

	macro public static function block(iFieldName:String, forPersist:Bool = false):Expr {
		var block:Array<Expr> = [];
		for (arpField in getTemplate().arpFields) {
			if (forPersist) {
				if (!arpField.isPersistable) continue;
			} else {
				macro null;
			}
			Reflect.callMethod(arpField, Reflect.field(arpField, iFieldName), [block]);
		}
		return macro @:mergeBlock $b{ block };
	}

	macro public static function arpConsumeSeedElementBlock():Expr {
		var cases:Array<Case> = [];

		var eDefault:Expr;
		if (getTemplate().classDef.isDerived) {
			eDefault = macro { super.arpConsumeSeedElement(element); }
		} else {
			eDefault = macro if (element.typeName != "value") throw new arp.errors.ArpLoadError(arpTypeInfo + " could not accept <" + element.typeName + ">");
		}
		var expr:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName, cases, eDefault) }

		for (arpField in getTemplate().arpFields) {
			if (arpField.isSeedable) arpField.buildConsumeSeedElementBlock(cases);
		}

		return expr;
	}
}
