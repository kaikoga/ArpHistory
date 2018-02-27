package net.kaikoga.arpx.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.backends.flash.chip.decorators.CompositeChipFlashImpl;
#end

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeChipFlashImpl;
#end

	public function new() super();
}
