package arp.macro.defs;

#if macro

class MacroArpMetaArpField {
	public var groupName:MacroArpMetaArpFieldName = MacroArpMetaArpFieldName.Default;
	public var elementName:MacroArpMetaArpFieldName = MacroArpMetaArpFieldName.None;

	public function new() return;
}

enum MacroArpMetaArpFieldName {
	None;
	Default;
	Explicit(name:String);
}
#end
