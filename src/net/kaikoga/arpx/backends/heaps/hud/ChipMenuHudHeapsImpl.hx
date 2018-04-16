package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.hud.ChipMenuHud;
import net.kaikoga.arpx.menu.Menu;

class ChipMenuHudHeapsImpl extends ArpObjectImplBase implements IHudHeapsImpl {

	private var hud:ChipMenuHud;

	public function new(hud:ChipMenuHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (hud.visible && hud.chip != null) {
			var menu:Menu = hud.menu;
			var pos:ArpPosition = hud.position;
			var dPos:ArpPosition = hud.dPosition;
			transform = transform.concatXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			var index:Int = 0;
			for (item in menu.menuItems) {
				param.set("face", item.text.publish(param));
				param.set("selected", index == hud.menu.value);
				param.set("index", index++);
				hud.chip.copyChip(buf, transform, param);
				transform._concatXY(dPos.x, dPos.y);
			}
		}
	}
}

#end
