package net.kaikoga.arp.testParams;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.io.Fifo;
import net.kaikoga.arp.io.IBufferedInput;
import net.kaikoga.arp.io.IInput;
import net.kaikoga.arp.io.IOutput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.BufferedInput;
import net.kaikoga.arp.io.OutputWrapper;

using net.kaikoga.arp.io.BytesTool;

#if flash
import flash.utils.ByteArray;
import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arp.io.flash.DataInputWrapper;
#end

class IoProviders {
	public static function inputProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new InputWrapperProvider()]);
		providers.push([new FifoInputProvider()]);
		providers.push([new BufferedInputWrapperProvider(new InputWrapperProvider())]);
		providers.push([new BufferedInputWrapperProvider(new FifoInputProvider())]);
		#if flash
		providers.push([new DataInputWrapperProvider()]);
		providers.push([new BufferedInputWrapperProvider(new DataInputWrapperProvider())]);
		#end
		return providers;
	}

	public static function outputProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new OutputWrapperProvider()]);
		providers.push([new FifoOutputProvider()]);
		#if flash
		providers.push([new DataOutputWrapperProvider()]);
		#end
		return providers;
	}
}

typedef IInputProvider = {
	function create(bytesData:Array<Int>):IInput;
}

typedef IOutputProvider = {
	function create():IOutput;
	function bytesData():Array<Int>;
}

class InputWrapperProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		return new InputWrapper(new BytesInput(bytesData.toBytes()));
	}
}

class OutputWrapperProvider {
	private var bytesOutput:BytesOutput;
	public function new() return;
	public function create():IOutput {
		this.bytesOutput = new BytesOutput();
		return new OutputWrapper(this.bytesOutput);
	}
	public function bytesData():Array<Int> {
		return this.bytesOutput.getBytes().toArray();
	}
}

class FifoInputProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		var fifo = new Fifo();
		fifo.bigEndian = true;
		for (i in bytesData) fifo.writeUInt8(i);
		return fifo;
	}
}

class FifoOutputProvider {
	private var fifo:Fifo;
	public function new() return;
	public function create():IOutput {
		this.fifo = new Fifo();
		this.fifo.bigEndian = true;
		return this.fifo;
	}
	public function bytesData():Array<Int> {
		var bytes = Bytes.alloc(this.fifo.bytesAvailable);
		this.fifo.readBytes(bytes, 0, this.fifo.bytesAvailable);
		return bytes.toArray();
	}
}

class BufferedInputWrapperProvider {
	private var provider:IInputProvider;
	public function new(provider:IInputProvider) this.provider = provider;
	public function create(bytesData:Array<Int>):IBufferedInput {
		return new BufferedInput(provider.create(bytesData));
	}
}

#if flash

class DataInputWrapperProvider {
	public function new() return;
	public function create(bytesData:Array<Int>):IInput {
		var length = bytesData.length;
		var bytes = new ByteArray();
		for (i in 0...length) bytes.writeByte(bytesData[i]);
		bytes.position = 0;
		return new DataInputWrapper(bytes);
	}
}

class DataOutputWrapperProvider {
	private var bytes:ByteArray;
	public function new() return;
	public function create():IOutput {
		this.bytes = new ByteArray();
		return new DataOutputWrapper(this.bytes);
	}
	public function bytesData():Array<Int> {
		bytes.position = 0;
		return [for (i in 0...bytes.length) bytes.readUnsignedByte()];
	}
}
#end
