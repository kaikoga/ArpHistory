package;

import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.texture.ResourceTexture;
import net.kaikoga.arpx.chip.GridChip;
import flash.events.Event;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.shadow.ChipShadow;
import haxe.Resource;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import flash.Lib;
import flash.display.PixelSnapping;
import flash.display.BitmapData;
import flash.display.Bitmap;
import net.kaikoga.arp.domain.ArpDomain;
import flash.display.Sprite;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addGenerator(new ArpObjectGenerator(ResourceFile));
		this.domain.addGenerator(new ArpObjectGenerator(FileTexture));
		this.domain.addGenerator(new ArpObjectGenerator(ResourceTexture));
		this.domain.addGenerator(new ArpObjectGenerator(GridChip));
		this.domain.addGenerator(new ArpObjectGenerator(FaceList));
		this.domain.addGenerator(new ArpObjectGenerator(ChipShadow));
		this.domain.addGenerator(new ArpObjectGenerator(CompositeShadow));
		this.domain.addGenerator(new ArpObjectGenerator(Console));
		this.domain.addGenerator(new ArpObjectGenerator(Camera));

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		this.console = this.domain.query("console", Console).value();
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.domain.heatLater(this.domain.query("gridChip", GridChip).slot());
	}

	private function onEnterFrame(event:Event):Void {
		this.domain.rawTick.dispatch(1.0);
	}

	private function onTick(value:Float):Void {
		if (this.domain.isPending) return;
		this.bitmapData.fillRect(this.bitmapData.rect, 0xffffffff);
		this.console.display(this.bitmapData);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
