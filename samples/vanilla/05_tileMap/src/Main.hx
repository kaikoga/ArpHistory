package;

import haxe.Resource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.ArpEngine;
import arpx.chip.Chip;
import arpx.console.Console;
import arpx.impl.cross.display.DisplayContext;
import arpx.field.Field;
import arpx.input.KeyInput;

#if arp_backend_flash
import flash.Lib;
import flash.ui.Keyboard;
#elseif arp_backend_heaps
import hxd.Key;
#end

class Main extends ArpEngine {

	private var console:Console;
	private var field:Field;
	private var input:KeyInput;
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

	private function createDomain():ArpDomain {
		var domain:ArpDomain = new ArpDomain();
		domain.autoAddTemplates();

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		return domain;
	}

	private function start():Void {
		this.context = createDisplayContext();
	}
	private function onFirstTick(value:Float):Void {
		this.console = this.domain.obj("console", Console);
		this.field = this.domain.obj("root", Field);

		this.input = this.domain.obj("input", KeyInput);
#if arp_backend_flash
		this.input.listen(Lib.current.stage);
		this.input.bindAxis(Keyboard.LEFT, "x", -1);
		this.input.bindAxis(Keyboard.RIGHT, "x", 1);
		this.input.bindAxis(Keyboard.UP, "y", -1);
		this.input.bindAxis(Keyboard.DOWN, "y", 1);
#elseif arp_backend_heaps
		this.input.listen();
		this.input.bindAxis(Key.LEFT, "x", -1);
		this.input.bindAxis(Key.RIGHT, "x", 1);
		this.input.bindAxis(Key.UP, "y", -1);
		this.input.bindAxis(Key.DOWN, "y", 1);
#end
		this.domain.heatLater(this.domain.query("gridChip", Chip).slot());
	}

	private function onTick(value:Float):Void {
		this.field.tick(value);
	}

	private function onRender():Void {
		if (this.domain.isPending) return;
		this.context.start();
		if (this.console != null) this.console.render(this.context);
		this.context.display();
	}

	public static function main():Void new Main();
}
