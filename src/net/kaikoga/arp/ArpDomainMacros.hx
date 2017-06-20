package net.kaikoga.arp;

#if macro

import haxe.macro.Context;
import haxe.macro.TypeTools;
import net.kaikoga.arp.macro.MacroArpObjectRegistry;
import net.kaikoga.arp.macro.MacroArpObjectBuilder;
import haxe.macro.Expr.Field;

class ArpDomainMacros {

	public static function buildObject(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
#if arp_macro_debug
		Sys.stdout().writeString(arpTypeName + ":" + arpTemplateName + " started\n");
		Sys.stdout().flush();
#end
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		var v = new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
#if arp_macro_debug
		Sys.stdout().writeString(arpTypeName + ":" + arpTemplateName + " completed\n");
		Sys.stdout().flush();
#end
		return v;
	}

	public static function buildStruct(arpTypeName:String):Array<Field> {
		MacroArpObjectRegistry.registerStructInfo(arpTypeName, TypeTools.toString(Context.getLocalType()));
		return null;
	}
}

#end
