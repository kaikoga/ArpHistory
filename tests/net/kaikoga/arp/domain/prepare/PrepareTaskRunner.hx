package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.task.TaskRunner;

class PrepareTaskRunner extends TaskRunner {

	private var master:PrepareTaskManager;
	private var domain:ArpDomain;

	@:allow(net.kaikoga.arp.domain.prepare)
	private function new(master:PrepareTaskManager, domain:ArpDomain) {
		super();
		this.master = master;
		this.domain = domain;
	}

	override private function runOneTask(task:Dynamic):Bool {
		var result:Bool = super.runOneTask(task);
		if (result) {
			master.onCompleteTask(task);
		}
		return result;
	}
}
