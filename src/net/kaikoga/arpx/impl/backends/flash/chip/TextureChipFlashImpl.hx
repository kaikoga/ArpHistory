package net.kaikoga.arpx.impl.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.TextureChip;
import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.geom.Transform;
import net.kaikoga.arpx.impl.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.impl.backends.flash.texture.decorators.TextureFaceInfo;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;

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
