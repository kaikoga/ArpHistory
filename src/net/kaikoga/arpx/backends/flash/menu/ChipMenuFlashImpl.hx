package net.kaikoga.arpx.backends.flash.menu;

import net.kaikoga.arp.structs.ArpParams;
import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.menu.ChipMenu;

class ChipMenuFlashImpl extends ArpObjectImplBase implements IMenuFlashImpl {

	private var menu:ChipMenu;

	public function new(menu:ChipMenu) {
		super();
		this.menu = menu;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (menu.visible && menu.chip != null) {
			var pos:ArpPosition = menu.position;
			var dPos:ArpPosition = menu.dPosition;
			transform = transform.concatXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			for (text in menu.texts) {
				param.set("face", text.publish(param));
				menu.chip.copyChip(bitmapData, transform, param);
				transform._concatXY(dPos.x, dPos.y);
			}
		}
	}
}


