package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr.ExprOf;

enum MacroArpObjectFieldType {
	PrimInt;
	PrimFloat;
	PrimBool;
	PrimString;
	Reference(arpType:ExprOf<String>);
}

#end
