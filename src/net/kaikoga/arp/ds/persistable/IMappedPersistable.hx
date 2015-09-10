package net.kaikoga.arp.collections.persistable;

import net.kaikoga.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
interface IMappedPersistable extends IPersistable {

	function clonePersistable(name:String):IMappedPersistable;

}
