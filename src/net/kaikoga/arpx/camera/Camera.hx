package net.kaikoga.arpx.camera;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.shadow.IShadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("camera", "camera"))
class Camera implements ICamera
{
	@:arpType("shadow") @:isVar public var shadow(get, set):IShadow;
	inline private function get_shadow():IShadow return shadow;
	inline private function set_shadow(value:IShadow):IShadow return shadow = value;

	@:arpValue @:isVar public var position(get, set):ArpPosition;
	inline private function get_position():ArpPosition return position;
	inline private function set_position(value:ArpPosition):ArpPosition return position = value;

	public function new() {
	}

}
