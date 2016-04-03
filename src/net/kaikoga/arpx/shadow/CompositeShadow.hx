package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;

#if flash
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
import net.kaikoga.arpx.backends.flash.shadow.CompositeShadowFlashImpl;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "composite"))
class CompositeShadow implements IShadow
#if arp_backend_flash implements IShadowFlashImpl #end
{

	@:arpValue public var visible:Bool = true;
	public var params:ArpParams;
	@:arpValue public var position:ArpPosition;
	@:arpValue public var mass:Float = 1.0;
	@:arpType("shadow") @:arpField("shadow") public var shadows:Map<String, IShadow>;

	#if arp_backend_flash

	public function new() {
		flashImpl = new CompositeShadowFlashImpl(this);
	}

	private var flashImpl:CompositeShadowFlashImpl;

	inline public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		flashImpl.copySelf(bitmapData, transform);
	}

	#else

	public function new () {
	}

	#end
}
