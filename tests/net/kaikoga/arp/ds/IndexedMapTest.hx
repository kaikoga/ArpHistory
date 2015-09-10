package net.kaikoga.arp.collections;

import net.kaikoga.arp.nanotest.ArpSupportTestCase;

using Lambda;

/**
 * ...
 * @author kaikoga
 */
class IndexedMapTest extends ArpSupportTestCase {

	private var map:IndexedMap<String, String>;

	public function new() {
		super();
	}

	override public function setup():Void {
		this.map = new IndexedMap<String, String>();
	}

	public function test_length():Void {
		assertEquals(0, this.map.length);
		this.map.set("name0", "value0");
		assertEquals(1, this.map.length);
		this.map.set("name1", "value1");
		assertEquals(2, this.map.length);
		this.map.set("name0", "value0");
		assertEquals(2, this.map.length);
		this.map.set("name2", "value2");
		assertEquals(3, this.map.length);
	}

	public function test_keys():Void {
		assertIteratorEquals([].iterator(), this.map.keys());
		this.map.set("name0", "value0");
		assertIteratorEquals(["name0"].iterator(), this.map.keys());
		this.map.set("name1", "value1");
		assertIteratorEquals(["name0", "name1"].iterator(), this.map.keys());
		this.map.set("name0", "value0");
		assertIteratorEquals(["name0", "name1"].iterator(), this.map.keys());
		this.map.set("name2", "value2");
		assertIteratorEquals(["name0", "name1", "name2"].iterator(), this.map.keys());
	}

	public function test_keyAt():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		this.map.set("name2", "value2");
		assertEquals("name0", this.map.keyAt(0));
		assertEquals("name1", this.map.keyAt(1));
		assertEquals("name2", this.map.keyAt(2));
	}

	public function test_set():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		assertEquals("value0", this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value0", this.map.getAt(0));
		assertEquals("value1", this.map.getAt(1));
	}

	public function test_delEntry():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		this.map.remove("name0");
		assertEquals(null, this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value1", this.map.getAt(0));
		assertEquals(null, this.map.getAt(1));
	}

	/*
	public function test_addEntries():Void {
		this.map.set("name0", "value0");
		var map2:IndexedMap = new IndexedMap();
		map2.set("name1", "value1");
		map2.set("name2", "value2");
		this.map.addEntries(map2);
		assertEquals("value0", this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
	}

	public function test_copyFrom():Void {
		this.map.set("name0", "value0");
		var map2:IndexedMap = new IndexedMap();
		map2.set("name1", "value1");
		map2.set("name2", "value2");
		this.map.copyFrom(map2);
		assertEquals(null, this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
	}
	*/

	public function test_setAt():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		this.map.insert(1, "name2", "value2");
		assertEquals("value0", this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
		assertEquals("value0", this.map.getAt(0));
		assertEquals("value2", this.map.getAt(1));
		assertEquals("value1", this.map.getAt(2));
		this.map.insert(1, "name2", "value2");
		assertEquals("value0", this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
		assertEquals("value0", this.map.getAt(0));
		assertEquals("value2", this.map.getAt(1));
		assertEquals("value1", this.map.getAt(2));
	}

	/*
	public function test_insertEntries():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		var map2:IndexedMap = new IndexedMap();
		map2.set("name1", "value1");
		map2.set("name2", "value2");
		this.map.insertEntries(0, map2);
		assertEquals("value0", this.map.get("name0"));
		assertEquals("value1", this.map.get("name1"));
		assertEquals("value2", this.map.get("name2"));
		assertEquals("value1", this.map.getAt(0));
		assertEquals("value2", this.map.getAt(1));
		assertEquals("value0", this.map.getAt(2));
	}

	public function test_flushEntries():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		this.map.flushEntries();
		assertEquals(undefined, this.map.get("name0"));
		assertEquals(undefined, this.map.get("name1"));
		assertEquals(undefined, this.map.getAt(0));
		assertEquals(undefined, this.map.getAt(1));
	}

	public function test_unresolve():void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		assertEquals("name0", this.map.unresolveToName("value0"));
		assertEquals("name1", this.map.unresolveToName("value1"));
		assertEquals(null, this.map.unresolveToName("value2"));
		assertEquals(0, this.map.unresolveToIndex("value0"));
		assertEquals(1, this.map.unresolveToIndex("value1"));
		assertEquals(-1, this.map.unresolveToIndex("value2"));
	}

	public function test_forEach():void {
		this.map.set("name0", "value");
		this.map.set("name1", "value");
		this.map.set("name2", "value");
		this.map.set("name3", "value");
		var s:String = "";
		this.map.forEach(function(entry:*, name:String, map:IMapBase):void {
			s += entry;
		});
		assertEquals("valuevaluevaluevalue", s);
	}

	public function test_toArray():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		assertArrayEquals(["value0", "value1"], this.map.toArray());
	}

	public function test_toObject():Void {
		this.map.set("name0", "value0");
		this.map.set("name1", "value1");
		assertObjectEquals({ name0:"value0", name1:"value1" }, this.map.toObject());
	}
	*/

	public function test_hxIterator():Void {
		this.map.set("name0", "value");
		this.map.set("name1", "value");
		this.map.set("name2", "value");
		this.map.set("name3", "value");
		var s:String = "";
		for (entry in this.map) {
			s += entry;
		}
		assertEquals("valuevaluevaluevalue", s);
	}

}
