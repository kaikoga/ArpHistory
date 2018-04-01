package;

import flash.display.PixelSnapping;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.ui.Keyboard;
import flash.Lib;
import haxe.Resource;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.input.KeyInput;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;
	private var field:Field;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.autoAddTemplates();

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onFirstTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(event:Event):Void {
		this.domain.rawTick.dispatch(1.0);
	}

	private function onFirstTick(value:Float):Void {
		this.domain.tick.remove(this.onFirstTick);
		this.console = this.domain.query("console", Console).value();
		this.field = this.domain.query("root", Field).value();

		var input:KeyInput = this.domain.query("input", KeyInput).value();
		input.listen(Lib.current.stage);
		input.bindAxis(Keyboard.LEFT, "x", -1);
		input.bindAxis(Keyboard.RIGHT, "x", 1);
		input.bindAxis(Keyboard.UP, "y", -1);
		input.bindAxis(Keyboard.DOWN, "y", 1);

		this.domain.heatLater(this.domain.query("gridChip", Chip).slot());
		this.domain.tick.push(this.onTick);
	}

	private function onTick(value:Float):Void {
		this.field.tick(value);
		this.bitmapData.fillRect(this.bitmapData.rect, 0xffffffff);
		this.console.display(this.bitmapData);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
