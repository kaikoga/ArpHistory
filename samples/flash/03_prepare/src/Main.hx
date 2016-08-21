package;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.CompositeMortal;
import flash.events.Event;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.console.Console;
import haxe.Resource;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import flash.Lib;
import flash.display.PixelSnapping;
import flash.display.BitmapData;
import flash.display.Bitmap;
import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arp.domain.ArpDomain;
import flash.display.Sprite;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addGenerator(new ArpObjectGenerator(RectChip));
		this.domain.addGenerator(new ArpObjectGenerator(NativeTextChip));
		this.domain.addGenerator(new ArpObjectGenerator(StringChip));
		this.domain.addGenerator(new ArpObjectGenerator(ChipMortal));
		this.domain.addGenerator(new ArpObjectGenerator(CompositeMortal));
		this.domain.addGenerator(new ArpObjectGenerator(Console));
		this.domain.addGenerator(new ArpObjectGenerator(Camera));
		this.domain.addGenerator(new ArpObjectGenerator(Field));
		this.domain.addGenerator(new ArpObjectGenerator(DelayLoad));

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
