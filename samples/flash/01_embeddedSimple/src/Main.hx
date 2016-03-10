package;

import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.shadow.ChipShadow;
import haxe.Resource;
import net.kaikoga.arp.domain.seed.ArpSeed;
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
		domain.addGenerator(new ArpObjectGenerator(ChipShadow));
		domain.addGenerator(new ArpObjectGenerator(CompositeShadow));

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var rectChip:RectChip = domain.query("rectChip", new RectChip().arpType()).value();
		rectChip.copyChip(bitmapData, new APoint(32, 32));
		var shadow:ChipShadow = domain.query("chipShadow", new ChipShadow().arpType()).value();
		shadow.copySelf(bitmapData, new APoint());
		var shadow2:CompositeShadow = domain.query("compositeShadow", new CompositeShadow().arpType()).value();
		shadow2.copySelf(bitmapData, new APoint());
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
