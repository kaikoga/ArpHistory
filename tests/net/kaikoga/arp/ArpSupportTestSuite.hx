package net.kaikoga.arp;

import net.kaikoga.arp.io.OutputWrapperCase;
import net.kaikoga.arp.io.InputWrapperCase;
import net.kaikoga.arp.ds.ListCase;
import net.kaikoga.arp.ds.MapCase;
import net.kaikoga.arp.ds.OmapCase;
import net.kaikoga.arp.ds.SetCase;
import net.kaikoga.arp.ds.impl.VoidCollectionCase;
import net.kaikoga.arp.ds.impl.base.BaseCollectionCase;
import net.kaikoga.arp.ds.lambda.ListOpCase;
import net.kaikoga.arp.ds.lambda.MapOpCase;
import net.kaikoga.arp.ds.lambda.OmapOpCase;
import net.kaikoga.arp.ds.lambda.SetOpCase;
import net.kaikoga.arp.ds.proxy.ListProxyCase;
import net.kaikoga.arp.ds.proxy.ListSelfProxyCase;
import net.kaikoga.arp.ds.proxy.MapProxyCase;
import net.kaikoga.arp.ds.proxy.MapSelfProxyCase;
import net.kaikoga.arp.ds.proxy.OmapProxyCase;
import net.kaikoga.arp.ds.proxy.OmapSelfProxyCase;
import net.kaikoga.arp.ds.proxy.ProxyCaseUtilCase;
import net.kaikoga.arp.ds.proxy.SetProxyCase;
import net.kaikoga.arp.ds.proxy.SetSelfProxyCase;
import net.kaikoga.arp.events.ArpSignalCase;
import net.kaikoga.arp.iter.ERegIteratorCase;
import net.kaikoga.arp.persistable.PersistIoCase;
import net.kaikoga.arp.seed.ArpSeedCase;
import net.kaikoga.arp.seed.ArpSeedEnvCase;
import net.kaikoga.arp.task.TaskRunnerCase;
import net.kaikoga.arp.utils.ArpStringUtilCase;
import picotest.PicoTestRunner;

import net.kaikoga.arp.testParams.DsImplProviders.*;
import net.kaikoga.arp.testParams.IoProviders.*;
import net.kaikoga.arp.testParams.PersistIoProviders.*;

class ArpSupportTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(ERegIteratorCase);

		r.load(ArpStringUtilCase);

		r.load(InputWrapperCase, inputProvider());
		r.load(OutputWrapperCase, outputProvider());

		r.load(IntSetCase, setProvider());
		r.load(IntListCase, listProvider());
		r.load(StringIntMapCase, mapProvider());
		r.load(StringIntOmapCase, omapProvider());

		r.load(VoidCollectionCase);
		r.load(BaseCollectionCase);

		r.load(SetOpCase, setProvider());
		r.load(ListOpCase, listProvider());
		r.load(MapOpCase, mapProvider());
		r.load(OmapOpCase, omapProvider());

		// FIXME these tests will crash cpp

#if !cpp

		r.load(IntSetCase, adapterSetProvider());
		r.load(IntListCase, adapterListProvider());
		r.load(StringIntMapCase, adapterMapProvider());
		r.load(StringIntOmapCase, adapterOmapProvider());

		r.load(SetOpCase, adapterSetProvider());
		r.load(ListOpCase, adapterListProvider());
		r.load(MapOpCase, adapterMapProvider());
		r.load(OmapOpCase, adapterOmapProvider());

		r.load(ProxyCaseUtilCase);

		r.load(SetProxyCase, setProvider());
		r.load(ListProxyCase, listProvider());
		r.load(MapProxyCase, mapProvider());
		r.load(OmapProxyCase, omapProvider());

		r.load(SetSelfProxyCase, setProvider());
		r.load(ListSelfProxyCase, listProvider());
		r.load(MapSelfProxyCase, mapProvider());
		r.load(OmapSelfProxyCase, omapProvider());

		r.load(IntSetCase, proxySetProvider());
		r.load(IntListCase, proxyListProvider());
		r.load(StringIntMapCase, proxyMapProvider());
		r.load(StringIntOmapCase, proxyOmapProvider());

		r.load(SetOpCase, proxySetProvider());
		r.load(ListOpCase, proxyListProvider());
		r.load(MapOpCase, proxyMapProvider());
		r.load(OmapOpCase, proxyOmapProvider());

#end

		r.load(ArpSignalCase);

		r.load(TaskRunnerCase);

		r.load(PersistIoCase, persistIoProvider());

		r.load(ArpSeedEnvCase);
		r.load(ArpSeedCase);
	}


}
