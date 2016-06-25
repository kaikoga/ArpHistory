package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;

interface IMacroArpValueType {

	function nativeType():ComplexType;
	function arpFieldType():ArpFieldType;
	function createEmptyVo(pos:Position):Expr;
	function createSeedElement(pos:Position):Expr;
	function readSeedElement(pos:Position, iFieldName:String):Expr;
	function readSelf(pos:Position, eField:Expr, fieldName:String):Expr;
	function writeSelf(pos:Position, eField:Expr, fieldName:String):Expr;
	function copyFrom(pos:Position, iFieldName:String):Expr;

}

#end
