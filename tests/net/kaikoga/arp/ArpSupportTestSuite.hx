package net.kaikoga.arp;

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
import net.kaikoga.arp.ds.impl.base.BaseCollectionCase;
import net.kaikoga.arp.ds.impl.OmapCase;
import net.kaikoga.arp.ds.impl.MapCase;
import net.kaikoga.arp.ds.impl.ListCase;
import net.kaikoga.arp.ds.impl.VoidCollectionCase;
import net.kaikoga.arp.ds.impl.SetCase;
import net.kaikoga.arp.persistable.TaggedPersistIoCase;
import net.kaikoga.arp.persistable.PackedPersistIoCase;
import net.kaikoga.arp.persistable.DynamicPersistIoCase;

import picotest.PicoTestRunner;

class ArpSupportTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(VoidCollectionCase);
		r.load(BaseCollectionCase);
		r.load(SetCase, setImpl());
		r.load(ListCase, listImpl());
		r.load(MapCase, mapImpl());
		r.load(OmapCase, omapImpl());

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
			[function() return new ArraySet<Int>()]
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
