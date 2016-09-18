package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.nanotest.ArpSupportTestCase;
import flash.utils.ByteArray;

import net.kaikoga.persistable.TaggedPersistInput;
import net.kaikoga.persistable.TaggedPersistOutput;

/**
 * ...
 * @author kaikoga
 */
class PersistableIntMapTest extends ArpSupportTestCase {

	private var map:PersistableIntMap;

	public function new() {
		super();
	}


	override public function setup():Void {
		this.map = new PersistableIntMap();
	}

	public function test_persist():Void {
		this.map.set("name1", 1);
		this.map.set("name2", 2);
		this.map.set("name3", 3);
		var bytes:ByteArray = new ByteArray();
		this.map.writeSelf(new TaggedPersistOutput(bytes));
		bytes.position = 0;
		this.map = new PersistableIntMap();
		this.map.readSelf(new TaggedPersistInput(bytes));
		assertEquals(1, this.map.get("name1"));
		assertEquals(2, this.map.get("name2"));
		assertEquals(3, this.map.get("name3"));
		assertEquals(1, this.map.getAt(0));
		assertEquals(2, this.map.getAt(1));
		assertEquals(3, this.map.getAt(2));
	}

}
