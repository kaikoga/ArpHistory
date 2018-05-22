package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.impl.IArpObjectImpl;

@:arpType("mock", "concreteImpl")
class MockConcreteImplMacroArpObject implements IArpObject {

	@:arpField public var map:Map<String, Int>;
	@:arpImpl public var impl:IMockConcreteImpl = new MockConcreteImpl();
	public var _native:String;

	public function new() {
		this._native = "nativeValue";
	}
}

interface IMockConcreteImpl extends IArpObjectImpl {
	var obj:MockConcreteImplMacroArpObject;
	var map:Map<String, Int>;
	var mapCount:Int;
	var native:String;
	var initialHeat:ArpHeat;
}

class MockConcreteImpl implements IMockConcreteImpl {
	public var obj:MockConcreteImplMacroArpObject;
	public var map:Map<String, Int>;
	public var mapCount:Int;
	public var native:String;
	public var initialHeat:ArpHeat = cast -1;
	public var currentHeat:ArpHeat = cast -1;

	public function new(obj:MockConcreteImplMacroArpObject) {
		this.obj = obj;
		this.map = obj.map;
		this.mapCount = if (this.map == null) -1 else [for (x in this.map.iterator()) x].length;
		this.native = obj._native;
		this.initialHeat = this.currentHeat;
	}

	public function arpHeatUp():Bool {
		currentHeat = ArpHeat.Warm;
		return true;
	}
	public function arpHeatDown():Bool {
		currentHeat = ArpHeat.Cold;
		return true;
	}
	public function arpDispose():Void return;
}
