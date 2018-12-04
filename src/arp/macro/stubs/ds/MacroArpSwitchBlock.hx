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

	public function pushCase(value:ExprOf<String>, pos:Position, caseBlock:Array<Expr>):Void {
		this.cases.push({
			values: [value],
			expr: { pos: pos, expr: ExprDef.EBlock(caseBlock)}
		});
	}

	public function toExpr(pos:Position):Expr {
		return { pos: pos, expr: ExprDef.ESwitch(this.e, this.cases, this.eDefault) };
	}

	private function toCases():Array<Case> {
		return this.cases;
	}
}
