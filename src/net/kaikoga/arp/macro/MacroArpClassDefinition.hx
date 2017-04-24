package net.kaikoga.arp.macro;

#if macro

class MacroArpClassDefinition {

	public var arpTypeName:String;
	public var arpTemplateName:String;
	public var isDerived:Bool;

	public var hasImpl(get, never):Bool;
	private function get_hasImpl():Bool return false;

	public function new(arpTypeName:String, arpTemplateName:String) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
	}
}

#end
