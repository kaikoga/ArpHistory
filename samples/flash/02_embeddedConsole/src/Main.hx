package;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.mortal.ChipMortal;
import haxe.Resource;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import flash.Lib;
import flash.display.PixelSnapping;
import flash.display.BitmapData;
import flash.display.Bitmap;
import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arp.domain.ArpDomain;
import flash.display.Sprite;

class Main extends Sprite {

	public function new() {
		super();
		var bitmapData:BitmapData = new BitmapData(256, 256, true, 0xffffffff);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		addChild(bitmap);

		var domain:ArpDomain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(RectChip));
		domain.addGenerator(new ArpObjectGenerator(ChipMortal));
		domain.addGenerator(new ArpObjectGenerator(CompositeMortal));
		domain.addGenerator(new ArpObjectGenerator(Console));
		domain.addGenerator(new ArpObjectGenerator(Camera));
		domain.addGenerator(new ArpObjectGenerator(Field));

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var field1:Field = domain.query("root1", Field._arpTypeInfo).value();
		field1.arpHeatUp();
		var field2:Field = domain.query("root2", Field._arpTypeInfo).value();
		field2.arpHeatUp();
		var console:Console = domain.query("console", Console._arpTypeInfo).value();
		console.display(bitmapData);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
