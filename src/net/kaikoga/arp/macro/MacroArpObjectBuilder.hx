package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Compiler;
import haxe.macro.TypeTools;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpClassInfo;
import net.kaikoga.arp.macro.MacroArpFieldBuilder;
import haxe.macro.Context;
import haxe.macro.Expr;

class MacroArpObjectBuilder extends MacroArpObjectSkeleton {

	public function new() super();

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

	public function run(classDef:MacroArpClassDefinition):Array<Field> {
		if (classDef.metaGen) return null;

		var fqn:String = TypeTools.toString(Context.getLocalType());
		var templateInfo:ArpClassInfo = ArpClassInfo.reference(new ArpType(classDef.arpTypeName), classDef.arpTemplateName, fqn, []);
		MacroArpObjectRegistry.registerTemplateInfo(fqn, new MacroArpObject(classDef), templateInfo);

		if (classDef.metaNoGen) return null;

		Compiler.addMetadata("@:arpGen", templateInfo.fqn);

		var outFields:Array<Field> = [];

		for (fieldDef in classDef.fieldDefs) {
			switch (MacroArpFieldBuilder.fromDefinition(fieldDef)) {
				case MacroArpFieldBuilderResult.Unmanaged:
					outFields.push(fieldDef.nativeField);
					if (fieldDef.metaArpInit != null) {
						outFields = outFields.concat(this.genVoidCallbackField("arpSelfInit", fieldDef.metaArpInit));
					}
					if (fieldDef.metaArpHeatUp != null) {
						outFields = outFields.concat(this.genBoolCallbackField("arpSelfHeatUp", fieldDef.metaArpHeatUp));
					}
					if (fieldDef.metaArpHeatDown != null) {
						outFields = outFields.concat(this.genBoolCallbackField("arpSelfHeatDown", fieldDef.metaArpHeatDown));
					}
					if (fieldDef.metaArpDispose != null) {
						outFields = outFields.concat(this.genVoidCallbackField("arpSelfDispose", fieldDef.metaArpDispose));
					}
				case MacroArpFieldBuilderResult.Impl(typePath):
					if (classDef.isDerived) {
						outFields = outFields.concat(this.genDerivedImplFields(typePath));
					} else {
						outFields = outFields.concat(this.genImplFields(typePath));
					}
					// TODO we also want the class to implement impl interface
					//throw "not implemented";
				case MacroArpFieldBuilderResult.ArpField(arpField):
					this.arpFields.push(arpField);
					templateInfo.fields.push(arpField.toFieldInfo());
					arpField.buildField(outFields);
				case MacroArpFieldBuilderResult.Constructor(func):
					outFields = outFields.concat(this.genConstructorField(fieldDef.nativeField, func));
			}
		}

		if (classDef.isDerived) {
			outFields = merge(this.genDerivedTypeFields(), outFields);
		} else {
			outFields = merge(this.genTypeFields(), outFields);
			outFields = merge(outFields, this.genDefaultTypeFields());
		}

		var mergedOutFields:Array<Field> = [];
		for (outField in outFields) {
			if (!classDef.mergedBaseFields.exists(outField.name)) {
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
