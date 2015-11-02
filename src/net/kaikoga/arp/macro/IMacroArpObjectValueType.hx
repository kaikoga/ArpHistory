package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;

interface IMacroArpObjectValueType {

	function createEmptyVo(pos:Position):Expr;
	function createSeedElement(pos:Position):Expr;
	function readSeedElement(pos:Position, iFieldName:String):Expr;
	function readSelf(pos:Position, iFieldName:String):Expr;
	function writeSelf(pos:Position, iFieldName:String):Expr;

}

#end
