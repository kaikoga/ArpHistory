package net.kaikoga.arpx.backends.flash.mortal;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.menu.Menu;
import net.kaikoga.arpx.mortal.ChipMenuMortal;

class ChipMenuMortalFlashImpl extends ArpObjectImplBase implements IMortalFlashImpl {

	private var mortal:ChipMenuMortal;

	public function new(mortal:ChipMenuMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (mortal.visible && mortal.chip != null) {
			var menu:Menu = mortal.menu;
			var pos:ArpPosition = mortal.position;
			var dPos:ArpPosition = mortal.dPosition;
			transform = transform.concatXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			for (text in menu.texts) {
				param.set("face", text.publish(param));
				mortal.chip.copyChip(bitmapData, transform, param);
				transform._concatXY(dPos.x, dPos.y);
			}
		}
	}
}


