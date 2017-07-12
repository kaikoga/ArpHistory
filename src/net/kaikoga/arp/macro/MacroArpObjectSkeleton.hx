package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import net.kaikoga.arp.macro.stubs.MacroArpObjectStub;

class MacroArpObjectSkeleton {

	public var classDef(default, null):MacroArpClassDefinition;

	private var arpFields:Array<IMacroArpField> = [];

	private function new(classDef:MacroArpClassDefinition) {
		this.classDef = classDef;
	}

	private function buildBlock(iFieldName:String, forPersist:Bool = false):Expr {
		var block:Array<Expr> = [];
		for (arpField in this.arpFields) {
			if (forPersist) {
				if (!arpField.isPersistable) continue;
			} else {
				macro null;
			}
			Reflect.callMethod(arpField, Reflect.field(arpField, iFieldName), [block]);
		}
		return macro @:mergeBlock $b{ block };
	}

	private function buildInitBlock():Expr return buildBlock("buildInitBlock");
	private function buildHeatLaterBlock():Expr return buildBlock("buildHeatLaterBlock");
	private function buildHeatUpBlock():Expr return buildBlock("buildHeatUpBlock");
	private function buildHeatDownBlock():Expr return buildBlock("buildHeatDownBlock");
	private function buildDisposeBlock():Expr return buildBlock("buildDisposeBlock");
	private function buildReadSelfBlock():Expr return buildBlock("buildReadSelfBlock", true);
	private function buildWriteSelfBlock():Expr return buildBlock("buildWriteSelfBlock", true);
	private function buildCopyFromBlock():Expr return buildBlock("buildCopyFromBlock");

	private function genSelfTypePath():TypePath {
		var localClassRef:Null<Ref<ClassType>> = Context.getLocalClass();
		var localClass:ClassType = localClassRef.get();
		return {
			pack: localClass.pack,
			name: localClass.name
		}
	}

	private function genSelfComplexType():ComplexType {
		return ComplexType.TPath(this.genSelfTypePath());
	}

	private function buildArpConsumeSeedElement():Expr {
		var cases:Array<Case> = [];

		var eDefault:Expr;
		if (this.classDef.isDerived) {
			eDefault = macro { super.arpConsumeSeedElement(element); }
		} else {
			eDefault = macro null;
		}
		var expr:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName, cases, eDefault) }

		for (arpField in this.arpFields) {
			if (arpField.isSeedable) arpField.buildConsumeSeedElementBlock(cases);
		}

		return expr;
	}

	private function genTypeFields():Array<Field> {
		var arpTypeName = this.classDef.arpTypeName;
		var arpTemplateName = this.classDef.arpTemplateName;
		var selfTypePath = this.genSelfTypePath();
		var selfComplexType = this.genSelfComplexType();
		return (macro class Generated {
			@:noDoc @:noCompletion private var _arpDomain:net.kaikoga.arp.domain.ArpDomain;
			public var arpDomain(get, never):net.kaikoga.arp.domain.ArpDomain;
			@:noDoc @:noCompletion private function get_arpDomain():net.kaikoga.arp.domain.ArpDomain return this._arpDomain;

			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			public var arpTypeInfo(get, never):net.kaikoga.arp.domain.ArpTypeInfo;
			@:noDoc @:noCompletion private function get_arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			public var arpType(get, never):net.kaikoga.arp.domain.core.ArpType;
			@:noDoc @:noCompletion private function get_arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			@:noDoc @:noCompletion private var _arpSlot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
			public var arpSlot(get, never):net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
			@:noDoc @:noCompletion private function get_arpSlot():net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot return this._arpSlot;

			public function arpInit(slot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot, seed:net.kaikoga.arp.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpInit(
					$e{ this.buildInitBlock() },
					$v{ this.classDef.hasImpl }
				);
			}

			public function arpHeatLater():Void {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpHeatLater(
					$e{ this.buildHeatLaterBlock() }
				);
			}

			public function arpHeatUp():Bool {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpHeatUp(
					$e{ this.buildHeatUpBlock() },
					$v{ this.classDef.hasImpl }
				);
			}

			public function arpHeatDown():Bool {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpHeatDown(
					$e{ this.buildHeatDownBlock() },
					$v{ this.classDef.hasImpl }
				);
			}

			public function arpDispose():Void {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpDispose(
					$e{ this.buildDisposeBlock() },
					$v{ this.classDef.hasImpl }
				);
			}

			@:noDoc @:noCompletion
			private function arpConsumeSeedElement(element:net.kaikoga.arp.seed.ArpSeed):Void {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpConsumeSeedElement(
					$e{ this.buildArpConsumeSeedElement() }
				);
			}

			public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.readSelf(
					$e{ this.buildReadSelfBlock() }
				);
			}

			public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.writeSelf(
					$e{ this.buildWriteSelfBlock() }
				);
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			public function arpClone():net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpClone();
			}

			public function arpCopyFrom(source:net.kaikoga.arp.domain.IArpObject):net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpCopyFrom(
					$e{ this.buildCopyFromBlock() }
				);
			}
		}).fields;
	}

	private function genDerivedTypeFields():Array<Field> {
		var arpTypeName = this.classDef.arpTypeName;
		var arpTemplateName = this.classDef.arpTemplateName;
		var selfTypePath = this.genSelfTypePath();
		var selfComplexType = this.genSelfComplexType();
		return (macro class Generated {
			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			override private function get_arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			@:noDoc @:noCompletion override private function get_arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			override public function arpInit(slot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot, seed:net.kaikoga.arp.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				$e{ this.buildInitBlock() }
				return super.arpInit(slot, seed);
			}

			override public function arpHeatLater():Void {
				super.arpHeatLater();
				$e{ this.buildHeatLaterBlock() }
			}

			override public function arpHeatUp():Bool {
				$e{ this.buildHeatUpBlock() }
				return super.arpHeatUp();
			}

			override public function arpHeatDown():Bool {
				// $e{ this.buildHeatDownBlock() }
				return super.arpHeatDown();
			}

			override public function arpDispose():Void {
				$e{ this.buildDisposeBlock() }
				super.arpDispose();
			}

			@:noDoc @:noCompletion
			override private function arpConsumeSeedElement(element:net.kaikoga.arp.seed.ArpSeed):Void {
				$e{ this.buildArpConsumeSeedElement() }
			}

			override public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				super.readSelf(input);
				var collection:net.kaikoga.arp.persistable.IPersistInput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistInput;
				$e{ this.buildReadSelfBlock() }
			}

			override public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				super.writeSelf(output);
				var collection:net.kaikoga.arp.persistable.IPersistOutput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistOutput;
				var uniqId:net.kaikoga.arp.utils.ArpIdGenerator = new net.kaikoga.arp.utils.ArpIdGenerator();
				$e{ this.buildWriteSelfBlock() }
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			override public function arpClone():net.kaikoga.arp.domain.IArpObject {
				var clone:$selfComplexType = this._arpDomain.addObject(new $selfTypePath());
				clone.arpCopyFrom(this);
				return clone;
			}

			override public function arpCopyFrom(source:net.kaikoga.arp.domain.IArpObject):net.kaikoga.arp.domain.IArpObject {
				var src:$selfComplexType = cast source;
				$e{ this.buildCopyFromBlock() }
				return super.arpCopyFrom(source);
			}
		}).fields;
	}

	private function genDefaultTypeFields():Array<Field> {
		return (macro class Generated {
			@:noDoc @:noCompletion private function arpSelfInit():Void return;
			@:noDoc @:noCompletion private function arpSelfHeatUp():Bool return true;
			@:noDoc @:noCompletion private function arpSelfHeatDown():Bool return true;
			@:noDoc @:noCompletion private function arpSelfDispose():Void return;
		}).fields;
	}

	private function genVoidCallbackField(fun:String, callback:String):Array<Field> {
		return (macro class Generated {
			@:noDoc @:noCompletion
			private function $fun():Void {
				this.$callback();
			}
		}).fields;
	}

	private function genBoolCallbackField(fun:String, callback:String):Array<Field> {
		return (macro class Generated {
			@:noDoc @:noCompletion
			private function $fun():Bool {
				return this.$callback();
			}
		}).fields;
	}

	private function genImplFields(implTypePath:TypePath):Array<Field> {
		var implType:ComplexType = ComplexType.TPath(implTypePath);
		var implClassDef:MacroArpImplClassDefinition = new MacroArpImplClassDefinition(implType);

		// generate arpImpl
		var fields:Array<Field> = (macro class Generated {
			@:noDoc @:noCompletion
			private var arpImpl:$implType;

			@:noDoc @:noCompletion
			private function createImpl():$implType return ${
				if (implClassDef.isInterface) {
					// polymorphic impl
					macro null;
				} else {
					// monomorphic impl
					macro new $implTypePath(this);
				}
			};
		}).fields;

		// and populate delegate methods
		fields = fields.concat(implClassDef.fields);
		return fields;
	}

	private function genDerivedImplFields(implTypePath:TypePath):Array<Field> {
		var implType = ComplexType.TPath(implTypePath);
		return (macro class Generated {
			@:noDoc @:noCompletion
			override private function createImpl() return new $implTypePath(this);
		}).fields;
	}

	private function prependFunctionBody(nativeField:Field, expr:Expr):Field {
		var nativeFunc:Function;
		switch (nativeField.kind) {
			case FieldType.FFun(func):
				nativeFunc = func;
			case _:
				MacroArpUtil.error("Internal error: field is not a function", nativeField.pos);
		}
		return {
			name: nativeField.name,
			doc: nativeField.doc,
			access: nativeField.access,
			kind: FieldType.FFun({
				args:nativeFunc.args,
				ret:nativeFunc.ret,
				expr: macro @:mergeBlock {
					${expr}
					${nativeFunc.expr}
				},
				params: nativeFunc.params
			}),
			pos: nativeField.pos,
			meta:nativeField.meta
		};
	}

	private function genConstructorField(nativeField:Field, nativeFunc:Function):Array<Field> {
		return [nativeField];
	}

}

#end
