package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import net.kaikoga.arp.macro.stubs.MacroArpObjectStub;

class MacroArpObjectSkeleton {

	private static function getTemplate():MacroArpObject {
		return MacroArpObjectRegistry.getLocalMacroArpObject();
	}

	private var _template:MacroArpObject;
	private var template(get, null):MacroArpObject;
	private function get_template():MacroArpObject {
		return (_template != null) ? _template : (_template = getTemplate());
	}

	private var classDef(get, never):MacroArpClassDefinition;
	private function get_classDef():MacroArpClassDefinition return template.classDef;
	private var arpFields(get, never):Array<IMacroArpField>;
	private function get_arpFields():Array<IMacroArpField> return template.arpFields;

	private function new() return;

	private function buildBlock(iFieldName:String, forPersist:Bool = false):Expr {
		return macro net.kaikoga.arp.macro.stubs.MacroArpObjectStub.block($v{iFieldName}, $v{forPersist});
	}

	private function buildInitBlock():Expr return buildBlock("buildInitBlock");
	private function buildHeatLaterBlock():Expr return buildBlock("buildHeatLaterBlock");
	private function buildHeatUpBlock():Expr return buildBlock("buildHeatUpBlock");
	private function buildHeatDownBlock():Expr return buildBlock("buildHeatDownBlock");
	private function buildDisposeBlock():Expr return buildBlock("buildDisposeBlock");
	private function buildReadSelfBlock():Expr return buildBlock("buildReadSelfBlock", true);
	private function buildWriteSelfBlock():Expr return buildBlock("buildWriteSelfBlock", true);
	private function buildCopyFromBlock():Expr return buildBlock("buildCopyFromBlock");

	private function buildArpConsumeSeedElementBlock():Expr {
		return macro net.kaikoga.arp.macro.stubs.MacroArpObjectStub.arpConsumeSeedElementBlock();
	}

	private function genTypeFields():Array<Field> {
		var arpTypeName = this.classDef.arpTypeName;
		var arpTemplateName = this.classDef.arpTemplateName;
		return (macro class Generated {
			@:noDoc @:noCompletion private var _arpDomain:net.kaikoga.arp.domain.ArpDomain;
			public var arpDomain(get, never):net.kaikoga.arp.domain.ArpDomain;
			@:noDoc @:noCompletion private function get_arpDomain():net.kaikoga.arp.domain.ArpDomain return this._arpDomain;

			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			public var arpTypeInfo(get, never):net.kaikoga.arp.domain.ArpTypeInfo;
			@:noDoc @:noCompletion private function get_arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			public var arpType(get, never):net.kaikoga.arp.domain.core.ArpType;
			@:noDoc @:noCompletion private function get_arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			@:noDoc @:noCompletion private var _arpSlot:net.kaikoga.arp.domain.ArpUntypedSlot;
			public var arpSlot(get, never):net.kaikoga.arp.domain.ArpUntypedSlot;
			@:noDoc @:noCompletion private function get_arpSlot():net.kaikoga.arp.domain.ArpUntypedSlot return this._arpSlot;

			public function arpInit(slot:net.kaikoga.arp.domain.ArpUntypedSlot, seed:net.kaikoga.arp.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
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
					$e{ this.buildArpConsumeSeedElementBlock() }
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
		return (macro class Generated {
			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			override private function get_arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			@:noDoc @:noCompletion override private function get_arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			override public function arpInit(slot:net.kaikoga.arp.domain.ArpUntypedSlot, seed:net.kaikoga.arp.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpInit(
					$e{ this.buildInitBlock() }
				);
			}

			override public function arpHeatLater():Void {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpHeatLater(
					$e{ this.buildHeatLaterBlock() }
				);
			}

			override public function arpHeatUp():Bool {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpHeatUp(
					$e{ this.buildHeatUpBlock() }
				);
			}

			override public function arpHeatDown():Bool {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpHeatDown(
					$e{ this.buildHeatDownBlock() }
				);
			}

			override public function arpDispose():Void {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpDispose(
					$e{ this.buildDisposeBlock() }
				);
			}

			@:noDoc @:noCompletion
			override private function arpConsumeSeedElement(element:net.kaikoga.arp.seed.ArpSeed):Void {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpConsumeSeedElement(
					$e{ this.buildArpConsumeSeedElementBlock() }
				);
			}

			override public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.readSelf(
					$e{ this.buildReadSelfBlock() }
				);
			}

			override public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.writeSelf(
					$e{ this.buildWriteSelfBlock() }
				);
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			override public function arpClone():net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpClone();
			}

			override public function arpCopyFrom(source:net.kaikoga.arp.domain.IArpObject):net.kaikoga.arp.domain.IArpObject {
				net.kaikoga.arp.macro.stubs.MacroArpDerivedObjectStub.arpCopyFrom(
					$e{ this.buildCopyFromBlock() }
				);
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
