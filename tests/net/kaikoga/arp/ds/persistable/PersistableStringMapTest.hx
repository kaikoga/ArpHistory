package net.kaikoga.arp.collections.persistable;

import net.kaikoga.arp.nanotest.ArpSupportTestCase;
import flash.utils.ByteArray;

import net.kaikoga.persistable.TaggedPersistInput;

import net.kaikoga.persistable.TaggedPersistOutput;

/**
	 * ...
	 * @author kaikoga
	 */
class PersistableStringMapTest extends ArpSupportTestCase {

	private var map:PersistableStringMap;

	public function new() {
		super();
	}

	override public function setup():Void {
		this.map = new PersistableStringMap();
	}

	public function test_persist():Void {
		this.map.set("name1", "value1");
		this.map.set("name2", "value2");
		this.map.set("name3", "value3");
		var bytes:ByteArray = new ByteArray();
		this.map.writeSelf(new TaggedPersistOutput(bytes));
		bytes.position = 0;
		this.map = new PersistableStringMap();
		this.map.readSelf(new TaggedPersistInput(bytes));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
		assertEquals("value3", this.map.get("name3"));
		assertEquals("value1", this.map.getAt(0));
		assertEquals("value2", this.map.getAt(1));
		assertEquals("value3", this.map.getAt(2));
	}

}
