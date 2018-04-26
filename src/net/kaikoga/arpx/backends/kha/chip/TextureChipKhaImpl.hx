package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.Vector2;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.kha.texture.decorators.TextureFaceInfo;
import net.kaikoga.arpx.chip.TextureChip;
import net.kaikoga.arpx.geom.ITransform;

class TextureChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		if (this.chip.baseX | this.chip.baseY != 0) {
			transform = transform.concatXY(-this.chip.baseX, -this.chip.baseY);
		}

		var faceInfo:TextureFaceInfo = this.chip.texture.getFaceInfo(params);
		if (faceInfo == null) {
			var index:Int = this.chip.texture.getFaceIndex(params);
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			return;
		}

		var pt:Vector2 = transform.asPoint();
		if (pt != null) {
			g2.drawSubImage(this.chip.texture.image(), pt.x, pt.y, faceInfo.sx, faceInfo.sy, faceInfo.sw, faceInfo.sh);
		} else {
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
			g2.pushTransformation(FastMatrix3.fromMatrix3(transform.asMatrix()));
			g2.drawSubImage(this.chip.texture.image(), 0, 0, faceInfo.sx, faceInfo.sy, faceInfo.sw, faceInfo.sh);
			g2.popTransformation();
		}
	}
}

#end
