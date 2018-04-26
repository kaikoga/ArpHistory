package net.kaikoga.arpx.backends.kha.field;

#if arp_backend_kha

import haxe.ds.ArraySort;
import kha.graphics2.Graphics;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.mortal.Mortal;

class FieldKhaImpl extends ArpObjectImplBase implements IFieldKhaImpl {

	private var field:Field;

	public function new(field:Field) {
		super();
		this.field = field;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		copySortedMortals(field.mortals, g2, transform);
	}

	inline public static function copySortedMortals(mortals:Iterable<Mortal>, g2:Graphics, transform:ITransform):Void {
		var temp:Array<Mortal> = [for (m in mortals) m];
		ArraySort.sort(temp, function(a:Mortal, b:Mortal) return Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z));
		for (m in temp) {
			m.copySelf(g2, transform);
		}
	}
}

#end
