package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;

interface IMacroArpObjectField {
	public function buildField(outFields:Array<Field>):Void;
	public function buildInitBlock(initBlock:Array<Expr>):Void;
	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void;
	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void;
	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void;
}

#end
