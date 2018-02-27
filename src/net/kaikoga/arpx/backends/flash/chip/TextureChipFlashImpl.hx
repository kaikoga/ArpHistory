package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Point;
import net.kaikoga.arpx.backends.flash.texture.decorators.TextureFaceInfo;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.TextureChip;

class TextureChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
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

		var pt:Point = transform.asPoint();
		if (pt != null) {
			bitmapData.copyPixels(this.chip.texture.bitmapData(), faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
		} else {
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
			bitmapData.draw(faceInfo.data, transform.toMatrix(), colorTransform, blendMode);
		}
	}
}

#end
