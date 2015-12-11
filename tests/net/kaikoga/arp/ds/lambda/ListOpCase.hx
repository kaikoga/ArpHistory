package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListOpCase {

	private var me:IList<Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<IList<Int>>):Void {
		me = provider.create();
	}

	public function testToArray():Void {
		assertTrue(ListOp.toArray(me) != null);
	}

}
