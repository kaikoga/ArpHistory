package net.kaikoga.arpx.backends.flash.hud;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.hud.CompositeHud;

class CompositeHudFlashImpl extends ArpObjectImplBase implements IHudFlashImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			for (h in hud.huds) h.copySelf(bitmapData, transform);
		}
	}
}

#end
