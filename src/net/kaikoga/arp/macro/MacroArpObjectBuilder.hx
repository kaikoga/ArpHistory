package net.kaikoga.arp.macro;

#if macro

import haxe.macro.TypeTools;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;
import net.kaikoga.arp.macro.MacroArpFieldBuilder;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectBuilder extends MacroArpObjectStub {

	public static function build(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}

	private function new(arpTypeName:String, arpTemplateName:String) {
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

	public function run() {
		var templateInfo:ArpTemplateInfo = new ArpTemplateInfo(new ArpType(this.arpTypeName), this.arpTemplateName, []);

		analyzeBaseClasses();
		var outFields:Array<Field> = [];

		for (field in Context.getBuildFields()) {
			var definition:MacroArpFieldDefinition = new MacroArpFieldDefinition(field);
			var arpObjectField:IMacroArpField = MacroArpFieldBuilder.fromDefinition(definition);
			if (arpObjectField == null) {
				outFields.push(field);
				if (definition.metaArpInit != null) {
					outFields = outFields.concat(this.genVoidCallbackField("arpSelfInit", definition.metaArpInit));
				}
				if (definition.metaArpHeatUp != null) {
					outFields = outFields.concat(this.genBoolCallbackField("arpSelfHeatUp", definition.metaArpHeatUp));
				}
				if (definition.metaArpHeatDown != null) {
					outFields = outFields.concat(this.genBoolCallbackField("arpSelfHeatDown", definition.metaArpHeatDown));
				}
				if (definition.metaArpDispose != null) {
					outFields = outFields.concat(this.genVoidCallbackField("arpSelfDispose", definition.metaArpDispose));
				}
			} else {
				this.arpObjectFields.push(arpObjectField);
				templateInfo.fields.push(definition.toFieldInfo());
				arpObjectField.buildField(outFields);
			}
		}
		MacroArpObjectRegistry.registerTemplateInfo(TypeTools.toString(Context.getLocalType()), templateInfo);

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
