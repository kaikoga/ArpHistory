package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

class MacroArpObjectField {

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;
	public var type(default, null):MacroArpObjectFieldType;

	private var nativePos(get, never):Position;
	private function get_nativePos():Position return this.nativeField.pos;
	private var nativeSlotType(get, never):ComplexType;
	inline private function get_nativeSlotType():ComplexType {
		return ComplexType.TPath({
			pack: "net.kaikoga.arp.domain".split("."), name: "ArpSlot", params: [TypeParam.TPType(this.nativeType)]
		});
	}

	private var iFieldName(get, never):String;
	private function get_iFieldName():String return this.nativeField.name;
	private var iFieldSlot(get, never):String;
	private function get_iFieldSlot():String return this.iFieldName + "Slot";
	private var iGet_field(get, never):String;
	private function get_iGet_field():String return "get_" + this.iFieldName;
	private var iSet_field(get, never):String;
	private function get_iSet_field():String return "set_" + this.iFieldName;

	public function new(nativeField:Field, nativeType:ComplexType, type:MacroArpObjectFieldType) {
		this.nativeField = nativeField;
		this.nativeType = nativeType;
		this.type = type;
	}

	private static function typePathToTypeName(typePath:TypePath):String {
		var fqn:Array<String> = typePath.pack.copy();
		fqn.push(typePath.name);
		if (typePath.sub != null) fqn.push(typePath.sub);
		return fqn.join(".");
	}

	public static function fromField(nativeField:Field):MacroArpObjectField {
		var metaArpSlot:ExprOf<String> = null;
		var metaArpField:Bool = false;

		for (meta in nativeField.meta) {
			switch (meta.name) {
				case ":arpSlot": metaArpSlot = meta.params[0];
				case ":arpField": metaArpField = true;
			}
		}

		var nativeType:ComplexType = switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, _): n;
			case FieldType.FVar(n, _): n;
			case FieldType.FFun(_): return null;
		}

		var type:MacroArpObjectFieldType;
		switch (nativeType) {
			case ComplexType.TPath(p):
				switch (typePathToTypeName(p)) {
					case "Int":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", nativeField.pos);
						type = MacroArpObjectFieldType.PrimInt;
					case "Float":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", nativeField.pos);
						type = MacroArpObjectFieldType.PrimFloat;
					case "Bool":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", nativeField.pos);
						type = MacroArpObjectFieldType.PrimBool;
					case "String":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", nativeField.pos);
						type = MacroArpObjectFieldType.PrimString;
					default:
						if (metaArpField) Context.error(p.name + " must be @:arpSlot", nativeField.pos);
						if (metaArpSlot == null) return null;
						type = MacroArpObjectFieldType.Reference(metaArpSlot);
				}
			default:
				throw "could not create ArpObjectField: " + Std.string(nativeType);
		}
		return new MacroArpObjectField(nativeField, nativeType, type);
	}

	public function buildField(outFields:Array<Field>):Void {
		switch (this.type) {
			case
			MacroArpObjectFieldType.PrimInt,
			MacroArpObjectFieldType.PrimFloat,
			MacroArpObjectFieldType.PrimBool,
			MacroArpObjectFieldType.PrimString:
				outFields.push(this.nativeField);
			case
			MacroArpObjectFieldType.Reference(fieldArpType):
				this.buildSlot(outFields, fieldArpType);
		}
	}

	private function buildSlot(outFields:Array<Field>, fieldArpType:ExprOf<String>):Void {
		var iFieldSlot:String = this.iFieldSlot;
		var iGet_field:String = this.iGet_field;
		var iSet_field:String = this.iSet_field;
		var nativeType:ComplexType = this.nativeType;
		var nativeSlotType:ComplexType = this.nativeSlotType;

		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos) public var $iFieldSlot:$nativeSlotType;
			@:pos(this.nativePos) inline private function $iGet_field():$nativeType return this.$iFieldSlot.value;
			@:pos(this.nativePos) inline private function $iSet_field(value:$nativeType):$nativeType { this.$iFieldSlot = value.arpSlot(); return value; }
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		outFields.push(nativeField);
		for (g in generated) outFields.push(g);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
			case MacroArpObjectFieldType.PrimFloat:
			case MacroArpObjectFieldType.PrimBool:
			case MacroArpObjectFieldType.PrimString:
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				initBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.nullSlot; });
		}
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseInt(element.value()); });
			case MacroArpObjectFieldType.PrimFloat:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseFloat(element.value()); });
			case MacroArpObjectFieldType.PrimBool:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value() == "true"; });
			case MacroArpObjectFieldType.PrimString:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value(); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${arpType})); });
		}
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readInt32($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readDouble($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readBool($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readUtf($v{iFieldName}); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.getOrCreateSlot(new net.kaikoga.arp.domain.core.ArpSid(input.readUtf($v{iFieldName}))); });
		}
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeInt32($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeDouble($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeBool($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = iFieldName + "Slot";
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, this.$iFieldSlot.sid.toString()); });
		}
	}
}

#end
