package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.access.IListKnit;
import net.kaikoga.arp.ds.access.IListRemove;
import net.kaikoga.arp.ds.access.IListResolve;
import net.kaikoga.arp.ds.access.IListWrite;
import net.kaikoga.arp.ds.access.IListRead;

interface IList<V>
extends IListRead<V>
extends IListWrite<V>
extends IListRemove<V>
extends IListResolve<V>
extends IListKnit<V>
{
}
