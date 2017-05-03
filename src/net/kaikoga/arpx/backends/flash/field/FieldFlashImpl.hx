package net.kaikoga.arpx.backends.flash.field;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import flash.display.BitmapData;

import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.field.Field;

class FieldFlashImpl extends ArpObjectImplBase implements IFieldFlashImpl {

	private var field:Field;

	public function new(field:Field) {
		super();
		this.field = field;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		for (m in field.mortals) { // TODO sort mortals
			m.copySelf(bitmapData, transform);
		}
	}

}


