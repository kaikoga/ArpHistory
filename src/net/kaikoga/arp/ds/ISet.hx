package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.access.ISetRead;
import net.kaikoga.arp.ds.access.ISetWrite;

interface ISet<V> extends ISetRead<V> extends ISetWrite<V> {
}
