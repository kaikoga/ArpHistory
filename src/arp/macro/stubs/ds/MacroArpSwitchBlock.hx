package arp.macro.stubs.ds;

import haxe.macro.ExprTools;
import haxe.macro.Expr;

class MacroArpSwitchBlock {

	private var e:Expr;
	private var cases:Map<String, {c:Case, priority:Int}>;
	public var eDefault:Expr;

	public function new(e:Expr) {
		this.e = e;
		this.cases = [];
	}

	public function pushCase(eValue:ExprOf<String>, pos:Position, caseBlock:Array<Expr>, priority:Int = 0):Void {
		var value:String = ExprTools.getValue(eValue);
		if (this.cases.exists(value) && this.cases.get(value).priority >= priority) return;
		this.cases.set(value, {
			c: {
				values: [eValue],
				expr: { pos: pos, expr: ExprDef.EBlock(caseBlock)}
			},
			priority: priority
		});
	}

	public function toExpr(pos:Position):Expr {
		return { pos: pos, expr: ExprDef.ESwitch(this.e, this.toCases(), this.eDefault) };
	}

	private function toCases():Array<Case> {
		return [for (v in this.cases) v.c];
	}
}
