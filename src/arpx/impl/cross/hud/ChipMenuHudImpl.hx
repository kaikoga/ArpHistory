package arpx.impl.cross.hud;

import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;
import arpx.hud.ChipMenuHud;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.hud.IHudImpl;
import arpx.menu.Menu;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

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
				transform.appendXY(dPos.x, dPos.y);
			}
			context.popTransform();
		}
	}
}