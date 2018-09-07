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
		components.push(new ArpEngineBackend("arp_display_backend", ["heaps", "flash", "openfl", "sys", "stub"]));
		components.push(new ArpEngineBackend("arp_input_backend", ["heaps", "flash", "openfl", "sys", "stub"]));
		components.push(new ArpEngineBackend("arp_audio_backend", ["heaps", "flash", "openfl", "sys", "stub"]));
		components.push(new ArpEngineBackend("arp_socket_backend", ["flash", "openfl", "sys", "stub"]));
		components.push(new ArpEngineBackend("arp_storage_backend", ["flash", "openfl", "sys", "stub"]));

		var root:ArpEngineBackend = new ArpEngineBackend("arp_backend", ["heaps", "flash", "openfl", "sys", "stub"]);
		var rootTarget:TargetDef = root.guessTarget(null);

		for (component in components) component.guessTarget(rootTarget);
		return;
	}
}

class TargetDef {

	private var category:String;
	public var name(default, null):String;

	public var prettyName(get, never):String;
	private function get_prettyName():String return '${category} ${name}';

	public var defineName(get, never):String;
	private function get_defineName():String return '${category}_${name}';

	public function new(category:String, name:String) {
		this.category = category;
		this.name = name;
	}
}

class ArpEngineBackend {

	private var category:String;
	private var target:TargetDef;
	private var targets:Array<TargetDef>;

	public function new(category:String, targetNames:Array<String>) {
		this.category = category;
		this.targets = targetNames.map(name -> new TargetDef(category, name));
		this.consumeDefines();
	}

	private function consumeDefines() {
		var definedTargets:Array<TargetDef> = [];
		for (target in this.targets) {
			if (Context.defined(target.defineName)) definedTargets.push(target);
		}
		switch (definedTargets.length) {
			case 0:
			case 1: this.target = definedTargets[0];
			case _: throw 'Compiler flag conflict: Backends cannot coexist: ${definedTargets.join(",")}';
		}
	}

	public function guessTarget(rootTarget:TargetDef):TargetDef {
		if (this.target != null) {
			Sys.println('Using ${this.target.prettyName}');
			return this.target;
		}

		if (this.target == null && rootTarget != null) {
			// use root target
			for (target in targets) {
				if (target.name == rootTarget.name) {
					this.target = target;
					break;
				}
			}
		}
		if (this.target == null) {
			// use first available target, guess by native defines
			for (target in targets) {
				if (Context.defined(target.name)) {
					this.target = target;
					break;
				}
			}
		}
		if (this.target == null) {
			// use stub
			this.target = targets[targets.length - 1];
		}

		if (this.target != null) {
			Compiler.define(target.defineName);
			Sys.println('Using ${this.target.prettyName} (auto)');
		}
		return this.target;
	}
}
#end
