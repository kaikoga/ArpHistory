package arp.macro.stubs;

import arp.macro.stubs.ds.MacroArpSwitchBlock;
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
		var cases:MacroArpSwitchBlock = new MacroArpSwitchBlock(macro element.seedName);

		if (getTemplate().classDef.isDerived) {
			cases.eDefault = macro { super.arpConsumeSeedElement(element); }
		} else {
			cases.eDefault = macro if (element.seedName != "value") throw new arp.errors.ArpLoadError(arpTypeInfo + " could not accept <" + element.seedName + ">");
		}

		for (arpField in getTemplate().arpFields) {
			if (arpField.isSeedable) arpField.buildConsumeSeedElementBlock(cases);
		}

		return cases.toExpr(Context.currentPos());
	}
}
