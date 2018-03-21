package net.kaikoga.arp.events;

import net.kaikoga.arp.events.ArpSignal;

import picotest.PicoAssert.*;

class ArpSignalCase {

	private var signal:ArpSignal<Int>;

	public function setup():Void {
		this.signal = new ArpSignal();
	}

	public function testSimpleTask():Void {
		var v:Int = 0;
		var f:Int->Void = i -> v += i;
		this.signal.dispatch(0);
		assertEquals(v, 0);
		this.signal.push(f);
		assertEquals(v, 0);
		this.signal.dispatch(1);
		assertEquals(v, 1);
		this.signal.dispatch(2);
		assertEquals(v, 3);
		this.signal.push(f);
		this.signal.dispatch(2);
		assertEquals(v, 7);
		this.signal.remove(f);
		this.signal.dispatch(10);
		assertEquals(v, 17);
		this.signal.dispatchLazy(() -> 20);
		assertEquals(v, 37);
		this.signal.flush();
		this.signal.dispatch(100);
		assertEquals(v, 37);
	}

	public function testDispatchLazy():Void {
		var v:Int = 0;
		var lazy:Int->Int = i -> { v += i; return i; }
		var f:Int->Void = function(i:Int):Void return;
		this.signal.dispatchLazy(() -> lazy(0x1));
		this.signal.push(f);
		this.signal.dispatchLazy(() -> lazy(0x10));
		this.signal.push(f);
		this.signal.dispatchLazy(() -> lazy(0x100));
		assertEquals(v, 0x110);
	}

}
