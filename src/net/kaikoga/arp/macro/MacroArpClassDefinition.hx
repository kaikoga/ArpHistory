package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Type;
import haxe.macro.Context;

class MacroArpClassDefinition {

	public var arpTypeName(default, null):String;
	public var arpTemplateName(default, null):String;

	public var fieldDefs(default, null):Array<MacroArpFieldDefinition>;
	public var hasImpl(default, null):Bool = false;

	public var isDerived(default, null):Bool;
	public var mergedBaseFields:Map<String, ClassField>;

	public function new(arpTypeName:String, arpTemplateName:String) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
		this.fieldDefs = [];
		this.hasImpl = false;
		this.mergedBaseFields = new Map<String, ClassField>();

		this.loadClassFields();
		this.loadBaseClasses();
	}

	private function loadClassFields():Void {
		for (field in Context.getBuildFields()) {
			var fieldDef:MacroArpFieldDefinition = new MacroArpFieldDefinition(field);
			this.fieldDefs.push(fieldDef);
			if (fieldDef.metaArpImpl) this.hasImpl = true;
		}
	}

	private function loadBaseClasses():Void {
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
				if (!this.mergedBaseFields.exists(field.name)) {
					this.mergedBaseFields.set(field.name, field);
				}
			}
		} while (classType != null);
	}
}

#end
