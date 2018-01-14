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
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.GridChip;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.debugger.SocketClientDebugger;
import net.kaikoga.arpx.driver.MotionDriver;
import net.kaikoga.arpx.external.FileExternal;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.hitFrame.CuboidHitFrame;
import net.kaikoga.arpx.input.KeyInput;
import net.kaikoga.arpx.logger.SocketClientLogger;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.motionFrame.MotionFrame;
import net.kaikoga.arpx.motionSet.MotionSet;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.TileMapMortal;
import net.kaikoga.arpx.nextMotion.NextMotion;
import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arpx.socketClient.TcpCachedSocketClient;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.tileInfo.TileInfo;
import net.kaikoga.arpx.tileMap.StringTileMap;

class Main extends Sprite {

	private var domain:ArpDomain;

	private var bitmapData:BitmapData;
	private var console:Console;
	private var field:Field;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addTemplate(FileExternal);
		this.domain.addTemplate(ResourceFile);
		this.domain.addTemplate(FileTexture);
		this.domain.addTemplate(GridChip);
		this.domain.addTemplate(FaceList);
		this.domain.addTemplate(TileInfo);
		this.domain.addTemplate(StringTileMap);
		this.domain.addTemplate(ChipMortal);
		this.domain.addTemplate(TileMapMortal);
		this.domain.addTemplate(InputLinearDriver);
		this.domain.addTemplate(MotionDriver);
		this.domain.addTemplate(MotionSet);
		this.domain.addTemplate(Motion);
		this.domain.addTemplate(NextMotion);
		this.domain.addTemplate(MotionFrame);
		this.domain.addTemplate(ReactFrame);
		this.domain.addTemplate(CuboidHitFrame);
		this.domain.addTemplate(Field);
		this.domain.addTemplate(Console);
		this.domain.addTemplate(Camera);
		this.domain.addTemplate(SocketClientDebugger);
		this.domain.addTemplate(SocketClientLogger);
		this.domain.addTemplate(TcpCachedSocketClient);
		this.domain.addTemplate(KeyInput);

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

		this.domain.heatLater(this.domain.query("gridChip", GridChip).slot());
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
