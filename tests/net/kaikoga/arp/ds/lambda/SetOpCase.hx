package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetOpCase {

	private var me:ISet<Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<ISet<Int>>):Void {
		me = provider.create();
	}

	public function testToArray():Void {
		assertTrue(SetOp.toArray(me) != null);
	}

}
