package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.ArpTypeInfo;
import haxe.macro.Printer;
import net.kaikoga.arp.macro.MacroArpObjectFieldBuilder;
import haxe.macro.Expr;
import haxe.macro.Context;

class MacroArpObjectBuilder {

	public static function build(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}

	public static function buildDerived(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName, true).run();
	}

	private var outFields:Array<Field> = [];

	private var arpTypeName:String;
	private var arpTemplateName:String;
	private var isDerived:Bool;
	private var arpObjectFields:Array<IMacroArpObjectField> = [];

	private var _arpDomain:Field = null;
	private var arpDomain:Field = null;
	private var _arpTypeInfo:Field = null;
	private var arpTypeInfo:Field = null;
	private var arpType:Field = null;
	private var _arpSlot:Field = null;
	private var arpSlot:Field = null;
	private var arpInit:Field = null;
	private var arpHeatLater:Field = null;
	private var arpHeatUp:Field = null;
	private var arpHeatDown:Field = null;
	private var arpDispose:Field = null;
	private var arpConsumeSeedElement:Field = null;
	private var readSelf:Field = null;
	private var writeSelf:Field = null;

	private var dummyInit:Bool;
	private var dummyDispose:Bool;
	private var dummyHeatUp:Bool;
	private var dummyHeatDown:Bool;

	private function new(arpTypeName:String, arpTemplateName:String, isDerived:Bool = false) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
		this.isDerived = isDerived;
		this.outFields = [];

		this.dummyInit = !isDerived;
		this.dummyDispose = !isDerived;
		this.dummyHeatUp = !isDerived;
		this.dummyHeatDown = !isDerived;
	}

	private function run():Array<Field> {
		for (field in Context.getBuildFields()) {
			switch (field.name) {
				case "_arpDomain":
					this._arpDomain = field;
				case "arpDomain":
					this.arpDomain = field;
				case "_arpTypeInfo":
					this._arpTypeInfo = field;
				case "arpTypeInfo":
					this.arpTypeInfo = field;
				case "arpType":
					this.arpType = field;
				case "_arpSlot":
					this._arpSlot = field;
				case "arpSlot":
					this.arpSlot = field;
				case "arpInit":
					this.arpInit = field;
				case "arpHeatLater":
					this.arpHeatLater = field;
				case "arpHeatUp":
					this.arpHeatUp = field;
				case "arpHeatDown":
					this.arpHeatDown = field;
				case "arpDispose":
					this.arpDispose = field;
				case "arpConsumeSeedElement":
					this.arpConsumeSeedElement = field;
				case "readSelf":
					this.readSelf = field;
				case "writeSelf":
					this.writeSelf = field;
				case "init":
					this.dummyInit = false;
					this.outFields.push(field);
				case "dispose":
					this.dummyDispose = false;
					this.outFields.push(field);
				case "heatUp":
					this.dummyHeatUp = false;
					this.outFields.push(field);
				case "heatDown":
					this.dummyHeatDown = false;
					this.outFields.push(field);
				default:
					var arpObjectField:IMacroArpObjectField = MacroArpObjectFieldBuilder.fromField(field);
					if (arpObjectField == null) {
						this.outFields.push(field);
					} else {
						this.arpObjectFields.push(arpObjectField);
						arpObjectField.buildField(this.outFields);
					}
				}
		}
		if (!isDerived) buildArpDomain();
		buildArpTypeInfo();
		buildArpType();
		if (!isDerived) buildArpSlot();
		buildArpInit();
		buildArpHeatLater();
		buildArpHeatUp();
		buildArpHeatDown();
		buildArpDispose();
		buildArpConsumeSeedElement();
		buildReadSelf();
		buildWriteSelf();
		return this.outFields;
	}

	private function funBodyOf(field:Field):Expr {
		switch (field.kind) {
			case FieldType.FFun(f): return f.expr;
			case _: return macro null;
		}
	}

	private function fieldSkeleton(name:String, field:Null<Field>, isPublic:Bool, isStatic:Bool = false):Field {
		var access:Array<Access> = [isPublic ? Access.APublic : Access.APrivate];
		if (isDerived && !isStatic) access.push(Access.AOverride);
		if (isStatic) access.push(Access.AStatic);
		return (field != null) ? field : { name: name, access: access, kind: null, pos: Context.currentPos() }
	}

	private function buildArpDomain():Void {
		this._arpDomain = fieldSkeleton("_arpDomain", this._arpDomain, false);
		this._arpDomain.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpDomain);
		this.outFields.push(this._arpDomain);

		this.arpDomain = fieldSkeleton("arpDomain", this.arpDomain, true);
		this.arpDomain.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpDomain,
			expr: macro @:pos(this.arpDomain.pos) { return this._arpDomain; }
		});
		this.outFields.push(this.arpDomain);
	}

	private function buildArpTypeInfo():Void {
		this._arpTypeInfo = fieldSkeleton("_arpTypeInfo", this._arpTypeInfo, true, true);
		var value:ExprOf<ArpTypeInfo> = macro @:pos(this._arpTypeInfo.pos) {
			new net.kaikoga.arp.domain.ArpTypeInfo(
				$v{arpTemplateName},
				new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName})
			);
		};
		this._arpTypeInfo.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpTypeInfo, value);
		this.outFields.push(this._arpTypeInfo);

		this.arpTypeInfo = fieldSkeleton("arpTypeInfo", this.arpTypeInfo, true);
		this.arpTypeInfo.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpTypeInfo,
			expr: macro @:pos(this.arpTypeInfo.pos) {return _arpTypeInfo;}
		});
		this.outFields.push(this.arpTypeInfo);
	}

	private function buildArpType():Void {
		this.arpType = fieldSkeleton("arpType", this.arpType, true);
		this.arpType.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.core.ArpType,
			expr: macro @:pos(this.arpType.pos) {return _arpTypeInfo.arpType;}
		});
		this.outFields.push(this.arpType);
	}

	private function buildArpSlot():Void {
		this._arpSlot = fieldSkeleton("_arpSlot", this._arpSlot, false);
		this._arpSlot.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot);
		this.outFields.push(this._arpSlot);

		this.arpSlot = fieldSkeleton("arpSlot", this.arpSlot, true);
		this.arpSlot.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot,
			expr: macro @:pos(this.arpSlot.pos) { return this._arpSlot; }
		});
		this.outFields.push(this.arpSlot);
	}

	private function buildArpInit():Void {
		var initBlock:Array<Expr> = [];

		var e:Expr =
		if (isDerived) {
			macro @:pos(Context.currentPos()) {
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
				return super.arpInit(slot, seed);
			}
		} else {
			macro @:pos(Context.currentPos()) {
				this._arpDomain = slot.domain;
				this._arpSlot = slot;
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
				if (seed != null) for (element in seed) this.arpConsumeSeedElement(element);
				this.init();
				return this;
			}
		};

		for (aoField in this.arpObjectFields) aoField.buildInitBlock(initBlock);

		this.arpInit = fieldSkeleton("arpInit", this.arpInit, true);
		this.arpInit.kind = FieldType.FFun({
			args: [
				{ name: "slot", type: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot },
				{ name: "seed", type: macro :net.kaikoga.arp.domain.seed.ArpSeed, value: macro null }
			],
			ret: macro :net.kaikoga.arp.domain.IArpObject,
			expr: e
		});
		this.outFields.push(this.arpInit);

		if (this.dummyInit) {
			var init:Field = fieldSkeleton("init", null, true);
			init.kind = FieldType.FFun({ args: [], ret: null, expr: macro null });
			this.outFields.push(init);
		}
	}

	private function buildArpHeatLater():Void {
		var heatLaterBlock:Array<Expr> = [];

		var e:Expr =
		if (isDerived) {
			macro {
				super.arpHeatLater();
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(heatLaterBlock)} };
			}
		} else {
			macro {
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(heatLaterBlock)} };
			}
		};

		for (aoField in this.arpObjectFields) aoField.buildHeatLaterBlock(heatLaterBlock);

		this.arpHeatLater = fieldSkeleton("arpHeatLater", this.arpHeatLater, true);
		this.arpHeatLater.kind = FieldType.FFun({
			args: [],
			ret: null,
			expr: e
		});
		this.outFields.push(this.arpHeatLater);
	}

	private function buildArpHeatUp():Void {
		var heatUpBlock:Array<Expr> = [];

		var e:Expr = macro {
			return this.heatUp();
		}

		for (aoField in this.arpObjectFields) aoField.buildHeatUpBlock(heatUpBlock);

		this.arpHeatUp = fieldSkeleton("arpHeatUp", this.arpHeatUp, true);
		this.arpHeatUp.kind = FieldType.FFun({
			args: [],
			ret: macro :Bool,
			expr: e
		});
		this.outFields.push(this.arpHeatUp);

		if (this.dummyHeatUp) {
			var heatUp:Field = fieldSkeleton("heatUp", null, true);
			heatUp.kind = FieldType.FFun({ args: [], ret: macro :Bool, expr: macro { return true; } });
			this.outFields.push(heatUp);
		}
	}

	private function buildArpHeatDown():Void {
		var heatDownBlock:Array<Expr> = [];

		var e:Expr = macro {
			return this.heatDown();
		}

		for (aoField in this.arpObjectFields) aoField.buildHeatDownBlock(heatDownBlock);

		this.arpHeatDown = fieldSkeleton("arpHeatDown", this.arpHeatDown, true);
		this.arpHeatDown.kind = FieldType.FFun({
			args: [],
			ret: macro :Bool,
			expr: e
		});
		this.outFields.push(this.arpHeatDown);

		if (this.dummyHeatDown) {
			var heatDown:Field = fieldSkeleton("heatDown", null, true);
			heatDown.kind = FieldType.FFun({ args: [], ret: macro :Bool, expr: macro { return true; } });
			this.outFields.push(heatDown);
		}
	}

	private function buildArpDispose():Void {
		var disposeBlock:Array<Expr> = [];

		var e:Expr = macro {
		this.dispose();
		${ { pos: Context.currentPos(), expr: ExprDef.EBlock(disposeBlock)} };
		this._arpDomain = null;
		this._arpSlot = null;
		}

		for (aoField in this.arpObjectFields) aoField.buildDisposeBlock(disposeBlock);

		this.arpDispose = fieldSkeleton("arpDispose", this.arpDispose, true);
		this.arpDispose.kind = FieldType.FFun({
			args: [],
			ret: null,
			expr: e
		});
		this.outFields.push(this.arpDispose);

		if (this.dummyDispose) {
			var dispose:Field = fieldSkeleton("dispose", null, true);
			dispose.kind = FieldType.FFun({ args: [], ret: null, expr: macro null });
			this.outFields.push(dispose);
		}
	}

	private function buildArpConsumeSeedElement():Void {
		var cases:Array<Case> = [];

		var eDefault:Expr = if (isDerived) macro { super.arpConsumeSeedElement(element); } else macro null;
		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, eDefault) }

		for (aoField in this.arpObjectFields) aoField.buildConsumeSeedElementBlock(cases);

		this.arpConsumeSeedElement = fieldSkeleton("arpConsumeSeedElement", this.arpConsumeSeedElement, false);
		this.arpConsumeSeedElement.kind = FieldType.FFun({
			args: [
				{ name: "element", type: macro :net.kaikoga.arp.domain.seed.ArpSeed }
			],
			ret: null,
			expr: e
		});
		this.outFields.push(this.arpConsumeSeedElement);
	}

	private function buildReadSelf():Void {
		var fieldBlock:Array<Expr> = [];

		var e:Expr =
		if (isDerived) {
			macro {
				super.readSelf(input);
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)} };
			}
		} else {
			macro {
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)} };
			}
		};

		for (aoField in this.arpObjectFields) aoField.buildReadSelfBlock(fieldBlock);

		this.readSelf = fieldSkeleton("readSelf", this.readSelf, true);
		this.readSelf.kind = FieldType.FFun({
			args: [
				{ name: "input", type: macro :net.kaikoga.arp.persistable.IPersistInput }
			],
			ret: null,
			expr: e
		});
		this.outFields.push(this.readSelf);
	}

	private function buildWriteSelf():Void {
		var fieldBlock:Array<Expr> = [];

		var e:Expr =
		if (isDerived) {
			macro {
				super.writeSelf(output);
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)} };
			}
		} else {
			macro {
				${ { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)} };
			}
		};

		for (aoField in this.arpObjectFields) aoField.buildWriteSelfBlock(fieldBlock);

		this.writeSelf = fieldSkeleton("writeSelf", this.writeSelf, true);
		this.writeSelf.kind = FieldType.FFun({
			args: [{name: "output", type: macro :net.kaikoga.arp.persistable.IPersistOutput}],
			ret: null,
			expr: e
		});
		this.outFields.push(this.writeSelf);
	}
}

#end
