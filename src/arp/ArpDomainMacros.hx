package arp;

#if macro

import arp.macro.defs.MacroArpClassDefinition;
import arp.macro.MacroArpObjectBuilder;
import arp.macro.MacroArpObjectRegistry;
import arp.macro.MacroArpUtil;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.MetadataEntry;
import haxe.macro.ExprTools;
import haxe.macro.Type.ClassType;

class ArpDomainMacros {

	public static function autoBuildObject():Array<Field> {
		var localClass:ClassType = MacroArpUtil.getLocalClass();
		if (localClass == null) return null;

		var classDef:MacroArpClassDefinition = new MacroArpClassDefinition(localClass);
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

	public static function autoBuildStruct():Array<Field> {
		var localClass:ClassType = MacroArpUtil.getLocalClass();
		if (localClass == null) return null;

		var metaArpStruct:MetadataEntry = localClass.meta.extract(":arpStruct")[0];

		var arpTypeName:String = null;
		if (metaArpStruct != null) {
			arpTypeName = ExprTools.getValue(metaArpStruct.params[0]);
		}

		var fqn:String = MacroArpUtil.getFqnOfBaseType(localClass);
		MacroArpObjectRegistry.registerStructInfo(arpTypeName, fqn);
		return null;
	}
}

#end
