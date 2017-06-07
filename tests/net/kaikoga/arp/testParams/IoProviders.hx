package net.kaikoga.arp.testParams;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Bytes;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.IInput;
import net.kaikoga.arp.io.IOutput;

#if flash
import flash.utils.ByteArray;
import net.kaikoga.arp.io.flash.DataOutputWrapper;
import net.kaikoga.arp.io.flash.DataInputWrapper;
#end

class IoProviders {
	public static function inputProvider():Iterable<Array<Dynamic>> {
		return [
			[new InputWrapperProvider()]
			#if flash ,[new DataInputWrapperProvider()] #end
		];
	}

	public static function outputProvider():Iterable<Array<Dynamic>> {
		return [
			[new OutputWrapperProvider()]
			#if flash ,[new DataOutputWrapperProvider()] #end
		];
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
		var length = bytesData.length;
		var bytes = Bytes.alloc(length);
		for (i in 0...length) bytes.set(i, bytesData[i]);
		return new InputWrapper(new BytesInput(bytes));
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
		var bytes = this.bytesOutput.getBytes();
		return [for (i in 0...bytes.length) bytes.get(i)];
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
