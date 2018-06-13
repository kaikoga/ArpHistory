package;

import haxe.Resource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.ArpEngine;
import arpx.camera.Camera;
import arpx.chip.TextureChip;
import arpx.console.Console;
import arpx.impl.cross.display.DisplayContext;
import arpx.faceList.FaceList;
import arpx.field.Field;
import arpx.file.ResourceFile;
import arpx.mortal.ChipMortal;
import arpx.mortal.CompositeMortal;
import arpx.screen.FieldScreen;
import arpx.texture.decorators.GridTexture;
import arpx.texture.FileTexture;
import arpx.texture.ResourceTexture;

class Main extends ArpEngine {

	private var console:Console;
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
		domain.addTemplate(ResourceFile);
		domain.addTemplate(FileTexture);
		domain.addTemplate(ResourceTexture);
		domain.addTemplate(TextureChip);
		domain.addTemplate(GridTexture);
		domain.addTemplate(FaceList);
		domain.addTemplate(ChipMortal);
		domain.addTemplate(CompositeMortal);
		domain.addTemplate(Console);
		domain.addTemplate(Camera);
		domain.addTemplate(Field);
		domain.addTemplate(FieldScreen);

		domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		return domain;
	}

	private function start():Void {
		this.context = createDisplayContext();
	}

	private function onFirstTick(timeslice:Float):Void {
		this.console = this.domain.obj("console", Console);
		this.domain.heatLater(this.domain.query("gridChip", TextureChip).slot());
	}

	private function onTick(timeslice:Float):Void {
	}

	private function onRender():Void {
		if (this.domain.isPending) return;
		this.context.start();
		if (this.console != null) this.console.render(this.context);
		this.context.display();
	}

	public static function main():Void new Main();
}
