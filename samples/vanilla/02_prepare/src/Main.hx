package;

import arpx.ArpEngine;
import arpx.impl.cross.display.DisplayContext;
import arpx.screen.FieldScreen;
import haxe.Resource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.camera.Camera;
import arpx.chip.NativeTextChip;
import arpx.chip.RectChip;
import arpx.chip.StringChip;
import arpx.console.Console;
import arpx.field.Field;
import arpx.mortal.ChipMortal;
import arpx.mortal.CompositeMortal;

class Main extends ArpEngine {

	private var console:Console;
	private var context:DisplayContext;

	public function new() super({
		domain: createDomain(),
		width: 256,
		height: 256,
		clearColor: 0xffffff,
		start: start,
		rawTick: onRawTick,
		firstTick: onFirstTick,
		tick: onTick,
		render: onRender
	});

	private function createDomain() {
		var domain:ArpDomain = new ArpDomain();
		domain.addTemplate(RectChip);
		domain.addTemplate(NativeTextChip);
		domain.addTemplate(StringChip);
		domain.addTemplate(ChipMortal);
		domain.addTemplate(CompositeMortal);
		domain.addTemplate(Console);
		domain.addTemplate(Camera);
		domain.addTemplate(FieldScreen);
		domain.addTemplate(Field);
		domain.addTemplate(DelayLoad);

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		return domain;
	}

	private function start():Void {
		this.context = createDisplayContext();
	}

	private function onFirstTick(timeslice:Float):Void {
		this.console = domain.obj("console", Console);
		domain.heatLater(domain.query("delay", DelayLoad).slot());
		domain.heatLater(domain.query("root", Field).slot());
	}

	private function onRawTick(timeslice:Float):Void {
		this.context.start();
		this.console.render(this.context);
		this.context.display();
	}

	private function onTick(timeslice:Float):Void {
		var mortal:ChipMortal = domain.obj("/loader", ChipMortal);
		if (!domain.isPending) mortal.params.set("face", "ok");
	}

	private function onRender():Void {
		this.context.start();
		this.console.render(this.context);
		this.context.display();
	}

	public static function main():Void new Main();
}
