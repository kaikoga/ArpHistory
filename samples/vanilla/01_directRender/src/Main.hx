package;

import haxe.Resource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.ArpEngine;
import arpx.chip.RectChip;
import arpx.mortal.ChipMortal;
import arpx.mortal.CompositeMortal;

class Main extends ArpEngine {

	public function new() super({
		domain: createDomain(),
		width: 256,
		height: 256,
		clearColor: 0x000000,
		start: null,
		rawTick: null,
		firstTick: onFirstTick,
		tick: null,
		render: onRender
	});

	private function createDomain():ArpDomain {
		var domain:ArpDomain = new ArpDomain();
		domain.addTemplate(RectChip);
		domain.addTemplate(ChipMortal);
		domain.addTemplate(CompositeMortal);
		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		return domain;
	}

	private function onFirstTick(timeslice:Float):Void {
		#if (arp_backend_flash || arp_backend_openfl) doRender(); #end
	}

	private function onRender():Void {
		#if arp_backend_heaps doRender(); #end
	}

	private function doRender():Void {
		var context = this.createDisplayContext();
		context.start();

		var rectChip:RectChip = domain.query("rectChip", new RectChip().arpType).value();
		context.dupTransform().appendXY(32, 32);
		rectChip.render(context);
		context.popTransform();
		var mortal:ChipMortal = domain.query("chipMortal", new ChipMortal().arpType).value();
		mortal.render(context);
		var mortal2:CompositeMortal = domain.query("compositeMortal", new CompositeMortal().arpType).value();
		mortal2.render(context);

		context.display();
	}
	public static function main():Void new Main();
}
