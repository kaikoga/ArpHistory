package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;

interface IMacroArpObjectValueType {

	function getSeedElement(pos:Position):Expr;
	function readSelf(pos:Position, iFieldName:String):Expr;
	function writeSelf(pos:Position, iFieldName:String):Expr;

}

#end
