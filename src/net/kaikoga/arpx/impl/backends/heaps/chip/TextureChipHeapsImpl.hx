package net.kaikoga.arpx.impl.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Tile;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arpx.structs.ArpColor;
import net.kaikoga.arpx.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.TextureChip;
import net.kaikoga.arpx.geom.Transform;
import net.kaikoga.arpx.impl.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;

class TextureChipHeapsImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		var transform:Transform = context.dupTransform();
		if (this.chip.baseX | this.chip.baseY != 0) {
			transform.appendXY(-this.chip.baseX, -this.chip.baseY);
		}

		var tile:Tile = this.chip.texture.getTile(params);
		if (tile == null) {
			var index:Int = this.chip.texture.getFaceIndex(params);
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			context.popTransform();
			return;
		}

		var color:ArpColor = this.chip.color;
		context.drawTile(tile, color.fred, color.fgreen, color.fblue, color.falpha);
		context.popTransform();
	}
}

#end
