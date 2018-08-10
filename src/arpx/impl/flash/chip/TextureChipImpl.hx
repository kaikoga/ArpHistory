package arpx.impl.flash.chip;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import arp.domain.ArpHeat;
import arpx.chip.TextureChip;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.Transform;
import arpx.impl.flash.display.DisplayContext;
import arpx.impl.flash.texture.decorators.TextureFaceInfo;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

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

		var faceInfo:TextureFaceInfo = this.chip.texture.getFaceInfo(params);
		if (faceInfo == null) return;

		var transform:Transform = context.dupTransform();
		if (this.chip.baseX | this.chip.baseY != 0) {
			transform.appendXY(-this.chip.baseX, -this.chip.baseY);
		}
		var pt:PointImpl = transform.asPoint(_workPt);
		if (pt != null && this.chip.color == null) {
			context.bitmapData.copyPixels(faceInfo.source, faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
		} else {
			var colorTransform:ColorTransform = this.chip.color.toMultiplier();
			context.bitmapData.draw(faceInfo.data, transform.raw, colorTransform, BlendMode.NORMAL);
		}
		context.popTransform();
	}
}

#end
