package arp.hit.fields;


import picotest.PicoAssert.*;

class HitGenerationCase {

	public function testNext() {
		var gen:HitGeneration;
		gen = HitGeneration.Blue;
		gen.next();
		assertEquals(HitGeneration.Green, gen);
		gen = HitGeneration.Green;
		gen.next();
		assertEquals(HitGeneration.Blue, gen);
	}

	public function testPreserve() {
		assertEquals(true, HitGeneration.Blue.preserve(HitGeneration.Blue));
		assertEquals(false, HitGeneration.Blue.preserve(HitGeneration.Green));
		assertEquals(true, HitGeneration.Blue.preserve(HitGeneration.Eternal));
		assertEquals(false, HitGeneration.Green.preserve(HitGeneration.Blue));
		assertEquals(true, HitGeneration.Green.preserve(HitGeneration.Green));
		assertEquals(true, HitGeneration.Green.preserve(HitGeneration.Eternal));
	}
}
