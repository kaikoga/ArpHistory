package net.kaikoga.arpx;

import net.kaikoga.arp.domain.ArpDomain;

typedef ArpEngineParams = {
	var domain:ArpDomain;
	var width:Int;
	var height:Int;
	var clearColor:UInt;
	@:optional var start:Void->Void;
	@:optional var rawTick:Float->Void;
	@:optional var firstTick:Float->Void;
	@:optional var tick:Float->Void;
}
