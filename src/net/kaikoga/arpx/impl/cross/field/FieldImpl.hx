package net.kaikoga.arpx.impl.cross.field;

import haxe.ds.ArraySort;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
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

	inline private static function compareMortals(a:Mortal, b:Mortal):Int {
		return Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z);
	}
	inline public static function copySortedMortals(mortals:Iterable<Mortal>, context:DisplayContext):Void {
		if (mortals == null) return;
		var temp:Array<Mortal> = [for (m in mortals) m];
		ArraySort.sort(temp, compareMortals);
		for (m in temp) {
			m.render(context);
		}
	}
}
