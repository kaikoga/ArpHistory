package net.kaikoga.arpx.proc;

import net.kaikoga.arp.ds.IList;

@:arpType("proc", "composite")
class CompositeProc extends Proc {

	@:arpField("proc") public var procs:IList<Proc>;

	public function new() {
		super();
	}

	override public function execute():Void {
		for (proc in this.procs) proc.execute();
	}
}
