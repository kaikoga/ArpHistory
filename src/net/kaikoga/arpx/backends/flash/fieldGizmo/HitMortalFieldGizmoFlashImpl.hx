package net.kaikoga.arpx.backends.flash.fieldGizmo;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.field.Field;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.fieldGizmo.HitMortalFieldGizmo;

class HitMortalFieldGizmoFlashImpl extends ArpObjectImplBase implements IFieldGizmoFlashImpl {

	private var fieldGizmo:HitMortalFieldGizmo;

	public function new(fieldGizmo:HitMortalFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	@:access(net.kaikoga.arpx.mortal.Mortal.hitMortals)
	@:access(net.kaikoga.arpx.field.Field.hitField)
	public function render(field:Field, context:DisplayContext):Void {
		if (this.fieldGizmo.visible) {
			var pt:Point = context.transform.toPoint();
			var bitmapData:BitmapData = context.bitmapData;
			var rect:Rectangle = new Rectangle(0, 0, field.hitField.size, 16);

			bitmapData.fillRect(rect, 0xffffffff);

			for (mortal in field.mortals) {
				for (hitMortal in mortal.hitMortals) {
					var color = fieldGizmo.hitColorFor(hitMortal).value32;
					var x:Float = hitMortal.hit.x + pt.x;
					var y:Float = hitMortal.hit.y + pt.y;
					var sX:Float = hitMortal.hit.sizeX;
					var sY:Float = hitMortal.hit.sizeY;
					rect.setTo(x - sX, y - sY, 1, sY * 2);
					bitmapData.fillRect(rect, color);
					rect.x = x + sX;
					bitmapData.fillRect(rect, color);
					rect.setTo(x - sX, y - sY, sX * 2, 1);
					bitmapData.fillRect(rect, color);
					rect.y = y + sY;
					bitmapData.fillRect(rect, color);
				}
			}
		}
	}
}

#end
