package net.kaikoga.arp.testParams;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.IInput;
import net.kaikoga.arp.io.IOutput;

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
		#if flash
		providers.push([new DataInputWrapperProvider()]);
		#end
		return providers;
	}

	public static function outputProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new OutputWrapperProvider()]);
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
