package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.MacroArpObjectFieldBuilder;
import haxe.macro.Expr;
import haxe.macro.Context;

class MacroArpObjectBuilder {

	public static function build(arpTypeName:String):Array<Field> {
		return new MacroArpObjectBuilder(arpTypeName).run();
	}

	private var outFields:Array<Field> = [];

	private var arpTypeName:String;
	private var arpObjectFields:Array<IMacroArpObjectField> = [];

	private var _arpDomain:Field = null;
	private var arpDomain:Field = null;
	private var arpType:Field = null;
	private var arpSlot:Field = null;
	private var _arpSlot:Field = null;
	private var arpInit:Field = null;
	private var arpHeatLater:Field = null;
	private var arpHeatUp:Field = null;
	private var arpHeatDown:Field = null;
	private var arpDispose:Field = null;
	private var arpConsumeSeedElement:Field = null;
	private var readSelf:Field = null;
	private var writeSelf:Field = null;

	private var dummyInit:Bool = true;
	private var dummyDispose:Bool = true;
	private var dummyHeatUp:Bool = true;
	private var dummyHeatDown:Bool = true;

	private function new(arpTypeName:String) {
		this.arpTypeName = arpTypeName;
		this.outFields = [];
	}

	private function run():Array<Field> {
		for (field in Context.getBuildFields()) {
			switch (field.name) {
				case "_arpDomain":
					this._arpDomain = field;
				case "arpDomain":
					this.arpDomain = field;
				case "arpType":
					this.arpType = field;
				case "arpSlot":
					this.arpSlot = field;
				case "_arpSlot":
					this._arpSlot = field;
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
		build_arpDomain();
		buildArpDomain();
		buildArpType();
		buildArpSlot();
		build_arpSlot();
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
			case _: return macro { null; };
		}
	}

	inline private function fieldSkeleton(name:String, field:Null<Field>, isPublic:Bool):Field {
		return (field != null) ? field : { name: name, access: [isPublic ? Access.APublic : Access.APrivate], kind: null, pos: Context.currentPos() }
	}

	private function build_arpDomain():Void {
		this._arpDomain = fieldSkeleton("_arpDomain", this._arpDomain, false);
		this._arpDomain.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpDomain);
		this.outFields.push(this._arpDomain);
	}

	private function buildArpDomain():Void {
		this.arpDomain = fieldSkeleton("arpDomain", this.arpDomain, true);
		this.arpDomain.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpDomain,
			expr: macro @:pos(this.arpDomain.pos) { return this._arpDomain; }
		});
		this.outFields.push(this.arpDomain);
	}

	private function buildArpType():Void {
		this.arpType = fieldSkeleton("arpType", this.arpType, true);
		this.arpType.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.core.ArpType,
			expr: macro @:pos(this.arpType.pos) {return new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName});}
		});
		this.outFields.push(this.arpType);
	}

	private function build_arpSlot():Void {
		this._arpSlot = fieldSkeleton("_arpSlot", this._arpSlot, false);
		//this._arpSlot.kind = FieldType.FVar(createArpSlotTypeOf(macro :net.kaikoga.arp.domain.ArpDomain));
		this._arpSlot.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot);
		this.outFields.push(this._arpSlot);
	}

	private function buildArpSlot():Void {
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

		var e:Expr = macro {
			this._arpDomain = slot.domain;
			this._arpSlot = slot;
			${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
			if (seed != null) for (element in seed) this.arpConsumeSeedElement(element);
			this.init();
			return this;
		}

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
			init.kind = FieldType.FFun({ args: [], ret: null, expr: macro { null; } });
			this.outFields.push(init);
		}
	}

	private function buildArpHeatLater():Void {
		var heatLaterBlock:Array<Expr> = [];

		var e:Expr = macro {
			${ { pos: Context.currentPos(), expr: ExprDef.EBlock(heatLaterBlock)} };
		}

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
			dispose.kind = FieldType.FFun({ args: [], ret: null, expr: macro { null; } });
			this.outFields.push(dispose);
		}
	}

	private function buildArpConsumeSeedElement():Void {
		var cases:Array<Case> = [];

		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, null) }

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
		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)};

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
		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)};

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
