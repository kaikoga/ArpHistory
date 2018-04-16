package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.hud.CompositeHud;

class CompositeHudHeapsImpl extends ArpObjectImplBase implements IHudHeapsImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			for (h in hud.huds) h.copySelf(buf, transform);
		}
	}
}

#end
