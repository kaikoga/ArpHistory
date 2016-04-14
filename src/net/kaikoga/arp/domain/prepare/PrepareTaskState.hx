package net.kaikoga.arp.domain.prepare;

@:enum abstract PrepareTaskState(Int) {
	var WarmLater = 0;
	var WarmNext = 1;
	var WarmWaiting = 2;
	var WarmComplete = 3;
}
