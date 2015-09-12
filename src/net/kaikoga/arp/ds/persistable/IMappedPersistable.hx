package net.kaikoga.arp.ds.persistable;

import net.kaikoga.arp.persistable.IPersistable;

/**
 * ...
 * @author kaikoga
 */
interface IMappedPersistable extends IPersistable {

	function clonePersistable(name:String):IMappedPersistable;

}
