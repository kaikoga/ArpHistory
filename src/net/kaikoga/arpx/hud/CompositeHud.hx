package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.input.IInputControl;
import net.kaikoga.arp.ds.IList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.CompositeHudFlashImpl;
#end

@:arpType("hud", "composite")
class CompositeHud extends Hud {

	@:arpField public var sort:String;
	@:arpField("hud") @:arpBarrier public var huds:IList<Hud>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeHudFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
	}

	override public function visitFocus(other:Null<IInputControl>):Null<IInputControl> {
		if (this.visible) for (hud in this.huds) other = hud.visitFocus(other);
		return other;
	}
}


