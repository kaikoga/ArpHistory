package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.access.IMapKnit;
import net.kaikoga.arp.ds.access.IMapRemove;
import net.kaikoga.arp.ds.access.IMapRead;
import net.kaikoga.arp.ds.access.IMapWrite;
import net.kaikoga.arp.ds.access.IMapResolve;

interface IMap<K, V>
extends IMapRead<K, V>
extends IMapWrite<K, V>
extends IMapRemove<K, V>
extends IMapResolve<K, V>
extends IMapKnit<K, V>
{
}
