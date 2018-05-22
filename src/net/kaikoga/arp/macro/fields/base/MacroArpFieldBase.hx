package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import haxe.macro.Expr;
import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.domain.reflect.ArpFieldInfo;
import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import net.kaikoga.arp.macro.MacroArpFieldDefinition;

class MacroArpFieldBase {

	private var fieldDef:MacroArpFieldDefinition;

	private var nativeField(get, never):Field;
	private function get_nativeField():Field return fieldDef.nativeField;
	private var nativeType(get, never):ComplexType;
	private function get_nativeType():ComplexType return fieldDef.nativeType;

	private var arpBarrier(get, never):MacroArpMetaArpBarrier;
	private function get_arpBarrier():MacroArpMetaArpBarrier return fieldDef.metaArpBarrier;
	private var arpHasBarrier(get, never):Bool;
	private function get_arpHasBarrier():Bool {
		return switch (arpBarrier) {
			case MacroArpMetaArpBarrier.None: false;
			case MacroArpMetaArpBarrier.Optional: true;
			case MacroArpMetaArpBarrier.Required: true;
		}
	}
	private var arpBarrierRequired(get, never):Bool;
	private function get_arpBarrierRequired():Bool {
		return switch (arpBarrier) {
			case MacroArpMetaArpBarrier.None: false;
			case MacroArpMetaArpBarrier.Optional: false;
			case MacroArpMetaArpBarrier.Required: true;
		}
	}

	private var nativePos(get, never):Position;
	private function get_nativePos():Position return this.nativeField.pos;

	private var iNativeName(get, never):String;
	private function get_iNativeName():String return this.nativeField.name;
	private var iNativeSlot(get, never):String;
	private function get_iNativeSlot():String return this.nativeField.name + "Slot";
	private var i_nativeName(get, never):String;
	private function get_i_nativeName():String return "__arp__" + this.iNativeName;
	private var iGet_nativeName(get, never):String;
	private function get_iGet_nativeName():String return "get_" + this.iNativeName;
	private var iSet_nativeName(get, never):String;
	private function get_iSet_nativeName():String return "set_" + this.iNativeName;

	private var _arpType:String;
	private var arpType(get, never):String;
	private function get_arpType():String {
		return (_arpType != null) ? _arpType : _arpType = MacroArpObjectRegistry.arpTypeOf(nativeType).toString();
	}
	private var eArpType(get, never):Expr;
	private function get_eArpType():Expr {
		return macro new net.kaikoga.arp.domain.core.ArpType($v{arpType});
	}
	private var fieldName(get, never):String;
	private function get_fieldName():String {
		return switch (fieldDef.metaArpField) {
			case MacroArpMetaArpField.Name(v): v;
			case _: iNativeName;
		}
	}
	private var eFieldName(get, never):ExprOf<String>;
	private function get_eFieldName():ExprOf<String> {
		return macro @:pos(nativePos) $v{this.fieldName};
	}
	public var isSeedable(get, never):Bool;
	private function get_isSeedable():Bool {
		return switch (fieldDef.metaArpField) {
			case MacroArpMetaArpField.Unmanaged: false;
			case MacroArpMetaArpField.Runtime: false;
			case _: true;
		}
	}
	public var isPersistable(get, never):Bool;
	private function get_isPersistable():Bool {
		return !fieldDef.metaArpVolatile;
	}

	private var arpFieldKind(get, never):ArpFieldKind;
	private function get_arpFieldKind():ArpFieldKind return ArpFieldKind.ReferenceKind;
	private var arpFieldDs(get, never):ArpFieldDs;
	private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.Scalar;

	private function new(fieldDef:MacroArpFieldDefinition) {
		this.fieldDef = fieldDef;
	}

	@:final public function toFieldInfo():ArpFieldInfo {
		return new ArpFieldInfo(
			this.fieldName,
			new ArpType(this.arpType),
			this.arpFieldKind,
			this.arpFieldDs,
			this.nativeField.name,
			this.arpHasBarrier
		);
	}
}

#end
