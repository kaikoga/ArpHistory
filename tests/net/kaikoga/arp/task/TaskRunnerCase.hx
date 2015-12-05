package net.kaikoga.arp.task;

import net.kaikoga.arp.events.ArpSignal;

import picotest.PicoAssert.*;

class TaskRunnerCase {

	private var tick:ArpSignal<Float>;
	private var taskRunner:TaskRunner<ITask>;

	public function setup():Void {
		this.tick = new ArpSignal();
		this.taskRunner = new TaskRunner(this.tick, false);
	}

	public function testSimpleTask():Void {
		taskRunner.append(new DummySimpleTask());
		assertEquals(0, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertFalse(taskRunner.isRunning);
		assertTrue(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
		taskRunner.start();
		assertEquals(0, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertTrue(taskRunner.isRunning);
		assertTrue(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
		this.tick.dispatch(1.0);
		assertEquals(1, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertFalse(taskRunner.isRunning);
		assertFalse(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
	}

	public function testComplexTask():Void {
		var task:DummyProgressTask = new DummyProgressTask(1000);
		taskRunner.append(task);
		assertEquals(0, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertFalse(taskRunner.isRunning);
		assertTrue(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
		assertEquals(1000, task.count);
		taskRunner.start();
		assertEquals(0, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertTrue(taskRunner.isRunning);
		assertTrue(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
		assertEquals(1000, task.count);
		this.tick.dispatch(1.0);
		assertEquals(1, taskRunner.tasksProcessed);
		assertEquals(1, taskRunner.tasksTotal);
		assertEquals(0, taskRunner.tasksWaiting);
		assertFalse(taskRunner.isRunning);
		assertFalse(taskRunner.isActive);
		assertFalse(taskRunner.isWaiting);
		assertEquals(0, task.count);
	}

	public function testImmortalTask():Void {
		assertThrows(
			function() {
				taskRunner.append(new DummyStalledTask());
				assertEquals(0, taskRunner.tasksProcessed);
				assertEquals(1, taskRunner.tasksTotal);
				assertEquals(0, taskRunner.tasksWaiting);
				assertFalse(taskRunner.isRunning);
				assertTrue(taskRunner.isActive);
				assertFalse(taskRunner.isWaiting);
				taskRunner.start();
				assertEquals(0, taskRunner.tasksProcessed);
				assertEquals(1, taskRunner.tasksTotal);
				assertEquals(0, taskRunner.tasksWaiting);
				assertTrue(taskRunner.isRunning);
				assertTrue(taskRunner.isActive);
				assertFalse(taskRunner.isWaiting);
				this.tick.dispatch(1.0);
				assertEquals(0, taskRunner.tasksProcessed);
				assertEquals(1, taskRunner.tasksTotal);
				assertEquals(1, taskRunner.tasksWaiting);
				assertFalse(taskRunner.isRunning);
				assertFalse(taskRunner.isActive);
				assertFalse(taskRunner.isWaiting);
			},
			function(error:Dynamic) {
			}
		);
	}

}

private class DummySimpleTask implements ITask {

	public function new() {
	}

	public function run():TaskStatus return TaskStatus.Complete;

}

private class DummyProgressTask implements ITask {

	public var count:Int = 0;

	public function new(count:Int) {
		this.count = count;
	}

	public function run():TaskStatus return --this.count <= 0 ? TaskStatus.Complete : TaskStatus.Progress;

}

private class DummyStalledTask implements ITask {

	public function new() {
	}

	public function run():TaskStatus return TaskStatus.Stalled;

}
