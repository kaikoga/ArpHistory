package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class OmapOpCase {

	private var me:IOmap<String, Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<IOmap<String, Int>>):Void {
		me = provider.create();
	}


	public function testToArray():Void {
		assertTrue(OmapOp.toArray(me) != null);
	}

}
