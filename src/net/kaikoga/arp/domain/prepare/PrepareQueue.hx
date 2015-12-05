package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.task.TaskRunner;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.IArpObject;

class PrepareQueue {

	public var isPending(get, never):Bool;
	private function get_isPending():Bool return this.taskRunner.isRunning;

	public var tasksProcessed(get, never):Int;
	private function get_tasksProcessed():Int return this.taskRunner.tasksProcessed;

	public var tasksTotal(get, never):Int;
	private function get_tasksTotal():Int return this.taskRunner.tasksTotal;

	public var tasksWaiting(get, never):Int;
	private function get_tasksWaiting():Int return this.taskRunner.tasksWaiting;

	public var taskStatus(get, never):String;
	private function get_taskStatus():String {
		return "[" + Std.string(this.tasksProcessed + 1) + "/" + Std.string(this.tasksTotal) + "]";
	}

	private var domain:ArpDomain;
	private var tasksBySlots:Map<ArpUntypedSlot, IPrepareTask>;
	private var taskRunner:TaskRunner<IPrepareTask>;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.tasksBySlots = new Map();
		this.taskRunner = new TaskRunner(domain.tick, true);
		this.taskRunner.onComplete.push(this.onTaskRunnerComplete);
		this.taskRunner.onError.push(this.onTaskRunnerError);
		this.taskRunner.onDeadlock.push(this.onTaskRunnerDeadlock);
		this.taskRunner.onProgress.push(this.onTaskRunnerProgress);
		this.taskRunner.onCompleteTask.push(this.onCompleteTask);
		this.taskRunner.start();
	}

	private function onTaskRunnerComplete(i:Int):Void {
		// TODO this.dispatchEvent(event);
	}

	private function onTaskRunnerDeadlock(i:Int):Void {
		// TODO this.dispatchEvent(event);
	}

	private function onTaskRunnerProgress(progress:ArpProgressEvent):Void {
		this.domain.log("arp_debug_prepare", "PrepareTaskManager.onTaskRunnerProgress(): [prepare task cycle]");
	}

	private function onTaskRunnerError(error:Dynamic):Void {
		for (task in this.tasksBySlots) {
			// var waitsFor:Array<Dynamic> = task.slot.waitsFor(task.heat).map(this.arpSlotToString);
			// TODO
			this.domain.log("arp", 'PrepareTaskManager.onTaskRunnerError() ${task.slot} ${task.slot.heat}');
			// this.domain.log("arp", 'PrepareTaskManager.onTaskRunnerError() waits for ${waitsFor.length} slots');
			// this.domain.log("arp", 'PrepareTaskManager.onTaskRunnerError() ${waitsFor}');
		}
		// TODO this.dispatchEvent(event);
	}

	private function onCompleteTask(task:IPrepareTask):Void {
		task.slot.heat = ArpHeat.Warm;
		this.tasksBySlots.remove(task.slot);
	}

	private function arpSlotToString(object:IArpObject, index:Int, array:Array<Dynamic>):String {
		return (object != null) ? Std.string(object.arpSlot) : "<invalid reference>";
	}

	public function prepareLater(slot:ArpUntypedSlot):Void {
		if (this.tasksBySlots.exists(slot)) return;
		var task:PrepareTask = new PrepareTask(this.domain, slot);
		this.tasksBySlots.set(slot, task);
		this.taskRunner.append(task);
		task.slot.heat = ArpHeat.Warming;
	}

	public function prepareChildLater(slot:ArpUntypedSlot, name:String, childSlot:ArpUntypedSlot):Void {
		if (this.tasksBySlots.exists(slot)) return;
		throw "PrepareQueue.prepareChildLater()";// TODO
		// var task:IPrepareTask = new PrepareChildTask(this.domain, slot, name, childSlot);
		// this.tasksBySlots.set(slot, task);
		// this.taskRunner.append(task);
		// task.slot.heat = ArpHeat.Warming;
	}

	public function waitBySlot(slot:ArpUntypedSlot):Void {
		if (this.tasksBySlots.exists(slot)) this.taskRunner.wait(this.tasksBySlots.get(slot));
	}

	public function notifyBySlot(slot:ArpUntypedSlot):Void {
		if (this.tasksBySlots.exists(slot)) this.taskRunner.notify(this.tasksBySlots.get(slot));
	}
}
