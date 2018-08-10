package arpx.impl.heaps.chip;

#if arp_display_backend_heaps

import arpx.impl.cross.texture.TextureFaceData;
import arp.domain.ArpHeat;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;
import arpx.chip.TextureChip;
import arpx.impl.cross.geom.Transform;
import arpx.impl.heaps.display.DisplayContext;
import arpx.impl.cross.chip.IChipImpl;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${chip.arpSlot.sid}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		var faceInfo:TextureFaceData = this.chip.texture.getFaceData(params);
		if (faceInfo == null) return;

		var transform:Transform = context.dupTransform();
		if (this.chip.baseX | this.chip.baseY != 0) {
			transform.appendXY(-this.chip.baseX, -this.chip.baseY);
		}
		var color:ArpColor = this.chip.color;
		context.drawTile(faceInfo.tile, color.fred, color.fgreen, color.fblue, color.falpha);
		context.popTransform();
	}
}

#end
