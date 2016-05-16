package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;

#if flash
import net.kaikoga.arpx.backends.flash.shadow.CompositeShadowFlashImpl;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "composite"))
class CompositeShadow extends Shadow {

	@:arpField public var visible:Bool = true;
	public var params:ArpParams;
	@:arpField public var position:ArpPosition;
	@:arpField public var mass:Float = 1.0;
	@:arpField("shadow") public var shadows:ISet<Shadow>;

	#if arp_backend_flash

	override private function createImpl():IShadowFlashImpl return new CompositeShadowFlashImpl(this);

	public function new () {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
