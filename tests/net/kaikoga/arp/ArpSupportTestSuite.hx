package net.kaikoga.arp;

import net.kaikoga.arp.ds.impl.StdMapSet;
import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.impl.ArrayList;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.impl.StdOmap;
import net.kaikoga.arp.events.ArpSignalCase;
import net.kaikoga.arp.task.TaskRunnerCase;
import net.kaikoga.arp.ds.lambda.OmapOpCase;
import net.kaikoga.arp.ds.lambda.MapOpCase;
import net.kaikoga.arp.ds.lambda.SetOpCase;
import net.kaikoga.arp.ds.lambda.ListOpCase;
import net.kaikoga.arp.ds.impl.StdOmapCase;
import net.kaikoga.arp.ds.impl.StdMapCase;
import net.kaikoga.arp.ds.impl.ArrayListCase;
import net.kaikoga.arp.ds.impl.StdMapSetCase;
import net.kaikoga.arp.ds.impl.ArraySetCase;
import net.kaikoga.arp.ds.impl.base.BaseCollectionCase;
import net.kaikoga.arp.ds.impl.VoidCollectionCase;
import net.kaikoga.arp.ds.OmapCase;
import net.kaikoga.arp.ds.MapCase;
import net.kaikoga.arp.ds.ListCase;
import net.kaikoga.arp.ds.SetCase;
import net.kaikoga.arp.persistable.TaggedPersistIoCase;
import net.kaikoga.arp.persistable.PackedPersistIoCase;
import net.kaikoga.arp.persistable.DynamicPersistIoCase;

import picotest.PicoTestRunner;

class ArpSupportTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(SetCase, setImpl());
		r.load(ListCase, listImpl());
		r.load(MapCase, mapImpl());
		r.load(OmapCase, omapImpl());

		r.load(VoidCollectionCase);
		r.load(BaseCollectionCase);
		r.load(ArraySetCase);
		r.load(StdMapSetCase);
		r.load(ArrayListCase);
		r.load(StdMapCase);
		r.load(StdOmapCase);

		r.load(SetOpCase, setImpl());
		r.load(ListOpCase, listImpl());
		r.load(MapOpCase, mapImpl());
		r.load(OmapOpCase, omapImpl());

		r.load(ArpSignalCase);

		r.load(TaskRunnerCase);

		r.load(DynamicPersistIoCase);
		r.load(PackedPersistIoCase);
		r.load(TaggedPersistIoCase);
	}

	private static function setImpl():Iterable<Array<Dynamic>> {
		return [
			[function() return new ArraySet<Int>()],
			[function() return new StdMapSet<Int>()]
		];
	}
	private static function listImpl():Iterable<Array<Dynamic>> {
		return [
			[function() return new ArrayList<Int>()]
		];
	}
	private static function mapImpl():Iterable<Array<Dynamic>> {
		return [
			[function() return new StdMap<String, Int>()]
		];
	}
	private static function omapImpl():Iterable<Array<Dynamic>> {
		return [
			[function() return new StdOmap<String, Int>()]
		];
	}
}
