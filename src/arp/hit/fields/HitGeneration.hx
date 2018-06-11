package arp.hit.fields;

@:enum
abstract HitGeneration(Int) {
	var Blue = 1;
	var Green = 2;
	var Eternal = 0;

	inline private function raw():Int return this;

	inline public function next():Void this ^= 3;
	inline public function preserve(gen:HitGeneration):Bool return (this | gen.raw()) == this;
}
