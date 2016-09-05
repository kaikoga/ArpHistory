package;

import flash.ui.Keyboard;
import net.kaikoga.arpx.input.KeyInput;
import net.kaikoga.arpx.driver.MotionDriver;
import net.kaikoga.arpx.hitFrame.CuboidHitFrame;
import net.kaikoga.arpx.reactFrame.ReactFrame;
import net.kaikoga.arpx.motionFrame.MotionFrame;
import net.kaikoga.arpx.nextMotion.NextMotion;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.motionSet.MotionSet;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.logger.SocketClientLogger;
import net.kaikoga.arpx.socketClient.TcpCachedSocketClient;
import net.kaikoga.arpx.debugger.SocketClientDebugger;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.chip.GridChip;
import flash.events.Event;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.console.Console;
import haxe.Resource;
import net.kaikoga.arp.seed.ArpSeed;
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
	private var field:Field;

	public function new() {
		super();
		this.domain = new ArpDomain();
		this.domain.addGenerator(new ArpObjectGenerator(ResourceFile));
		this.domain.addGenerator(new ArpObjectGenerator(FileTexture));
		this.domain.addGenerator(new ArpObjectGenerator(GridChip));
		this.domain.addGenerator(new ArpObjectGenerator(FaceList));
		this.domain.addGenerator(new ArpObjectGenerator(ChipMortal));
		this.domain.addGenerator(new ArpObjectGenerator(InputLinearDriver));
		this.domain.addGenerator(new ArpObjectGenerator(MotionDriver));
		this.domain.addGenerator(new ArpObjectGenerator(MotionSet));
		this.domain.addGenerator(new ArpObjectGenerator(Motion));
		this.domain.addGenerator(new ArpObjectGenerator(NextMotion));
		this.domain.addGenerator(new ArpObjectGenerator(MotionFrame));
		this.domain.addGenerator(new ArpObjectGenerator(ReactFrame));
		this.domain.addGenerator(new ArpObjectGenerator(CuboidHitFrame));
		this.domain.addGenerator(new ArpObjectGenerator(Field));
		this.domain.addGenerator(new ArpObjectGenerator(Console));
		this.domain.addGenerator(new ArpObjectGenerator(Camera));
		this.domain.addGenerator(new ArpObjectGenerator(SocketClientDebugger));
		this.domain.addGenerator(new ArpObjectGenerator(SocketClientLogger));
		this.domain.addGenerator(new ArpObjectGenerator(TcpCachedSocketClient));
		this.domain.addGenerator(new ArpObjectGenerator(KeyInput));

		this.domain.loadSeed(ArpSeed.fromXmlString(Resource.getString("arpdata")));
		this.domain.tick.push(this.onTick);

		this.bitmapData = new BitmapData(256, 256, true, 0xffffffff);
		addChild(new Bitmap(this.bitmapData, PixelSnapping.NEVER, false));

		this.console = this.domain.query("console", Console).value();
		this.field = this.domain.query("root", Field).value();

		var input:KeyInput = this.domain.query("input", KeyInput).value();
		input.listen(Lib.current.stage);
		input.bindAxis(Keyboard.LEFT, "x", -1);
		input.bindAxis(Keyboard.RIGHT, "x", 1);
		input.bindAxis(Keyboard.UP, "y", -1);
		input.bindAxis(Keyboard.DOWN, "y", 1);

		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.domain.heatLater(this.domain.query("gridChip", GridChip).slot());
	}

	private function onEnterFrame(event:Event):Void {
		this.domain.rawTick.dispatch(1.0);
	}

	private function onTick(value:Float):Void {
		this.field.tick();
		this.bitmapData.fillRect(this.bitmapData.rect, 0xffffffff);
		this.console.display(this.bitmapData);
	}

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

}
