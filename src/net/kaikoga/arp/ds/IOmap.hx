package net.kaikoga.arp.ds;

import net.kaikoga.arp.ds.access.IOmapRemove;
import net.kaikoga.arp.ds.access.IOmapResolve;
import net.kaikoga.arp.ds.access.IOmapWrite;
import net.kaikoga.arp.ds.access.IOmapRead;

interface IOmap<K, V>
extends IOmapRead<K, V>
extends IOmapWrite<K, V>
extends IOmapRemove<K, V>
extends IOmapResolve<K, V>
{
}
