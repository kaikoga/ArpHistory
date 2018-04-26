package net.kaikoga.arpx.backends.kha.hud;

#if arp_backend_kha

import kha.graphics2.Graphics;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.hud.CompositeHud;

class CompositeHudKhaImpl extends ArpObjectImplBase implements IHudKhaImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			for (h in hud.huds) h.copySelf(g2, transform);
		}
	}
}

#end