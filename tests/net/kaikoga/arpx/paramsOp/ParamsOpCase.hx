﻿package net.kaikoga.arpx.paramsOp;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.seed.ArpSeed;

import picotest.PicoAssert.*;

class ParamsOpCase {

	private var domain:ArpDomain;
	private var me:ParamsOp;

	public function setup() {
		var xml:Xml = Xml.parse('<paramsOp name="me" fixedParams="k1:a1,k2:a2" rewireParams="k3:k4" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(ParamsOp));
		domain.loadSeed(seed);
		me = domain.query("me", ParamsOp).value();
	}

	public function testFilterEmpty():Void {
		var inParams:ArpParams = new ArpParams();
		var params:ArpParams = me.filter(inParams);
		assertMatch('a1', params.get('k1'));
		assertMatch('a2', params.get('k2'));
		assertMatch(null, params.get('k3'));
	}

	public function testFilter():Void {
		var inParams:ArpParams = new ArpParams();
		inParams.set('k1', 'b1');
		inParams.set('k2', 'b2');
		inParams.set('k3', 'b3');
		inParams.set('k4', 'b4');
		var params:ArpParams = me.filter(inParams);
		assertMatch('a1', params.get('k1'));
		assertMatch('a2', params.get('k2'));
		assertMatch('b4', params.get('k3'));
		assertMatch(null, params.get('k4'));
	}
}