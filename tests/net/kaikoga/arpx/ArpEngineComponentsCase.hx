package net.kaikoga.arpx;

import net.kaikoga.arpx.console.CompositeConsole;
import net.kaikoga.arpx.console.CameraConsole;
import net.kaikoga.arpx.console.AutomatonConsole;
import net.kaikoga.arpx.chip.decorators.DecorateChip;
import net.kaikoga.arpx.texture.Texture;
import net.kaikoga.arpx.texture.ResourceTexture;
import net.kaikoga.arpx.texture.FileTexture;
import net.kaikoga.arpx.state.AutomatonState;
import net.kaikoga.arpx.logger.Logger;
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.debugger.Debugger;
import net.kaikoga.arpx.debugger.SocketClientDebugger;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.file.File;
import net.kaikoga.arpx.file.ResourceFile;
import net.kaikoga.arpx.socketClient.TcpSocketClient;
import net.kaikoga.arpx.socketClient.TcpCachedSocketClient;
import net.kaikoga.arpx.socketClient.SocketClient;
import net.kaikoga.arpx.logger.TraceLogger;
import net.kaikoga.arpx.logger.StoreLogger;
import net.kaikoga.arpx.logger.SocketClientLogger;
import net.kaikoga.arpx.automaton.Automaton;
import net.kaikoga.arpx.anchor.Anchor;
import net.kaikoga.arpx.chip.GridChip;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arpx.text.TextData;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arpx.text.FixedTextData;
import net.kaikoga.arpx.text.ParametrizedTextData;
import net.kaikoga.arpx.chip.RectChip;

import picotest.PicoAssert.*;

class ArpEngineComponentsCase {

	public function testFields() {
		assertNotNull(new Anchor());

		assertNotNull(new Automaton());

		assertNotNull(new Camera());

		assertNotNull(new Chip());
		assertNotNull(new GridChip());
		assertNotNull(new NativeTextChip());
		assertNotNull(new RectChip());
		assertNotNull(new StringChip());

		assertNotNull(new DecorateChip());

		assertNotNull(new Console());
		assertNotNull(new AutomatonConsole());
		assertNotNull(new CameraConsole());
		assertNotNull(new CompositeConsole());

		assertNotNull(new Debugger());
		assertNotNull(new SocketClientDebugger());

		assertNotNull(new FaceList());

		assertNotNull(new Field());

		assertNotNull(new File());
		assertNotNull(new ResourceFile());

		assertNotNull(new Logger());
		assertNotNull(new SocketClientLogger());
		assertNotNull(new StoreLogger());
		assertNotNull(new TraceLogger());

		assertNotNull(new Mortal());
		assertNotNull(new ChipMortal());
		assertNotNull(new CompositeMortal());

		assertNotNull(new SocketClient());
		assertNotNull(new TcpCachedSocketClient());
		assertNotNull(new TcpSocketClient());

		assertNotNull(new AutomatonState());

		assertNotNull(new TextData());
		assertNotNull(new FixedTextData());
		assertNotNull(new ParametrizedTextData());

		assertNotNull(new Texture());
		assertNotNull(new FileTexture());
		assertNotNull(new ResourceTexture());
	}

}
