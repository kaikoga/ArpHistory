package net.kaikoga.arp;

#if macro

import haxe.macro.Context;
import haxe.macro.TypeTools;
import net.kaikoga.arp.macro.MacroArpObjectRegistry;
import net.kaikoga.arp.macro.MacroArpObjectBuilder;
import haxe.macro.Expr.Field;

class ArpDomainMacros {

	public static function buildObject(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}

	public static function buildStruct(arpTypeName:String):Array<Field> {
		MacroArpObjectRegistry.registerStructInfo(arpTypeName, TypeTools.toString(Context.getLocalType()));
		return null;
	}
}

#end
