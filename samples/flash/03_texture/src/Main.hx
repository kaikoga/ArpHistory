package;

import net.kaikoga.arpx.screen.FieldScreen;
import net.kaikoga.arpx.texture.decorators.GridTexture;
import net.kaikoga.arpx.chip.TextureChip;
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
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.texture.ResourceTexture;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addTemplate(ResourceFile);
		this.domain.addTemplate(FileTexture);
		this.domain.addTemplate(ResourceTexture);
		this.domain.addTemplate(TextureChip);
		this.domain.addTemplate(GridTexture);
		this.domain.addTemplate(FaceList);
		this.domain.addTemplate(ChipMortal);
		this.domain.addTemplate(CompositeMortal);
		this.domain.addTemplate(Console);
		this.domain.addTemplate(Camera);
		this.domain.addTemplate(Field);
		this.domain.addTemplate(FieldScreen);

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		this.console = this.domain.query("console", Console).value();
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.domain.heatLater(this.domain.query("gridChip", TextureChip).slot());
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
