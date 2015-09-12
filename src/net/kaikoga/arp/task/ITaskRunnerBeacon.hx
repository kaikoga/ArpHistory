package net.kaikoga.task;

interface ITaskRunnerBeacon {
	function add(runner:TaskRunner):Void;
	function remove(runner:TaskRunner):Void;
}
