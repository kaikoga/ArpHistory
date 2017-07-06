package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Expr;
import haxe.macro.Expr.MetadataEntry;
import haxe.macro.ExprTools;
import haxe.macro.Type;
import haxe.macro.Context;

class MacroArpClassDefinition {

	public var metaNoGen(default, null):Bool = false;
	public var arpTypeName(default, null):String;
	public var arpTemplateName(default, null):String;

	public var isDerived(default, null):Bool = false;
	public var hasImpl(default, null):Bool = false;

	public var fieldDefs(default, null):Array<MacroArpFieldDefinition>;
	public var mergedBaseFields:Map<String, ClassField>;

	public function new(classType:ClassType) {
		this.fieldDefs = [];
		this.mergedBaseFields = new Map<String, ClassField>();

		this.loadMeta(classType);
		if (!this.metaNoGen) {
			this.loadClassFields();
			this.loadBaseClasses(classType);
		}
	}

	private function loadMeta(classType:ClassType):Void {
		var metaNoGen:MetadataEntry = classType.meta.extract(":arpNoGen")[0];
		if (metaNoGen != null) {
			this.metaNoGen = true;
		}
		var metaArpType:MetadataEntry = classType.meta.extract(":arpType")[0];
		if (metaArpType != null) {
			var typeMeta:Expr = metaArpType.params[0];
			var templateMeta:Expr = metaArpType.params[1];
			this.arpTypeName = typeMeta != null ? ExprTools.getValue(typeMeta) : null;
			this.arpTemplateName = templateMeta != null ? ExprTools.getValue(templateMeta) : null;
		}
		if (this.arpTemplateName == null) {
			this.arpTemplateName = this.arpTypeName;
		}
	}

	private function loadClassFields():Void {
		for (field in Context.getBuildFields()) {
			var fieldDef:MacroArpFieldDefinition = new MacroArpFieldDefinition(field);
			this.fieldDefs.push(fieldDef);
			if (fieldDef.metaArpImpl) this.hasImpl = true;
		}
	}

	private function loadBaseClasses(classType:ClassType):Void {
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
				if (!this.mergedBaseFields.exists(field.name)) {
					this.mergedBaseFields.set(field.name, field);
				}
			}
		} while (classType != null);
	}
}

#end
