package net.kaikoga.arpx.backends.cross.field;

import haxe.ds.ArraySort;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;

class FieldImpl extends ArpObjectImplBase implements IFieldImpl {

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
		ArraySort.sort(temp, (a:Mortal, b:Mortal) -> Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z));
		for (m in temp) {
			m.render(context);
		}
	}
}
