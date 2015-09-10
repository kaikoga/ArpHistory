package net.kaikoga.arp.task;


interface ITaskRunnerBeacon {

function add(runner:TaskRunner):Void;
function remove(runner:TaskRunner):Void;

}
