package net.kaikoga.arp.macro;

#if macro

class MacroArpObject {

	public var classDef(default, null):MacroArpClassDefinition;

	public var arpFields(default, null):Array<IMacroArpField> = [];

	public function new(classDef:MacroArpClassDefinition) {
		this.classDef = classDef;
	}
}

#end
