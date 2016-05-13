package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;

interface IMacroArpValueType {

	function nativeType():ComplexType;
	function createEmptyVo(pos:Position):Expr;
	function createSeedElement(pos:Position):Expr;
	function readSeedElement(pos:Position, iFieldName:String):Expr;
	function readSelf(pos:Position, iFieldName:String, eColumnName:String):Expr;
	function writeSelf(pos:Position, iFieldName:String, eColumnName:String):Expr;
	function copyFrom(pos:Position, iFieldName:String):Expr;

}

#end
