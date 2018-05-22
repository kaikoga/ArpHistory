package net.kaikoga.arp;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Type.ClassType;
import haxe.macro.Type.Ref;
import haxe.macro.TypeTools;
import net.kaikoga.arp.macro.MacroArpClassDefinition;
import net.kaikoga.arp.macro.MacroArpObjectBuilder;
import net.kaikoga.arp.macro.MacroArpObjectRegistry;

class ArpDomainMacros {

	public static function autoBuildObject():Array<Field> {
		var localClass:Null<Ref<ClassType>> = Context.getLocalClass();
		if (localClass == null) return null;

		var classDef:MacroArpClassDefinition = new MacroArpClassDefinition(localClass.get());

		var builder:MacroArpObjectBuilder = new MacroArpObjectBuilder();
#if arp_macro_debug
		var arpTypeName:String = classDef.arpTypeName;
		var arpTemplateName:String = classDef.arpTemplateName;
		Sys.stdout().writeString(" ***** " + arpTypeName + ":" + arpTemplateName + " started\n");
		Sys.stdout().flush();
#end
		var fields = builder.run(classDef);
#if arp_macro_debug
		Sys.stdout().writeString(" ***** " + arpTypeName + ":" + arpTemplateName + " completed\n");
		Sys.stdout().flush();
#end
		return fields;
	}

	public static function buildStruct(arpTypeName:String):Array<Field> {
		MacroArpObjectRegistry.registerStructInfo(arpTypeName, TypeTools.toString(Context.getLocalType()));
		return null;
	}
}

#end
