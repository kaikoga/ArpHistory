package net.kaikoga.arp.ds;

/**
 * ...
 * @author kaikoga
 */
interface IIndexedMap<K, V> extends IMap<K, V> {

	/**
	 * Retrieves an entry with given index number from this map.
	 * @param	index The index number of the entry.
	 * @return	The entry value.
	 */
	function getAt(index:Int):V;

	//TEST insert
	//TEST will head insert when index <= 0
	//TEST will append when index >= length
	//TEST will delete existing key before insert when duplicate
	/**
	 * Adds an entry to this map, with the position to insert.
	 * @param	index The index of the entry.
	 * @param	name The name of the entry.
	 * @param	value The entry value.
	 * @return	the index of the entry inserted.
	 */
	function insert(index:Int, key:K, value:V):Int;

	/**
	 * Retrieves an entry name with given index number from this map.
	 * @param	index	The index number of the entry.
	 * @return	The entry name.
	 */
	function keyAt(index:Int):K;

}
