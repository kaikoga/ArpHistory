package net.kaikoga.arpx.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.backends.flash.chip.decorators.SelectChipFlashImpl;
#end

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:SelectChipFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();
}
