package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.access.IMapListResolve;
import net.kaikoga.arp.ds.access.IMapListWrite;
import net.kaikoga.arp.ds.access.IMapListRead;

interface IMapList<K, V> extends IMapListRead<K, V> extends IMapListWrite<K, V> extends IMapListResolve<K, V> {
}
