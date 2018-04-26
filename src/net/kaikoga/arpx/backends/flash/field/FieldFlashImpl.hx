package net.kaikoga.arpx.backends.flash.field;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import haxe.ds.ArraySort;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.mortal.Mortal;

class FieldFlashImpl extends ArpObjectImplBase implements IFieldFlashImpl {

	private var field:Field;

	public function new(field:Field) {
		super();
		this.field = field;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		copySortedMortals(field.mortals, bitmapData, transform);
	}

	inline public static function copySortedMortals(mortals:Iterable<Mortal>, bitmapData:BitmapData, transform:ITransform):Void {
		var temp:Array<Mortal> = [for (m in mortals) m];
		ArraySort.sort(temp, (a:Mortal, b:Mortal) -> Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z));
		for (m in temp) {
			m.copySelf(bitmapData, transform);
		}
	}
}

#end
