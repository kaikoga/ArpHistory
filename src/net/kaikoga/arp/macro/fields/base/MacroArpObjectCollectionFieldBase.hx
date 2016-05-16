package net.kaikoga.arp.macro.fields.base;

#if macro

import haxe.macro.Expr;

class MacroArpObjectCollectionFieldBase extends MacroArpCollectionFieldBase {

	private var contentNativeType:ComplexType;

	override private function get_arpType():String return MacroArpObjectRegistry.arpTypeOf(contentNativeType).toString();

	override private function createEmptyDs(concreteNativeTypePath:TypePath):Expr {
		return macro new $concreteNativeTypePath(slot.domain);
	}

	private function new(definition:MacroArpFieldDefinition, contentNativeType:ComplexType, concreteDs:Bool) {
		super(definition, concreteDs);
		this.contentNativeType = contentNativeType;
	}
}

#end
