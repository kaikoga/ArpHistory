package net.kaikoga.arp.macro;
import haxe.macro.Expr;
import haxe.macro.Context;

#if macro

class ArpObjectBuilder {

	public static function build(arpTypeName:String):Array<Field> {
		return new ArpObjectBuilder(arpTypeName).run();
	}

	private var arpTypeName:String;

	private var result:Array<Field> = [];
	private var arpObjectFields:Array<ArpObjectField> = [];

	private var arpDomain:Field = null;
	private var arpType:Field = null;
	private var arpSlot:Field = null;
	private var init:Field = null;
	private var readSelf:Field = null;
	private var writeSelf:Field = null;

	private function new(arpTypeName:String) {
		this.arpTypeName = arpTypeName;
		this.result = [];
	}

	private function run():Array<Field> {
		for (field in Context.getBuildFields()) {
			switch (field.name) {
				case "arpDomain":
					this.arpDomain = field;
				case "arpType":
					this.arpType = field;
				case "arpSlot":
					this.arpSlot = field;
				case "init":
					this.init = field;
				case "readSelf":
					this.readSelf = field;
				case "writeSelf":
					this.writeSelf = field;
				default:
					var arpObjectField:ArpObjectField = createArpObjectField(field);
					if (arpObjectField == null) {
						this.result.push(field);
					} else {
						this.arpObjectFields.push(arpObjectField);
						switch (arpObjectField.type) {
							case
								ArpObjectFieldType.PrimInt,
								ArpObjectFieldType.PrimFloat,
								ArpObjectFieldType.PrimBool,
								ArpObjectFieldType.PrimString:
								this.result.push(field);
							case
								ArpObjectFieldType.Reference(fieldArpType):
								buildSlot(field, arpObjectField.nativeType, fieldArpType);
						}
					}
				}
		}
		buildArpDomain();
		buildArpType();
		buildArpSlot();
		buildInit();
		buildReadSelf();
		buildWriteSelf();
		return this.result;
	}
	
	private function createArpObjectField(field:Field):ArpObjectField {
		var metaArpSlot:ExprOf<String> = null;
		var metaArpField:Bool = false;
		
		for (meta in field.meta) {
			switch (meta.name) {
				case ":arpSlot": metaArpSlot = meta.params[0];
				case ":arpField": metaArpField = true;
			}
		}

		var nativeType:ComplexType = switch (field.kind) {
			case FieldType.FProp(_, _, n, _): n;
			case FieldType.FVar(n, _): n;
			case FieldType.FFun(_): return null;
		}

		switch (nativeType) {
			case ComplexType.TPath(p):
				switch (p.name) {
					case "Int":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: ArpObjectFieldType.PrimInt };
					case "Float":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: ArpObjectFieldType.PrimFloat };
					case "Bool":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: ArpObjectFieldType.PrimBool };
					case "String":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: ArpObjectFieldType.PrimString };
					default:
						if (metaArpField) Context.error(p.name + " must be @:arpSlot", field.pos);
						if (metaArpSlot == null) return null;
						return { field: field, nativeType: nativeType, type: ArpObjectFieldType.Reference(metaArpSlot) };
				}
			default:
				throw "could not create ArpObjectField: " + Std.string(nativeType);
		}
	}

	inline private function fieldSkeleton(name:String, field:Null<Field>):Field {
		return (field != null) ? field : { name: name, access: [Access.APublic], kind: null, pos: Context.currentPos() }
	}

	private function buildArpDomain():Void {
		this.arpDomain = fieldSkeleton("arpDomain", this.arpDomain);
		this.arpDomain.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpDomain,
			expr: macro {return null;}
		});
		this.result.push(this.arpDomain);
	}

	private function buildArpType():Void {
		this.arpType = fieldSkeleton("arpType", this.arpType);
		this.arpType.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.core.ArpType,
			expr: macro {return new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName});}
		});
		this.result.push(this.arpType);
	}

	private function buildArpSlot():Void {
		this.arpSlot = fieldSkeleton("arpSlot", this.arpSlot);
		this.arpSlot.kind = FieldType.FFun({
			args: [],
			ret: macro :net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot,
			expr: macro { return null; }
		});
		this.result.push(this.arpSlot);
	}

	private function buildInit():Void {
		var initBlock:Array<Expr> = [];
		var cases:Array<Case> = [];

		var e:Expr = macro {
			${ { pos: Context.currentPos(), expr: ExprDef.EBlock(initBlock)} };
			if (seed != null) for (element in seed) ${
				{ pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, null) }
			};
			return this;
		}

		for (aoField in this.arpObjectFields) {
			var field:Field = aoField.field;
			var fieldName:String = field.name;
			var caseBlock:Array<Expr> = [];
			cases.push({
				values: [macro @:pos(field.pos) $v{fieldName}],
				expr: { pos: field.pos, expr: ExprDef.EBlock(caseBlock)}
			});
			switch (aoField.type) {
				case ArpObjectFieldType.PrimInt:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = Std.parseInt(element.value()); });
				case ArpObjectFieldType.PrimFloat:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = Std.parseFloat(element.value()); });
				case ArpObjectFieldType.PrimBool:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = element.value() == "true"; });
				case ArpObjectFieldType.PrimString:
					caseBlock.push(macro @:pos(field.pos) { this.$fieldName = element.value(); });
				case ArpObjectFieldType.Reference(arpType):
					var fieldSlotName:String = fieldName + "Slot";
					initBlock.push(macro @:pos(field.pos) { this.$fieldSlotName = slot.domain.nullSlot; });
					caseBlock.push(macro @:pos(field.pos) { this.$fieldSlotName = slot.domain.query(element.value(), new net.kaikoga.arp.domain.core.ArpType(${arpType})).slot(); });
			}
		}

		this.init = fieldSkeleton("init", this.init);
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

	private function buildReadSelf():Void {
		this.readSelf = fieldSkeleton("readSelf", this.readSelf);
		this.readSelf.kind = FieldType.FFun({
			args: [
				{ name: "input", type: macro :net.kaikoga.arp.persistable.IPersistInput }
			],
			ret: null,
			expr: macro {return;}
		});
		this.result.push(this.readSelf);
	}

	private function buildWriteSelf():Void {
		this.writeSelf = fieldSkeleton("writeSelf", this.writeSelf);
		this.writeSelf.kind = FieldType.FFun({
			args: [{name: "output", type: macro :net.kaikoga.arp.persistable.IPersistOutput}],
			ret: null,
		expr: macro {return;}
		});
		this.result.push(this.writeSelf);
	}

	private function buildSlot(field:Field, fieldType:ComplexType, arpType:ExprOf<String>):Void {
		var ifieldSlot:String = field.name + "Slot";
		var iget_field:String = "get_" + field.name;
		var iset_field:String = "set_" + field.name;
		var fieldSlotType:ComplexType = ComplexType.TPath({
			pack: "net.kaikoga.arp.domain".split("."), name: "ArpSlot", params: [TypeParam.TPType(fieldType)]
		});
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

typedef ArpObjectField = {
	field:Field,
	nativeType:ComplexType,
	type:ArpObjectFieldType
}
enum ArpObjectFieldType {
	PrimInt;
	PrimFloat;
	PrimBool;
	PrimString;
	Reference(arpType:ExprOf<String>);
}

#end
