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
	private var init:Field = null;
	private var consumeSeedElement:Field = null;
	private var readSelf:Field = null;
	private var writeSelf:Field = null;

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
				case "init":
					this.init = field;
				case "consumeSeedElement":
					this.consumeSeedElement = field;
				case "readSelf":
					this.readSelf = field;
				case "writeSelf":
					this.writeSelf = field;
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
		buildInit();
		buildConsumeSeedElement();
		buildReadSelf();
		buildWriteSelf();
		return this.outFields;
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

	private function buildInit():Void {
		var initBlock:Array<Expr> = [];

		var e:Expr = macro {
			this._arpDomain = slot.domain;
			this._arpSlot = slot;
			${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
			if (seed != null) for (element in seed) this.consumeSeedElement(element);
			return this;
		}

		for (aoField in this.arpObjectFields) aoField.buildInitBlock(initBlock);

		this.init = fieldSkeleton("init", this.init, true);
		this.init.kind = FieldType.FFun({
			args: [
				{ name: "slot", type: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot },
				{ name: "seed", type: macro :net.kaikoga.arp.domain.seed.ArpSeed, value: macro null }
			],
			ret: macro :net.kaikoga.arp.domain.IArpObject,
			expr: e
		});
		this.outFields.push(this.init);
	}

	private function buildConsumeSeedElement():Void {
		var cases:Array<Case> = [];

		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, null) }

		for (aoField in this.arpObjectFields) aoField.buildConsumeSeedElementBlock(cases);

		this.consumeSeedElement = fieldSkeleton("consumeSeedElement", this.consumeSeedElement, false);
		this.consumeSeedElement.kind = FieldType.FFun({
			args: [
				{ name: "element", type: macro :net.kaikoga.arp.domain.seed.ArpSeed }
			],
			ret: null,
			expr: e
		});
		this.outFields.push(this.consumeSeedElement);
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
