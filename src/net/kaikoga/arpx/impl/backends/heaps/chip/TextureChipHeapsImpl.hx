package net.kaikoga.arpx.impl.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Bitmap;
import h2d.Tile;
import h3d.col.Point;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;
import net.kaikoga.arpx.impl.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.TextureChip;
import net.kaikoga.arpx.geom.Transform;

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

		context.drawTile(tile);
		context.popTransform();
		/*
		var colorTransform:ColorTransform = null;
		if (params.getBool("tint")) {
			var ra:Null<Float> = params.getFloat("redMultiplier", 1.0);
			var ga:Null<Float> = params.getFloat("greenMultiplier", 1.0);
			var ba:Null<Float> = params.getFloat("blueMultiplier", 1.0);
			var aa:Null<Float> = params.getFloat("alphaMultiplier", 1.0);
			var rb:Null<Float> = params.getFloat("redOffset", 0.0);
			var gb:Null<Float> = params.getFloat("greenOffset", 0.0);
			var bb:Null<Float> = params.getFloat("blueOffset", 0.0);
			var ab:Null<Float> = params.getFloat("alphaOffset", 0.0);
			colorTransform = new ColorTransform(ra, ga, ba, aa, rb, gb, bb, ab);
		}
		var blendMode:BlendMode = cast params.getAsString("blendMode");
		*/
	}
}

#end
