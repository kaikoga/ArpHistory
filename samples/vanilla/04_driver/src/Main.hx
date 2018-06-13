package;

import haxe.Resource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.ArpEngine;
import arpx.camera.Camera;
import arpx.chip.TextureChip;
import arpx.console.Console;
import arpx.impl.cross.display.DisplayContext;
import arpx.driver.LinearDriver;
import arpx.field.Field;
import arpx.mortal.Mortal;

class Main extends ArpEngine {

	private var console:Console;
	private var camera:Camera;
	private var field:Field;
	private var mortal1:Mortal;
	private var mortal21:Mortal;
	private var mortal22:Mortal;
	private var mortal23:Mortal;
	private var mortal3:Mortal;
	private var context:DisplayContext;


	public function new() super({
		domain: createDomain(),
		width: 256,
		height: 256,
		clearColor: 0xffffff,
		start: start,
		rawTick: null,
		firstTick: onFirstTick,
		tick: onTick,
		render: onRender
	});

	private function createDomain() {
		var domain:ArpDomain = new ArpDomain();
		domain.autoAddTemplates();

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		return domain;
	}

	private function start():Void {
		this.context = createDisplayContext();
	}

	private function onFirstTick(timeslice:Float):Void {
		this.console = this.domain.obj("console", Console);
		this.camera = this.domain.obj("main", Camera);
		this.field = this.domain.obj("root", Field);
		this.mortal1 = this.domain.obj("mortal1", Mortal);
		this.mortal21 = this.domain.obj("mortal21", Mortal);
		this.mortal22 = this.domain.obj("mortal22", Mortal);
		this.mortal23 = this.domain.obj("mortal23", Mortal);
		this.mortal3 = this.domain.obj("mortal3", Mortal);
		this.domain.heatLater(this.domain.query("gridChip", TextureChip).slot());
	}

	private function onTick(value:Float):Void {
		this.mortal1.position.x = (this.mortal1.position.x + 1) % 128;
		this.field.tick(value);
		if (Math.random() < 0.05) {
			cast(this.mortal21.driver, LinearDriver).toward(30, Math.random() * 256, Math.random() * 256);
		}
		if (Math.random() < 0.05) {
			cast(this.mortal22.driver, LinearDriver).toward(30, Math.random() * 256, Math.random() * 256);
		}
		if (Math.random() < 0.05) {
			cast(this.mortal23.driver, LinearDriver).toward(30, Math.random() * 256, Math.random() * 256);
		}
	}

	private function onRender():Void {
		if (this.domain.isPending) return;
		this.context.start();
		if (this.console != null) this.console.render(this.context);
		this.context.display();
	}

	public static function main():Void new Main();
}
