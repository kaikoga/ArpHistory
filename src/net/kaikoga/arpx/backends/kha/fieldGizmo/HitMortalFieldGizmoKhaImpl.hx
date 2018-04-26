package net.kaikoga.arpx.backends.kha.fieldGizmo;

#if arp_backend_kha

import kha.Color;
import kha.graphics2.Graphics;
import kha.math.Vector2;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.fieldGizmo.HitMortalFieldGizmo;
import net.kaikoga.arpx.geom.ITransform;

class HitMortalFieldGizmoKhaImpl extends ArpObjectImplBase implements IFieldGizmoKhaImpl {

	private var fieldGizmo:HitMortalFieldGizmo;

	public function new(fieldGizmo:HitMortalFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	@:access(net.kaikoga.arpx.mortal.Mortal.hitMortals)
	@:access(net.kaikoga.arpx.field.Field.hitField)
	public function render(field:Field, g2:Graphics, transform:ITransform):Void {
		if (this.fieldGizmo.visible) {
			var pt:Vector2 = transform.toPoint();

			g2.fillRect(0, 0, field.hitField.size, 16);

			for (mortal in field.mortals) {
				for (hitMortal in mortal.hitMortals) {
					var x:Float = hitMortal.hit.x + pt.x;
					var y:Float = hitMortal.hit.y + pt.y;
					var sX:Float = hitMortal.hit.sizeX;
					var sY:Float = hitMortal.hit.sizeY;
					g2.color = fieldGizmo.hitColorFor(hitMortal).value32;
					g2.fillRect(x - sX, y - sY, 1, sY * 2);
					g2.fillRect(x + sX, y - sY, 1, sY * 2);
					g2.fillRect(x - sX, y - sY, sX * 2, 1);
					g2.fillRect(x - sX, y + sY, sX * 2, 1);
					g2.color = Color.White;
				}
			}
		}
	}
}

#end
