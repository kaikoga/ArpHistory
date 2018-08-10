package arpx.impl.flash.texture.decorators;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.decorators.GridTexture;

class GridTextureImpl extends MultiTextureImplBase<GridTexture> implements ITextureImpl {

	public function new(texture:GridTexture) {
		super(texture);
	}

	override public function arpHeatUp():Bool {
		super.arpHeatUp();

		if (this.faces.length > 0) return true;
		var faceInfo:TextureFaceInfo = this.texture.texture.getFaceInfo();
		var sourceWidth:Int = this.texture.texture.width;
		var sourceHeight:Int = this.texture.texture.height;
		var bitmapData:BitmapData = faceInfo.data;

		var faceWidth:Int = this.texture.width;
		if (faceWidth == 0) faceWidth = sourceWidth;
		var faceHeight:Int = this.texture.height;
		if (faceHeight == 0) faceHeight = sourceHeight;

		var isVertical:Bool = this.texture.faceList.isVertical;
		var x:Int = 0;
		var y:Int = 0;
		for (face in this.texture.faceList) {
			this.nextFaceName(face);
			for (dir in 0...this.texture.dirs) {
				this.pushFaceInfo(TextureFaceInfo.trimmed(bitmapData, x, y, faceWidth, faceHeight));
				if (isVertical) {
					y += faceHeight;
					if (y >= sourceHeight) {
						y = 0;
						x += faceWidth;
					}
				} else {
					x += faceWidth;
					if (x >= sourceWidth) {
						x = 0;
						y += faceHeight;
					}
				}
			}
		}
		return true;
	}
}

#end
