package;

#if arp_backend_flash

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import haxe.Resource;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.mortal.ChipMortal;

class Main extends Sprite {

	public function new() {
		super();
		var bitmapData:BitmapData = new BitmapData(256, 256, true, 0xffffffff);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		addChild(bitmap);

		var domain:ArpDomain = new ArpDomain();
		domain.addTemplate(RectChip);
		domain.addTemplate(ChipMortal);
		domain.addTemplate(CompositeMortal);

		var context = new DisplayContext(bitmapData, new APoint());
		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var rectChip:RectChip = domain.query("rectChip", new RectChip().arpType).value();
		context.pushTransform(new APoint(32, 32));
		rectChip.copyChip(context);
		context.popTransform();
		var mortal:ChipMortal = domain.query("chipMortal", new ChipMortal().arpType).value();
		mortal.render(context);
		var mortal2:CompositeMortal = domain.query("compositeMortal", new CompositeMortal().arpType).value();
		mortal2.render(context);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}

#elseif arp_backend_heaps

import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import hxd.App;
import haxe.Resource;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.mortal.ChipMortal;

class Main extends App {

	public function new() super();

	override function init() {
		var domain:ArpDomain = new ArpDomain();
		domain.addTemplate(RectChip);
		domain.addTemplate(ChipMortal);
		domain.addTemplate(CompositeMortal);

		var context = new DisplayContext(this.s2d, 256, 256, new APoint());
		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		var rectChip:RectChip = domain.query("rectChip", new RectChip().arpType).value();
		context.pushTransform(new APoint(32, 32));
		rectChip.copyChip(context);
		context.popTransform();
		var mortal:ChipMortal = domain.query("chipMortal", new ChipMortal().arpType).value();
		mortal.render(context);
		var mortal2:CompositeMortal = domain.query("compositeMortal", new CompositeMortal().arpType).value();
		mortal2.render(context);
	}

	public static function main():Void {
		new Main();
	}

}

#end
