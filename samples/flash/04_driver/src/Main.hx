package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.Resource;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.GridChip;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.driver.LinearDriver;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.Mortal;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;
	private var camera:Camera;
	private var field:Field;
	private var mortal1:Mortal;
	private var mortal21:Mortal;
	private var mortal22:Mortal;
	private var mortal23:Mortal;
	private var mortal3:Mortal;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.autoAddTemplates();

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		this.console = this.domain.query("console", Console).value();
		this.camera = this.console.cameras.get("main");
		this.field = this.domain.query("root", Field).value();
		this.mortal1 = this.domain.query("mortal1", Mortal).value();
		this.mortal21 = this.domain.query("mortal21", Mortal).value();
		this.mortal22 = this.domain.query("mortal22", Mortal).value();
		this.mortal23 = this.domain.query("mortal23", Mortal).value();
		this.mortal3 = this.domain.query("mortal3", Mortal).value();
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.domain.heatLater(this.domain.query("gridChip", GridChip).slot());
	}

	private function onEnterFrame(event:Event):Void {
		this.domain.rawTick.dispatch(1.0);
	}

	private function onTick(value:Float):Void {
		this.bitmapData.fillRect(this.bitmapData.rect, 0xffffffff);
		this.console.display(this.bitmapData);
		this.mortal1.position.x = (this.mortal1.position.x + 1) % 128;
		this.field.tick();
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

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}