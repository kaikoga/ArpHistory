package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.CompositeChipFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.chip.decorators.CompositeChipKhaImpl;
#end

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeChipFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:CompositeChipKhaImpl;
	#end

	public function new() super();
}
