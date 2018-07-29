package arpx.impl.sys.chip;

#if arp_display_backend_sys

import arpx.structs.IArpParamsRead;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.sys.display.DisplayContext;
import arpx.chip.NativeTextChip;

class NativeTextChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void return;
}

#end
