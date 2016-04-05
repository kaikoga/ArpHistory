package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.MacroArpObjectFieldBuilder;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectBuilder extends MacroArpObjectStub {

	public static function build(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}

	public static function buildDerived(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName, true).run();
	}

	private function new(arpTypeName:String, arpTemplateName:String, isDerived:Bool = false) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
		this.isDerived = isDerived;
	}

	private function mergeBaseFields():Map<String, ClassField> {
		var map:Map<String, ClassField> = new Map<String, ClassField>();

		var classType:ClassType = Context.getLocalClass().get();
		do {
			var superClass = classType.superClass;
			if (superClass == null) break;
			classType = superClass.t.get();
			for (field in classType.fields.get()) {
				if (!map.exists(field.name)) map.set(field.name, field);
			}
		} while (classType != null);
		return map;
	}

	private var _mergedBaseFields:Map<String, ClassField>;
	public var mergedBaseFields(get, never):Map<String, ClassField>;
	private function get_mergedBaseFields():Map<String, ClassField> return (_mergedBaseFields != null) ? _mergedBaseFields : _mergedBaseFields = mergeBaseFields();

	private function merge(target:Array<Field>, source:Array<Field>):Array<Field> {
		for (field in source) {
			var hasField:Bool = false;
			for (t in target) {
				if (field.name == t.name) hasField = true;
			}
			if (!hasField) target.push(field);
		}
		return target;
	}

	public function run() {
		var outFields:Array<Field> = [];

		for (field in Context.getBuildFields()) {
			var arpObjectField:IMacroArpObjectField = MacroArpObjectFieldBuilder.fromField(field);
			if (arpObjectField == null) {
				outFields.push(field);
			} else {
				this.arpObjectFields.push(arpObjectField);
				arpObjectField.buildField(outFields);
			}
		}

		if (this.isDerived) {
			outFields = merge(this.genDerivedTypeFields(), outFields);
		} else {
			outFields = merge(this.genTypeFields(), outFields);
			outFields = merge(outFields, this.genDefaultTypeFields());
		}

		var mergedOutFields:Array<Field> = [];
		for (outField in outFields) {
			if (!mergedBaseFields.exists(outField.name)) {
				// statics not included in mergedBaseFields
				mergedOutFields.push(outField);
				continue;
			}
			switch (outField.kind) {
				case FieldType.FFun(_):
					var access:Array<Access> = outField.access;
					if (access.indexOf(Access.AOverride) < 0) access.push(Access.AOverride);
					mergedOutFields.push(outField);
				case _:
			}
		}

		return mergedOutFields;
	}
}

#end
