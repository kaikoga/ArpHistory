package arp.ds;

import arp.ds.access.IOmapKnit;
import arp.ds.access.IOmapRemove;
import arp.ds.access.IOmapResolve;
import arp.ds.access.IOmapWrite;
import arp.ds.access.IOmapRead;

interface IOmap<K, V>
extends IOmapRead<K, V>
extends IOmapWrite<K, V>
extends IOmapRemove<K, V>
extends IOmapResolve<K, V>
extends IOmapKnit<K, V>
{
}
