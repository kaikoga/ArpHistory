package arpx.impl.stub.chip;

#if arp_display_backend_stub

import arpx.structs.IArpParamsRead;
import arpx.chip.TextureChip;
import arpx.impl.stub.display.DisplayContext;
import arpx.impl.cross.chip.IChipImpl;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void return;
}

#end