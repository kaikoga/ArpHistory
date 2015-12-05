package net.kaikoga.arp.task;

enum TaskStatus {
	Stalled;
	Progress;
	Complete;
	Error(e:Dynamic);
}
