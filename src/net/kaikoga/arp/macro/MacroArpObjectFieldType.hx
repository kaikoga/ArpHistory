package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr.ExprOf;

//FIXME we prefer interfaces to public enums
enum MacroArpObjectFieldType {
	PrimInt;
	PrimFloat;
	PrimBool;
	PrimString;
	Reference(arpType:ExprOf<String>);
}

#end
