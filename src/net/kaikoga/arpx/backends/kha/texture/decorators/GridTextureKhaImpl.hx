package net.kaikoga.arpx.backends.kha.texture.decorators;

#if arp_backend_kha

import flash.geom.Rectangle;
import net.kaikoga.arpx.texture.decorators.GridTexture;

class GridTextureKhaImpl extends MultiTextureKhaImplBase<GridTexture> {

	public function new(texture:GridTexture) {
		super(texture);
	}

	override public function arpHeatUp():Bool {
		super.arpHeatUp();

		if (this.faces.length > 0) return true;
		var sourceWidth:Int = this.texture.texture.width;
		var sourceHeight:Int = this.texture.texture.height;

		var faceWidth:Int = this.texture.width;
		if (faceWidth == 0) faceWidth = sourceWidth;
		var faceHeight:Int = this.texture.height;
		if (faceHeight == 0) faceHeight = sourceHeight;

		var isVertical:Bool = this.texture.faceList.isVertical;
		var x:Int = 0;
		var y:Int = 0;
		for (face in this.texture.faceList.toArray()) {
			this.nextFaceName(face);
			for (dir in 0...this.texture.dirs) {
				this.pushFaceInfo(x, y, faceWidth, faceHeight);
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