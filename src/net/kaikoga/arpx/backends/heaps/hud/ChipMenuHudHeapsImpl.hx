package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.hud.IHudImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.hud.ChipMenuHud;
import net.kaikoga.arpx.menu.Menu;

class ChipMenuHudHeapsImpl extends ArpObjectImplBase implements IHudImpl {

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
			context = new DisplayContext(context.buf, context.width, context.height, context.transform);
			context.transform.appendXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			var index:Int = 0;
			for (item in menu.menuItems) {
				param.set("face", item.text.publish(param));
				param.set("selected", index == hud.menu.value);
				param.set("index", index++);
				hud.chip.render(context, param);
				context.transform.appendXY(dPos.x, dPos.y);
			}
			context.popTransform();
		}
	}
}

#end
