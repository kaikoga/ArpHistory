package net.kaikoga.arp.macro;

#if macro

import haxe.macro.TypeTools;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpClassInfo;
import net.kaikoga.arp.macro.MacroArpFieldBuilder;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectBuilder extends MacroArpObjectStub {

	public function new(arpTypeName:String, arpTemplateName:String) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
	}

	private function analyzeBaseClasses():Void {
		var map:Map<String, ClassField> = new Map<String, ClassField>();

		var classType:ClassType = Context.getLocalClass().get();
		do {
			var superClass = classType.superClass;
			if (superClass == null) break;
			classType = superClass.t.get();
			for (intfRef in classType.interfaces) {
				var intf:ClassType = intfRef.t.get();
				if (intf.pack.join(".") + "." + intf.name == "net.kaikoga.arp.domain.IArpObject") {
					this.isDerived = true;
				}
			}
			for (field in classType.fields.get()) {
				if (!map.exists(field.name)) map.set(field.name, field);
			}
		} while (classType != null);

		this.mergedBaseFields = map;
	}

	private var mergedBaseFields:Map<String, ClassField>;

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

	public function run():Array<Field> {
		var fqn:String = TypeTools.toString(Context.getLocalType());
		var templateInfo:ArpClassInfo = ArpClassInfo.reference(new ArpType(this.arpTypeName), this.arpTemplateName, fqn, []);
		MacroArpObjectRegistry.registerTemplateInfo(fqn, templateInfo);

		analyzeBaseClasses();
		var outFields:Array<Field> = [];

		for (field in Context.getBuildFields()) {
			var fieldDef:MacroArpFieldDefinition = new MacroArpFieldDefinition(field);
			switch (MacroArpFieldBuilder.fromDefinition(fieldDef)) {
				case MacroArpFieldBuilderResult.Unmanaged:
					outFields.push(field);
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
					Context.warning('${fieldDef.nativeType}', Context.currentPos());
					var type:Type = Context.resolveType(fieldDef.nativeType, Context.currentPos());
					Context.warning('${type}', Context.currentPos());
					var classType:ClassType = switch (type) {
						case TInst(c, _): c.get();
						case _: throw "impl must be class or interface instance";
					}
					Context.warning('${classType}', Context.currentPos());
					if (this.isDerived) {
						outFields = outFields.concat(this.genDerivedImplFields(typePath));
					} else {
						outFields = outFields.concat(this.genImplFields(typePath));
						Context.warning("forward_all_instance_fields()", Context.currentPos());
						Context.warning("and_perhaps_implement_interfaces()", Context.currentPos());
					}
					//throw "not implemented";
				case MacroArpFieldBuilderResult.ArpField(arpField):
					this.arpFields.push(arpField);
					templateInfo.fields.push(arpField.toFieldInfo());
					arpField.buildField(outFields);
				case MacroArpFieldBuilderResult.Constructor(func):
					outFields = outFields.concat(this.genConstructorField(fieldDef.nativeField, func));
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
