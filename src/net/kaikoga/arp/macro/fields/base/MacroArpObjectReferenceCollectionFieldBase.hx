package net.kaikoga.arp.macro.fields.base;

#if macro

import haxe.macro.Expr;

class MacroArpObjectReferenceCollectionFieldBase extends MacroArpObjectCollectionFieldBase {

	private var contentNativeType:ComplexType;

	private function new(definition:MacroArpObjectFieldDefinition, contentNativeType:ComplexType, concreteDs:Bool) {
		super(definition, concreteDs);
		this.contentNativeType = contentNativeType;
	}

}

#end
