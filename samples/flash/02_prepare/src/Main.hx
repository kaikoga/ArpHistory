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
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.CompositeMortal;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addTemplate(RectChip);
		this.domain.addTemplate(NativeTextChip);
		this.domain.addTemplate(StringChip);
		this.domain.addTemplate(ChipMortal);
		this.domain.addTemplate(CompositeMortal);
		this.domain.addTemplate(Console);
		this.domain.addTemplate(Camera);
		this.domain.addTemplate(Field);
		this.domain.addTemplate(DelayLoad);

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		this.console = this.domain.query("console", Console).value();
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.domain.heatLater(this.domain.query("delay", DelayLoad).slot());
		this.domain.heatLater(this.domain.query("root", Field).slot());
	}

	private function onEnterFrame(event:Event):Void {
		this.domain.rawTick.dispatch(1.0);
		this.bitmapData.fillRect(this.bitmapData.rect, 0xffffffff);
		this.console.display(this.bitmapData);
	}

	private function onTick(value:Float):Void {
		var mortal:ChipMortal = this.domain.query("/loader", ChipMortal).value();
		if (!this.domain.isPending) mortal.params.set("face", "ok");
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
