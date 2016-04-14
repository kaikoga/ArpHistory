package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.task.ITask;

interface IPrepareTask extends ITask {

	var waiting(get, set):Bool;
	var slot(get, never):ArpUntypedSlot;

}
