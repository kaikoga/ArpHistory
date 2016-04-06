package net.kaikoga.arpx.shadow;

import net.kaikoga.arp.domain.IArpObject;

#if arp_backend_flash
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.backends.flash.shadow.IShadowFlashImpl;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("shadow", "null"))
class Shadow implements IArpObject
#if arp_backend_flash implements IShadowFlashImpl #end
{
	#if arp_backend_flash

	private var flashImpl:IShadowFlashImpl;

	private function createImpl():IShadowFlashImpl return null;

	public function new() {
		flashImpl = createImpl();
	}

	inline public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		flashImpl.copySelf(bitmapData, transform);
	}

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
	// public function frameMove():Void;
}
