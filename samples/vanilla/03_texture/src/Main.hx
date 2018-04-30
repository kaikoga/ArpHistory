package;

import haxe.Resource;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arpx.ArpEngine;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.TextureChip;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.screen.FieldScreen;
import net.kaikoga.arpx.texture.decorators.GridTexture;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.texture.ResourceTexture;

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
		tick: onTick
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
		if (this.domain.isPending) return;
		this.context.clear();
		this.console.render(this.context);
	}

	public static function main():Void new Main();
}
