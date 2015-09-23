package net.kaikoga.arp.macro;
import net.kaikoga.arp.macro.MacroArpObjectField.MacroArpObjectFields;
import haxe.macro.Expr;
import haxe.macro.Context;

#if macro

class MacroArpObjectBuilder {

	public static function build(arpTypeName:String):Array<Field> {
		return new MacroArpObjectBuilder(arpTypeName).run();
	}

	private var arpTypeName:String;

	private var result:Array<Field> = [];
	private var arpObjectFields:Array<MacroArpObjectField> = [];

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
		this.result = [];
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
					var arpObjectField:MacroArpObjectField = MacroArpObjectFields.createFromField(field);
					if (arpObjectField == null) {
						this.result.push(field);
					} else {
						this.arpObjectFields.push(arpObjectField);
						switch (arpObjectField.type) {
							case
								MacroArpObjectFieldType.PrimInt,
								MacroArpObjectFieldType.PrimFloat,
								MacroArpObjectFieldType.PrimBool,
								MacroArpObjectFieldType.PrimString:
								this.result.push(field);
							case
								MacroArpObjectFieldType.Reference(fieldArpType):
								buildSlot(field, arpObjectField.nativeType, fieldArpType);
						}
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
		return this.result;
	}

	inline private function createArpSlotTypeOf(type:ComplexType):ComplexType {
		return ComplexType.TPath({
			pack: "net.kaikoga.arp.domain".split("."), name: "ArpSlot", params: [TypeParam.TPType(type)]
		});
	}

	inline private function fieldSkeleton(name:String, field:Null<Field>, isPublic:Bool):Field {
		return (field != null) ? field : { name: name, access: [isPublic ? Access.APublic : Access.APrivate], kind: null, pos: Context.currentPos() }
	}

	private function build_arpDomain():Void {
		this._arpDomain = fieldSkeleton("_arpDomain", this._arpDomain, false);
		this._arpDomain.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpDomain);
		this.result.push(this._arpDomain);
	}

	private function buildArpDomain():Void {
		this.arpDomain = fieldSkeleton("arpDomain", this.arpDomain, true);
		this.arpDomain.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpDomain,
			expr: macro @:pos(this.arpDomain.pos) { return this._arpDomain; }
		});
		this.result.push(this.arpDomain);
	}

	private function buildArpType():Void {
		this.arpType = fieldSkeleton("arpType", this.arpType, true);
		this.arpType.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.core.ArpType,
			expr: macro @:pos(this.arpType.pos) {return new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName});}
		});
		this.result.push(this.arpType);
	}

	private function build_arpSlot():Void {
		this._arpSlot = fieldSkeleton("_arpSlot", this._arpSlot, false);
		//this._arpSlot.kind = FieldType.FVar(createArpSlotTypeOf(macro :net.kaikoga.arp.domain.ArpDomain));
		this._arpSlot.kind = FieldType.FVar(macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot);
		this.result.push(this._arpSlot);
	}

	private function buildArpSlot():Void {
		this.arpSlot = fieldSkeleton("arpSlot", this.arpSlot, true);
		this.arpSlot.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot,
			expr: macro @:pos(this.arpSlot.pos) { return this._arpSlot; }
		});
		this.result.push(this.arpSlot);
	}

	private function buildInit():Void {
		var initBlock:Array<Expr> = [];
		var cases:Array<Case> = [];

		var e:Expr = macro {
			this._arpDomain = slot.domain;
			this._arpSlot = slot;
			${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
			if (seed != null) for (element in seed) this.consumeSeedElement(element);
			return this;
		}

		for (aoField in this.arpObjectFields) {
			var field:Field = aoField.field;
			var fieldName:String = field.name;
			switch (aoField.type) {
				case MacroArpObjectFieldType.PrimInt:
				case MacroArpObjectFieldType.PrimFloat:
				case MacroArpObjectFieldType.PrimBool:
				case MacroArpObjectFieldType.PrimString:
				case MacroArpObjectFieldType.Reference(arpType):
					var fieldSlotName:String = fieldName + "Slot";
					initBlock.push(macro @:pos(field.pos) { this.$fieldSlotName = this._arpDomain.nullSlot; });
			}
		}

		this.init = fieldSkeleton("init", this.init, true);
		this.init.kind = FieldType.FFun({
			args: [
				{ name: "slot", type: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot },
				{ name: "seed", type: macro :net.kaikoga.arp.domain.seed.ArpSeed, value: macro null }
			],
			ret: macro :net.kaikoga.arp.domain.IArpObject,
			expr: e
		});
		this.result.push(this.init);
	}

	private function buildConsumeSeedElement():Void {
		var cases:Array<Case> = [];

		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, null) }

		for (aoField in this.arpObjectFields) {
			var field:Field = aoField.field;
			var fieldName:String = field.name;
			var caseBlock:Array<Expr> = [];
			cases.push({
				values: [macro @:pos(field.pos) $v{fieldName}],
				expr: { pos: field.pos, expr: ExprDef.EBlock(caseBlock)}
			});
			switch (aoField.type) {
				case MacroArpObjectFieldType.PrimInt:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = Std.parseInt(element.value()); });
				case MacroArpObjectFieldType.PrimFloat:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = Std.parseFloat(element.value()); });
				case MacroArpObjectFieldType.PrimBool:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = element.value() == "true"; });
				case MacroArpObjectFieldType.PrimString:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = element.value(); });
				case MacroArpObjectFieldType.Reference(arpType):
					var fieldSlotName:String = fieldName + "Slot";
					caseBlock.push(macro @:pos(field.pos) { this.$fieldSlotName = this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${arpType})); });
			}
		}

		this.consumeSeedElement = fieldSkeleton("consumeSeedElement", this.consumeSeedElement, false);
		this.consumeSeedElement.kind = FieldType.FFun({
			args: [
				{ name: "element", type: macro :net.kaikoga.arp.domain.seed.ArpSeed }
			],
			ret: null,
			expr: e
		});
		this.result.push(this.consumeSeedElement);
	}

	private function buildReadSelf():Void {
		var fieldBlock:Array<Expr> = [];
		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)};

		for (aoField in this.arpObjectFields) {
			var field:Field = aoField.field;
			var fieldName:String = field.name;
			switch (aoField.type) {
				case MacroArpObjectFieldType.PrimInt:
					fieldBlock.push(macro @:pos(field.pos) { this.$fieldName = input.readInt32($v{fieldName}); });
				case MacroArpObjectFieldType.PrimFloat:
					fieldBlock.push(macro @:pos(field.pos) { this.$fieldName = input.readDouble($v{fieldName}); });
				case MacroArpObjectFieldType.PrimBool:
					fieldBlock.push(macro @:pos(field.pos) { this.$fieldName = input.readBool($v{fieldName}); });
				case MacroArpObjectFieldType.PrimString:
					fieldBlock.push(macro @:pos(field.pos) { this.$fieldName = input.readUtf($v{fieldName}); });
				case MacroArpObjectFieldType.Reference(arpType):
					var fieldSlotName:String = fieldName + "Slot";
					fieldBlock.push(macro @:pos(field.pos) { this.$fieldSlotName = this._arpDomain.getOrCreateSlot(new net.kaikoga.arp.domain.core.ArpSid(input.readUtf($v{fieldName}))); });
			}
		}

		this.readSelf = fieldSkeleton("readSelf", this.readSelf, true);
		this.readSelf.kind = FieldType.FFun({
			args: [
				{ name: "input", type: macro :net.kaikoga.arp.persistable.IPersistInput }
			],
			ret: null,
			expr: e
		});
		this.result.push(this.readSelf);
	}

	private function buildWriteSelf():Void {
		var fieldBlock:Array<Expr> = [];
		var e:Expr = { pos: Context.currentPos(), expr: ExprDef.EBlock(fieldBlock)};

		for (aoField in this.arpObjectFields) {
			var field:Field = aoField.field;
			var fieldName:String = field.name;
			switch (aoField.type) {
				case MacroArpObjectFieldType.PrimInt:
					fieldBlock.push(macro @:pos(field.pos) { output.writeInt32($v{fieldName}, this.$fieldName); });
				case MacroArpObjectFieldType.PrimFloat:
					fieldBlock.push(macro @:pos(field.pos) { output.writeDouble($v{fieldName}, this.$fieldName); });
				case MacroArpObjectFieldType.PrimBool:
					fieldBlock.push(macro @:pos(field.pos) { output.writeBool($v{fieldName}, this.$fieldName); });
				case MacroArpObjectFieldType.PrimString:
					fieldBlock.push(macro @:pos(field.pos) { output.writeUtf($v{fieldName}, this.$fieldName); });
				case MacroArpObjectFieldType.Reference(arpType):
					var fieldSlotName:String = fieldName + "Slot";
					fieldBlock.push(macro @:pos(field.pos) { output.writeUtf($v{fieldName}, this.$fieldSlotName.sid.toString()); });
			}
		}

		this.writeSelf = fieldSkeleton("writeSelf", this.writeSelf, true);
		this.writeSelf.kind = FieldType.FFun({
			args: [{name: "output", type: macro :net.kaikoga.arp.persistable.IPersistOutput}],
			ret: null,
			expr: e
		});
		this.result.push(this.writeSelf);
	}

	private function buildSlot(field:Field, fieldType:ComplexType, arpType:ExprOf<String>):Void {
		var ifieldSlot:String = field.name + "Slot";
		var iget_field:String = "get_" + field.name;
		var iset_field:String = "set_" + field.name;
		var fieldSlotType:ComplexType = createArpSlotTypeOf(fieldType);
		var generated:Array<Field> = (macro class Generated {
			@:pos(field.pos) public var $ifieldSlot:$fieldSlotType;
			@:pos(field.pos) inline private function $iget_field():$fieldType return this.$ifieldSlot.value;
			@:pos(field.pos) inline private function $iset_field(value:$fieldType):$fieldType { this.$ifieldSlot = value.arpSlot(); return value; }
		}).fields;
		field.kind = FieldType.FProp("get", "set", fieldType, null);
		this.result.push(field);
		for (g in generated) this.result.push(g);
	}
}



#end
