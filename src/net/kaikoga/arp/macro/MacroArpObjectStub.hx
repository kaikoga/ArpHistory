package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.IArpObject;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectStub {

	private var arpTypeName:String;
	private var arpTemplateName:String;
	private var isDerived:Bool;

	private var arpObjectFields:Array<IMacroArpObjectField> = [];

	macro private function buildBlock(iFieldName:String):Expr {
		return macro {
			var block:Array<Expr> = [];
			for (aoField in this.arpObjectFields) aoField.$iFieldName(block);
			return block;
		}
	}

	private function buildInitBlock():Array<Expr> return buildBlock("buildInitBlock");
	private function buildHeatLaterBlock():Array<Expr> return buildBlock("buildHeatLaterBlock");
	private function buildHeatUpBlock():Array<Expr> return buildBlock("buildHeatUpBlock");
	private function buildHeatDownBlock():Array<Expr> return buildBlock("buildHeatDownBlock");
	private function buildDisposeBlock():Array<Expr> return buildBlock("buildDisposeBlock");
	private function buildReadSelfBlock():Array<Expr> return buildBlock("buildReadSelfBlock");
	private function buildWriteSelfBlock():Array<Expr> return buildBlock("buildWriteSelfBlock");
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
		// FIXME
		return ComplexType.TPath({pack:[], name:"Dynamic"});
		//return ComplexType.TPath(this.genSelfTypePath());
	}

	private function buildArpConsumeSeedElement():Array<Expr> {
		var cases:Array<Case> = [];

		var eDefault:Expr = if (isDerived) macro { super.arpConsumeSeedElement(element); } else macro null;
		var expr:Expr = { pos: Context.currentPos(), expr: ExprDef.ESwitch(macro element.typeName(), cases, eDefault) }

		for (aoField in this.arpObjectFields) aoField.buildConsumeSeedElementBlock(cases);

		return [expr];
	}

	private function genTypeFields():Array<Field> {
		var selfTypePath = this.genSelfTypePath();
		var selfComplexType = this.genSelfComplexType();
		return (macro class Generated {
			private var _arpDomain:net.kaikoga.arp.domain.ArpDomain;
			public function arpDomain():net.kaikoga.arp.domain.ArpDomain return this._arpDomain;

			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			public function arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			public function arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			private var _arpSlot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
			public function arpSlot():net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot return this._arpSlot;

			public function arpInit(slot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot, seed:net.kaikoga.arp.domain.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				this._arpDomain = slot.domain;
				this._arpSlot = slot;
				$b{ this.buildInitBlock() }
				if (seed != null) for (element in seed) this.arpConsumeSeedElement(element);
				this.init();
				return this;
			}

			public function arpHeatLater():Void {
				$b{ this.buildHeatLaterBlock() }
			}

			public function arpHeatUp():Bool {
				// $b{ this.buildHeatUpBlock() }
				return this.heatUp();
			}

			public function arpHeatDown():Bool {
				// $b{ this.buildHeatDownBlock() }
				return this.heatDown();
			}

			public function arpDispose():Void {
				$b{ this.buildDisposeBlock() }
				this.dispose();
				this._arpSlot = null;
				this._arpDomain = null;
			}

			private function arpConsumeSeedElement(element:net.kaikoga.arp.domain.seed.ArpSeed):Void {
				$b{ this.buildArpConsumeSeedElement() }
			}

			public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				$b{ this.buildReadSelfBlock() }
			}

			public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				$b{ this.buildWriteSelfBlock() }
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			public function arpClone():net.kaikoga.arp.domain.IArpObject {
				var clone:$selfComplexType = new $selfTypePath();
				clone.arpInit(this._arpDomain.allocSlot());
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
		var selfTypePath = this.genSelfTypePath();
		var selfComplexType = this.genSelfComplexType();
		return (macro class Generated {
			public static var _arpTypeInfo(default, never):net.kaikoga.arp.domain.ArpTypeInfo = new net.kaikoga.arp.domain.ArpTypeInfo($v{arpTemplateName}, new net.kaikoga.arp.domain.core.ArpType($v{arpTypeName}));
			override public function arpTypeInfo():net.kaikoga.arp.domain.ArpTypeInfo return _arpTypeInfo;
			override public function arpType():net.kaikoga.arp.domain.core.ArpType return _arpTypeInfo.arpType;

			override public function arpInit(slot:net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot, seed:net.kaikoga.arp.domain.seed.ArpSeed = null):net.kaikoga.arp.domain.IArpObject {
				$b{ this.buildInitBlock() }
				return super.arpInit(slot, seed);
			}

			override public function arpHeatLater():Void {
				super.arpHeatLater();
				$b{ this.buildHeatLaterBlock() }
			}

			override public function arpHeatUp():Bool {
				// $b{ this.buildHeatUpBlock() }
				return this.heatUp();
			}

			override public function arpHeatDown():Bool {
				// $b{ this.buildHeatDownBlock() }
				return this.heatDown();
			}

			override public function arpDispose():Void {
				$b{ this.buildDisposeBlock() }
				super.arpDispose();
			}

			override private function arpConsumeSeedElement(element:net.kaikoga.arp.domain.seed.ArpSeed):Void {
				$b{ this.buildArpConsumeSeedElement() }
			}

			override public function readSelf(input:net.kaikoga.arp.persistable.IPersistInput):Void {
				super.readSelf(input);
				$b{ this.buildReadSelfBlock() }
			}

			override public function writeSelf(output:net.kaikoga.arp.persistable.IPersistOutput):Void {
				super.writeSelf(output);
				$b{ this.buildWriteSelfBlock() }
			}

			@:access(net.kaikoga.arp.domain.ArpDomain)
			override public function arpClone():net.kaikoga.arp.domain.IArpObject {
				var clone:$selfComplexType = new $selfTypePath();
				clone.arpInit(this._arpDomain.allocSlot());
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
			public function init():Void {
			}

			public function heatUp():Bool {
				return true;
			}

			public function heatDown():Bool {
				return true;
			}

			public function dispose():Void {
			}
		}).fields;
	}
}

#end
