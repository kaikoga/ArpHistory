package;

import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.mortal.ChipMortal;
import haxe.Resource;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import flash.Lib;
import net.kaikoga.arpx.backends.flash.geom.APoint;
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

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var rectChip:RectChip = domain.query("rectChip", new RectChip().arpType()).value();
		rectChip.copyChip(bitmapData, new APoint(32, 32));
		var mortal:ChipMortal = domain.query("chipMortal", new ChipMortal().arpType()).value();
		mortal.copySelf(bitmapData, new APoint());
		var mortal2:CompositeMortal = domain.query("compositeMortal", new CompositeMortal().arpType()).value();
		mortal2.copySelf(bitmapData, new APoint());
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
