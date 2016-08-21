package net.kaikoga.arp;

#if macro

import net.kaikoga.arp.macro.MacroArpObjectBuilder;
import haxe.macro.Expr.Field;

class ArpDomainMacros {

	public static function buildObject(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}
}

#end
