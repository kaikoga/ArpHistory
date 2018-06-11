package arpx.impl.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import arp.domain.ArpHeat;
import arpx.chip.TextureChip;
import arpx.geom.PointImpl;
import arpx.geom.Transform;
import arpx.impl.backends.flash.display.DisplayContext;
import arpx.impl.backends.flash.texture.decorators.TextureFaceInfo;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class TextureChipFlashImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = new PointImpl();
	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();
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

		var faceInfo:TextureFaceInfo = this.chip.texture.getFaceInfo(params);
		if (faceInfo == null) {
			var index:Int = this.chip.texture.getFaceIndex(params);
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			context.popTransform();
			return;
		}

		var pt:PointImpl = transform.asPoint(_workPt);
		if (pt != null && this.chip.color == null) {
			context.bitmapData.copyPixels(this.chip.texture.bitmapData(), faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
		} else {
			var colorTransform:ColorTransform = this.chip.color.toMultiplier();
			context.bitmapData.draw(faceInfo.data, transform.raw, colorTransform, BlendMode.NORMAL);
		}
		context.popTransform();
	}
}

#end
