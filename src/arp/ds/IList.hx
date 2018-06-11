package arp.ds;

import arp.ds.access.IListKnit;
import arp.ds.access.IListRemove;
import arp.ds.access.IListResolve;
import arp.ds.access.IListWrite;
import arp.ds.access.IListRead;

interface IList<V>
extends IListRead<V>
extends IListWrite<V>
extends IListRemove<V>
extends IListResolve<V>
extends IListKnit<V>
{
}
