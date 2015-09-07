package net.kaikoga.arp.persistable;

import haxe.io.Bytes;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;

class TestPersistable implements IPersistable {

	private var nameValue1:String;
	private var nameValue2:String;
	private var booleanValue:Bool;
	private var intValue:Int;
	private var doubleValue:Float;
	private var utfValue:String;
	private var bytesValue:Bytes;
	private var blobValue:Bytes;
	private var childValue:TestPersistable;

	public function new(hasChild:Bool = false) {
		super();
		this.nameValue1 = "name1";
		this.nameValue2 = "name2";
		this.booleanValue = hasChild;
		this.intValue = (hasChild) ? 2 : 1;
		this.doubleValue = 0.5;
		this.utfValue = "utf";
		this.bytesValue = new Bytes();
		this.bytesValue.length = 4;
		this.blobValue = new Bytes();
		this.blobValue.length = 8;
		if (hasChild) {
			this.childValue = new TestPersistable(false);
		}
	}

	public function readSelf(input:IPersistInput):Void {
		this.nameValue1 = input.readName();
		this.nameValue2 = input.readName();
		this.booleanValue = input.readBoolean("booleanValue");
		this.intValue = input.readInt("intValue");
		this.doubleValue = input.readDouble("doubleValue");
		this.utfValue = input.readUTF("utfValue");
		input.readBytes("bytesValue", this.bytesValue, 0, 4);
		input.readBlob("blobValue", this.blobValue);
		if (this.childValue) {
			input.readPersistable("childValue", this.childValue);
		}
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeName(this.nameValue1);
		output.writeName(this.nameValue2);
		output.writeBoolean("booleanValue", this.booleanValue);
		output.writeInt("intValue", this.intValue);
		output.writeDouble("doubleValue", this.doubleValue);
		output.writeUTF("utfValue", this.utfValue);
		output.writeBytes("bytesValue", this.bytesValue, 0, 4);
		output.writeBlob("blobValue", this.blobValue);
		if (this.childValue) {
			output.writePersistable("childValue", this.childValue);
		}
	}

	public function toString():String {
		return [
			"[TestPersistable",
			this.nameValue1,
			this.nameValue2,
			this.booleanValue,
			this.intValue,
			this.doubleValue,
			this.utfValue,
			this.bytesValue.length,
			this.blobValue.length,
			this.childValue,
			"]"].join(" ");
	}
}


