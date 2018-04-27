package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.CompositeChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.decorators.CompositeChipHeapsImpl;
#end

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:CompositeChipHeapsImpl;
	#end

	public function new() super();
}
