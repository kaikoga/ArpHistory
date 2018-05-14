package net.kaikoga.arpx.impl.cross.hud;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.Transform;
import net.kaikoga.arpx.hud.ChipMenuHud;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.hud.IHudImpl;
import net.kaikoga.arpx.menu.Menu;

class ChipMenuHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:ChipMenuHud;

	public function new(hud:ChipMenuHud) {
		super();
		this.hud = hud;
	}

	public function render(context:DisplayContext):Void {
		if (hud.visible && hud.chip != null) {
			var menu:Menu = hud.menu;
			var pos:ArpPosition = hud.position;
			var dPos:ArpPosition = hud.dPosition;
			var transform:Transform = context.dupTransform().appendXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			var index:Int = 0;
			for (item in menu.menuItems) {
				param.set("face", item.text.publish(param));
				param.set("selected", index == hud.menu.value);
				param.set("index", index++);
				hud.chip.render(context, param);
				transform = transform.appendXY(dPos.x, dPos.y);
			}
			context.popTransform();
		}
	}
}
