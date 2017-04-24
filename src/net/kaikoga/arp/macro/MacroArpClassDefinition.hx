package net.kaikoga.arp.macro;

#if macro

class MacroArpClassDefinition {

	public var arpTypeName:String;
	public var arpTemplateName:String;
	public var isDerived:Bool;

	public function new(arpTypeName:String, arpTemplateName:String) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
	}
}

#end
