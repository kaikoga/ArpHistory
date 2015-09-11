package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.ArpObjectSlot;
import net.kaikoga.task.ITask;

interface IPrepareTask extends ITask {

	var slot(get, never):ArpObjectSlot;
	var heat(get, never):Int;

}
