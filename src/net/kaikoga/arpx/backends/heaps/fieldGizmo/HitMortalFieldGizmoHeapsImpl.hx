package net.kaikoga.arpx.backends.heaps.fieldGizmo;

#if arp_backend_heaps

import net.kaikoga.arpx.field.Field;
import h2d.Bitmap;
import h2d.Tile;
import h3d.col.Point;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.fieldGizmo.HitMortalFieldGizmo;

class HitMortalFieldGizmoHeapsImpl extends ArpObjectImplBase implements IFieldGizmoHeapsImpl {

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

			var tile:Tile = Tile.fromColor(0xffffffff, field.hitField.size, 16);
			var b = new Bitmap(tile, context.buf);
			for (mortal in field.mortals) {
				for (hitMortal in mortal.hitMortals) {
					var x:Float = hitMortal.hit.x + pt.x;
					var y:Float = hitMortal.hit.y + pt.y;
					var sX:Float = hitMortal.hit.sizeX;
					var sY:Float = hitMortal.hit.sizeY;
					var tile:Tile = Tile.fromColor(fieldGizmo.hitColorFor(hitMortal).value32);
					inline function fillRect(x, y, w, h) {
						var b = new Bitmap(tile, context.buf);
						b.x = x;
						b.y = y;
						b.scaleX = w;
						b.scaleY = h;
					}
					fillRect(x - sX, y - sY, 1, sY * 2);
					fillRect(x + sX, y - sY, 1, sY * 2);
					fillRect(x - sX, y - sY, sX * 2, 1);
					fillRect(x - sX, y + sY, sX * 2, 1);
				}
			}
		}
	}
}

#end