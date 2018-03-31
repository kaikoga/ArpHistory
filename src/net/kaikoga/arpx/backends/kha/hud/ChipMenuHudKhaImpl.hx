package net.kaikoga.arpx.backends.kha.hud;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.hud.ChipMenuHud;
import net.kaikoga.arpx.menu.Menu;

class ChipMenuHudKhaImpl extends ArpObjectImplBase implements IHudKhaImpl {

	private var hud:ChipMenuHud;

	public function new(hud:ChipMenuHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
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
				hud.chip.copyChip(g2, transform, param);
				transform._concatXY(dPos.x, dPos.y);
			}
		}
	}
}

#end
