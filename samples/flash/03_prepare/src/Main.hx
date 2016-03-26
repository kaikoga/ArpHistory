package;

import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.shadow.ChipShadow;
import haxe.Resource;
import net.kaikoga.arp.domain.seed.ArpSeed;
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
		domain.addGenerator(new ArpObjectGenerator(NativeTextChip));
		domain.addGenerator(new ArpObjectGenerator(StringChip));
		domain.addGenerator(new ArpObjectGenerator(ChipShadow));
		domain.addGenerator(new ArpObjectGenerator(CompositeShadow));
		domain.addGenerator(new ArpObjectGenerator(Console));
		domain.addGenerator(new ArpObjectGenerator(Camera));

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var console:Console = domain.query("console", new Console().arpType()).value();
		console.display(bitmapData);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
