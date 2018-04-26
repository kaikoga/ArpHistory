package net.kaikoga.arpx.backends.flash.hud;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.hud.CompositeHud;

class CompositeHudFlashImpl extends ArpObjectImplBase implements IHudFlashImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(context:DisplayContext):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			for (h in hud.huds) h.copySelf(context);
			context.popTransform();
		}
	}
}

#end
