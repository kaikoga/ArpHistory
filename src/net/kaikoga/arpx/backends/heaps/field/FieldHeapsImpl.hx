package net.kaikoga.arpx.backends.heaps.field;

#if arp_backend_heaps

import h2d.Sprite;
import haxe.ds.ArraySort;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;

class FieldHeapsImpl extends ArpObjectImplBase implements IFieldHeapsImpl {

	private var field:Field;

	public function new(field:Field) {
		super();
		this.field = field;
	}

	public function render(context:DisplayContext):Void {
		copySortedMortals(field.mortals, context);
	}

	inline public static function copySortedMortals(mortals:Iterable<Mortal>, context:DisplayContext):Void {
		var temp:Array<Mortal> = [for (m in mortals) m];
		ArraySort.sort(temp, function(a:Mortal, b:Mortal) return Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z));
		for (m in temp) {
			m.render(context);
		}
	}
}

#end
