package arpx;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

class ArpEngineMacros {

	private static var instance:ArpEngineMacros;

	public static function init():Array<Field> {
		if (instance == null) instance = new ArpEngineMacros();
		return null;
	}

	private function new() {
		Sys.println('Initializing ArpEngine');
		var components:Array<ArpEngineBackend> = [];
		components.push(new ArpEngineBackend("arp_display_backend", ["heaps", "flash", "openfl", null]));
		components.push(new ArpEngineBackend("arp_input_backend", ["heaps", "flash", "openfl", null]));
		components.push(new ArpEngineBackend("arp_audio_backend", ["heaps", "flash", "openfl", null]));
		components.push(new ArpEngineBackend("arp_socket_backend", ["flash", "openfl", null]));
		components.push(new ArpEngineBackend("arp_storage_backend", ["flash", "openfl", null]));

		var root:ArpEngineBackend = new ArpEngineBackend("arp_backend", ["heaps", "flash", "openfl", null]);
		var rootBackend:String = root.guessBackend(null);

		for (component in components) component.guessBackend(rootBackend);
		return;
	}
}

class ArpEngineBackend {

	private var category:String;
	private var target:String;
	private var targets:Array<String>;

	private function fullName(target:String):String return '${this.category}_${target}';

	public function new(category:String, targets:Array<String>) {
		this.category = category;
		this.targets = targets;
		this.consumeDefines();
	}

	private function consumeDefines() {
		var flagsDefined:Array<String> = [];
		for (target in this.targets) {
			var flagName:String = fullName(target);
			if (Context.defined(flagName)) flagsDefined.push(flagName);
		}
		switch (flagsDefined.length) {
			case 0:
			case 1: this.target = flagsDefined[0];
			case _: throw 'Compiler flag conflict: Backends cannot coexist: ${flagsDefined.join(",")}';
		}
	}

	public function guessBackend(rootBackend:String):String {
		if (this.target != null) return this.target;

		var targets = this.targets.copy();
		if (rootBackend != null && targets.indexOf(rootBackend) > -1) targets.unshift(rootBackend);
		for (target in targets) {
			this.target = target;
			if (this.target != null && Context.defined(target)) break;
		}

		if (this.target != null) {
			Compiler.define(fullName(this.target));
			Sys.println('Using ${this.category} ${this.target}');
		}
		return this.target;
	}
}
#end
