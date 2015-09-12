package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.prepare.PrepareTaskRunner;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.utils.Dictionary;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpObjectSlot;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.task.ITask;

class PrepareTaskManager extends EventDispatcher {
	public var isPending(get, never):Bool;
	public var tasksProcessed(get, never):Int;
	public var tasksTotal(get, never):Int;
	public var tasksWaiting(get, never):Int;
	public var taskStatus(get, never):String;

	private var domain:ArpDomain;
	private var tasksBySlots:Dictionary;
	private var taskRunner:PrepareTaskRunner;

	public function new(domain:ArpDomain) {
		super();
		this.domain = domain;
		this.tasksBySlots = new Dictionary();
		this.taskRunner = new PrepareTaskRunner(this, domain);
		this.taskRunner.addEventListener(Event.COMPLETE, this.onTaskRunnerComplete);
		this.taskRunner.addEventListener(ErrorEvent.ERROR, onTaskRunnerError);
		this.taskRunner.addEventListener(ProgressEvent.PROGRESS, onTaskRunnerProgress);
		this.taskRunner.start(true);
	}

	private function onTaskRunnerComplete(event:Event):Void {
		this.dispatchEvent(event);
	}

	private function onTaskRunnerProgress(event:ProgressEvent):Void {
		this.domain.log("arp_debug_prepare", "PrepareTaskManager.onTaskRunnerProgress(): [prepare task cycle]");
	}

	private function arpSlotToString(object:IArpObject, index:Int, array:Array<Dynamic>):String {
		return (object != null) ? Std.string(object.arpSlot) : "<invalid reference>";
	}

	private function onTaskRunnerError(event:ErrorEvent):Void {
		for (task/* AS3HX WARNING could not determine type for var: task exp: EField(EIdent(this),tasksBySlots) type: null */ in this.tasksBySlots) {
			var message:Array<Dynamic> = [Std.string(task.slot)];
			var waitsFor:Array<Dynamic> = task.slot.waitsFor(task.heat).map(this.arpSlotToString);
			this.domain.log("arp", "PrepareTaskManager.onTaskRunnerError()", Std.string(task.slot));
			this.domain.log("arp", "PrepareTaskManager.onTaskRunnerError()", task.slot.potentialTemperature, task.slot.potentialTemperatureLate, task.heat);
			this.domain.log("arp", "PrepareTaskManager.onTaskRunnerError()", "waits for", waitsFor.length, "slots");
			this.domain.log("arp", "PrepareTaskManager.onTaskRunnerError()", waitsFor);
		}
		this.dispatchEvent(event);
	}

	public function prepareLater(slot:ArpObjectSlot, heat:Int):Void {
		var task:IPrepareTask = this.tasksBySlots[slot];
		if (task != null) {
			if (task.heat >= heat) {
				return;
			}
			else {
				this.taskRunner.halt(task);
			}
		}
		task = new PrepareTask(this, this.domain, slot, heat);
		this.tasksBySlots[slot] = task;
		this.taskRunner.append(task);
	}

	public function prepareChildLater(slot:ArpObjectSlot, name:String, childSlot:ArpObjectSlot, heat:Int):Void {
		var task:IPrepareTask = this.tasksBySlots[slot];
		if (task != null && task.heat >= heat) {
			if (task.heat >= heat) {
				return;
			}
			else {
				this.taskRunner.halt(task);
			}
		}
		task = new PrepareChildTask(this, this.domain, slot, name, childSlot, heat);
		this.tasksBySlots[slot] = task;
		this.taskRunner.append(task);
	}

	private function get_IsPending():Bool {
		return this.taskRunner.isRunning;
	}

	@:allow(net.kaikoga.arp.domain.prepare)
	private function onCompleteTask(task:Dynamic):Void {
		var prepareTask:IPrepareTask = try cast(task, IPrepareTask) catch (e:Dynamic) null;
		if (prepareTask != null) {
			var slot:ArpObjectSlot = prepareTask.slot;
			;
		}
	}

	private function get_TasksProcessed():Int {
		return this.taskRunner.tasksProcessed;
	}

	private function get_TasksTotal():Int {
		return this.taskRunner.tasksTotal;
	}

	private function get_TasksWaiting():Int {
		return this.taskRunner.tasksWaiting;
	}

	private function get_TaskStatus():String {
		return "[" + Std.string(this.tasksProcessed + 1) + "/" + Std.string(this.tasksTotal) + "]";
	}

	public function waitBySlot(slot:ArpObjectSlot):Void {
		var task:ITask = this.tasksBySlots[slot];
		if (task != null) {
			this.taskRunner.wait(task);
		}
	}

	public function notifyBySlot(slot:ArpObjectSlot):Void {
		var task:ITask = this.tasksBySlots[slot];
		if (task != null) {
			this.taskRunner.notify(task);
		}
	}
}
