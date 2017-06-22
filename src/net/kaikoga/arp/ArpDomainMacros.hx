package net.kaikoga.arp;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.MetadataEntry;
import haxe.macro.ExprTools;
import haxe.macro.Type;
import haxe.macro.Type.ClassType;
import haxe.macro.Type.Ref;
import haxe.macro.TypeTools;
import net.kaikoga.arp.macro.MacroArpObjectRegistry;
import net.kaikoga.arp.macro.MacroArpObjectBuilder;

class ArpDomainMacros {

	public static function autoBuildObject():Array<Field> {
		var localClass:Null<Ref<ClassType>> = Context.getLocalClass();
		if (localClass != null) {
			var meta:MetadataEntry = localClass.get().meta.extract(":arpObject")[0];
			if (meta != null) {
				var typeMeta:Expr = meta.params[0];
				var templateMeta:Expr = meta.params[1];
				var type:String = typeMeta != null ? ExprTools.getValue(typeMeta) : null;
				var template:String = templateMeta != null ? ExprTools.getValue(templateMeta) : null;
				return buildObject(type, template);
			}
			Context.error("@:arpObject required", Context.currentPos());
		}
		// maybe current class is an interface, so silently ignore
		return null;
	}

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
