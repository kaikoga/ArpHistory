package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.IArpObject;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectStub {

	private var classDef:MacroArpClassDefinition;

	private var arpFields:Array<IMacroArpField> = [];

	private function new(arpTypeName:String, arpTemplateName:String) {
		this.classDef = new MacroArpClassDefinition(arpTypeName, arpTemplateName);
	}

	macro private function buildBlock(iFieldName:String, forPersist:Bool = false):Expr {
		return macro {
			var block:Array<Expr> = [];
			for (arpField in this.arpFields) {
				${if (forPersist) macro {if (!arpField.isPersistable) continue; } else macro null }
				arpField.$iFieldName(block);
			}
			return block;
		}
	}

	private function buildInitBlock():Array<Expr> return buildBlock("buildInitBlock");
	private function buildHeatLaterBlock():Array<Expr> return buildBlock("buildHeatLaterBlock");
	private function buildHeatUpBlock():Array<Expr> return buildBlock("buildHeatUpBlock");
	private function buildHeatDownBlock():Array<Expr> return buildBlock("buildHeatDownBlock");
	private function buildDisposeBlock():Array<Expr> return buildBlock("buildDisposeBlock");
	private function buildReadSelfBlock():Array<Expr> return buildBlock("buildReadSelfBlock", true);
	private function buildWriteSelfBlock():Array<Expr> return buildBlock("buildWriteSelfBlock", true);
	private function buildCopyFromBlock():Array<Expr> return buildBlock("buildCopyFromBlock");

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

	private function buildArpConsumeSeedElement():Array<Expr> {
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

		return [expr];
	}

	private function genTypeFields():Array<Field> {
		var arpTypeName = this.classDef.arpTypeName;
		var arpTemplateName = this.classDef.arpTemplateName;
		var selfTypePath = this.genSelfTypePath();
		var selfComplexType = this.genSelfComplexType();
		return (macro class Generated {
			@:noDoc @:noCompletion private var _arpDomain:net.kaikoga.arp.domain.ArpDomain;
			public var arpDomain(get, never):net.kaikoga.arp.domain.ArpDomain;
			@:noDoc @:noCompletion private function get_arpDomain():net.kaikoga.arp.domain.ArpDomain {
				#if arp_debug
			if (_arpDomain == null) throw("Warning: access to inactive or disposed ArpObject detected");
				#end
			return this._arpDomain;
			}

			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			public var arpTypeInfo(get, never):net.kaikoga.arp.domain.ArpTypeInfo;
			@:noDoc @:noCompletion private function get_arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			public var arpType(get, never):net.kaikoga.arp.domain.core.ArpType;
			@:noDoc @:noCompletion private function get_arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			@:noDoc @:noCompletion private var _arpSlot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
			public var arpSlot(get, never):net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
			@:noDoc @:noCompletion private function get_arpSlot():net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot {
				#if arp_debug
				if (_arpSlot == null) throw("Warning: access to inactive or disposed ArpObject detected");
				#end
				return this._arpSlot;
			}

			public function arpInit(slot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot, seed:net.kaikoga.arp.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				this._arpDomain = slot.domain;
				this._arpSlot = slot;
				$b{ this.buildInitBlock() }
				if (seed != null) for (element in seed) this.arpConsumeSeedElement(element);
				this.arpSelfInit();
				return this;
			}

			public function arpHeatLater():Void {
				$b{ this.buildHeatLaterBlock() }
			}

			public function arpHeatUp():Bool {
				$b{ this.buildHeatUpBlock() }
				if (this.arpSelfHeatUp()) {
					this.arpSlot.heat = net.kaikoga.arp.domain.ArpHeat.Warm;
					return true;
				} else {
					this.arpSlot.heat = net.kaikoga.arp.domain.ArpHeat.Warming;
					return false;
				}
			}

			public function arpHeatDown():Bool {
				// $b{ this.buildHeatDownBlock() }
				return this.arpSelfHeatDown();
			}

			public function arpDispose():Void {
				this.arpHeatDown();
				$b{ this.buildDisposeBlock() }
				this.arpSelfDispose();
				this._arpSlot = null;
				this._arpDomain = null;
			}

			@:noDoc @:noCompletion
			private function arpConsumeSeedElement(element:net.kaikoga.arp.seed.ArpSeed):Void {
				$b{ this.buildArpConsumeSeedElement() }
			}

			public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				var collection:net.kaikoga.arp.persistable.IPersistInput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistInput;
				$b{ this.buildReadSelfBlock() }
			}

			public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				var collection:net.kaikoga.arp.persistable.IPersistOutput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistOutput;
				var uniqId:net.kaikoga.arp.utils.ArpIdGenerator = new net.kaikoga.arp.utils.ArpIdGenerator();
				$b{ this.buildWriteSelfBlock() }
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			public function arpClone():net.kaikoga.arp.domain.IArpObject {
				var clone:$selfComplexType = this._arpDomain.addObject(new $selfTypePath());
				clone.arpCopyFrom(this);
				return clone;
			}

			public function arpCopyFrom(source:net.kaikoga.arp.domain.IArpObject):net.kaikoga.arp.domain.IArpObject {
				var src:$selfComplexType = cast source;
				$b{ this.buildCopyFromBlock() }
				return this;
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
				$b{ this.buildInitBlock() }
				return super.arpInit(slot, seed);
			}

			override public function arpHeatLater():Void {
				super.arpHeatLater();
				$b{ this.buildHeatLaterBlock() }
			}

			override public function arpHeatUp():Bool {
				$b{ this.buildHeatUpBlock() }
				return super.arpHeatUp();
			}

			override public function arpHeatDown():Bool {
				// $b{ this.buildHeatDownBlock() }
				return super.arpHeatDown();
			}

			override public function arpDispose():Void {
				$b{ this.buildDisposeBlock() }
				super.arpDispose();
			}

			@:noDoc @:noCompletion
			override private function arpConsumeSeedElement(element:net.kaikoga.arp.seed.ArpSeed):Void {
				$b{ this.buildArpConsumeSeedElement() }
			}

			override public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				super.readSelf(input);
				var collection:net.kaikoga.arp.persistable.IPersistInput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistInput;
				$b{ this.buildReadSelfBlock() }
			}

			override public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				super.writeSelf(output);
				var collection:net.kaikoga.arp.persistable.IPersistOutput;
				var nameList:Array<String>;
				var values:net.kaikoga.arp.persistable.IPersistOutput;
				var uniqId:net.kaikoga.arp.utils.ArpIdGenerator = new net.kaikoga.arp.utils.ArpIdGenerator();
				$b{ this.buildWriteSelfBlock() }
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			override public function arpClone():net.kaikoga.arp.domain.IArpObject {
				var clone:$selfComplexType = this._arpDomain.addObject(new $selfTypePath());
				clone.arpCopyFrom(this);
				return clone;
			}

			override public function arpCopyFrom(source:net.kaikoga.arp.domain.IArpObject):net.kaikoga.arp.domain.IArpObject {
				var src:$selfComplexType = cast source;
				$b{ this.buildCopyFromBlock() }
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
		return (macro class Generated {
			@:noDoc @:noCompletion
			private var arpImpl:$implType;

			@:noDoc @:noCompletion
			private function createImpl():$implType return null;
		}).fields;
	}

	private function genDerivedImplFields(implTypePath:TypePath):Array<Field> {
		var implType = ComplexType.TPath(implTypePath);
		return (macro class Generated {
			@:noDoc @:noCompletion
			override private function createImpl() return new $implTypePath(this);
		}).fields;
	}

	private function genConstructorField(nativeField:Field, nativeFunc:Function):Array<Field> {
		return [{
			name: "new",
			doc: nativeField.doc,
			access: nativeField.access,
			kind: FieldType.FFun({
				args:nativeFunc.args,
				ret:nativeFunc.ret,
				expr: macro @:mergeBlock {
					${if (this.classDef.hasImpl) {
						macro { /*this.arpImpl = this.createImpl();*/  };
					} else {
						macro { };
					}}
					${nativeFunc.expr}
				},
				params: nativeFunc.params
			}),
			pos: nativeField.pos,
			meta:nativeField.meta
		}];
	}

}

#end
