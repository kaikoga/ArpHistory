package arp.macro.stubs.ds;

import haxe.macro.Expr;

class MacroArpSwitchBlock {

	private var e:Expr;
	private var cases:Array<Case>;
	public var eDefault:Expr;

	public function new(e:Expr) {
		this.e = e;
		this.cases = [];
	}

	public function push(c:Case):Void {
		this.cases.push(c);
	}

	public function toExpr(pos:Position):Expr {
		return { pos: pos, expr: ExprDef.ESwitch(this.e, this.cases, this.eDefault) };
	}

	private function toCases():Array<Case> {
		return this.cases;
	}
}
