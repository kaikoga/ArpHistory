package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpDomainInfo;

class ArpHelpWriter {

	private var context:ArpWriterContext;

	private var domainInfo:ArpDomainInfo;
	private var prefix:String;

	private var classInfos:Map<String, Array<ArpClassInfo>>;
	private var sortedArpTypes:Array<String>;

	public function new(domainInfo:ArpDomainInfo, prefix:String = "doc/") {
		this.context = new ArpWriterContext();
		this.domainInfo = domainInfo;
		this.prefix = prefix;
		this.classInfos = domainInfo.groupByArpType();
		for (classInfos in this.classInfos) {
			classInfos.sort((a:ArpClassInfo, b:ArpClassInfo) -> Reflect.compare(a.className, b.className));
		}
		this.sortedArpTypes = [for (arpType in this.classInfos.keys()) arpType];
		this.sortedArpTypes.sort(Reflect.compare);
	}

	public function write():Void {
		context.get("index.html").addString(this.printIndex());
		context.get("index_types.html").addString(this.printIndexTypes());
		context.get("index_classes.html").addString(this.printIndexClasses());
		context.get("toc_types.html").addString(this.printTocTypes());
		context.get("toc_classes.html").addString(this.printTocClasses());

		context.dir("classes");
		for (arpType in this.sortedArpTypes) {
			for (classInfo in this.classInfos.get(arpType)) {
				context.dir('classes/${arpType}');
				var classFileName:String = classFileNameFor(classInfo);
				context.get(classFileName).addString(this.printClass(classInfo));
			}
		}

		context.writeAll(this.prefix);
	}

	private function classNameFor(classInfo:ArpClassInfo):String {
		var className:String = classInfo.className;
		if (className == null) className = classInfo.arpType;
		return className;
	}

	private function classFileNameFor(classInfo:ArpClassInfo):String {
		return 'classes/${classInfo.arpType}/${classNameFor(classInfo)}.html';
	}

	private function printIndex():String {
		return HTML_FRAMES;
	}

	private function printIndexTypes():String {
		var result:String = "";
		result += HTML_HEAD;
		result += '<h1>ArpDomain Reference</h1>';
		result += '<hr />';
		for (arpType in this.sortedArpTypes) {
			result += '<div><a href="index_classes.html#${arpType}">${arpType}</a></div>';
		}
		result += HTML_FOOT;
		return result;
	}

	private function printIndexClasses():String {
		var result:String = "";
		result += HTML_HEAD;
		result += '<h1>ArpDomain Reference</h1>';
		result += '<hr />';
		for (arpType in this.sortedArpTypes) {
			result += '<a id=${arpType} name=${arpType}></a><h2>${arpType}</h2>';
			for (classInfo in this.classInfos.get(arpType)) {
				result += '<div><a href=${classFileNameFor(classInfo)}>${classNameFor(classInfo)}</a></div>';
			}
		}
		result += HTML_FOOT;
		return result;
	}

	private function printTocTypes():String {
		var result:String = "";
		result += HTML_HEAD;
		result += '<div><a href="index_types.html" target="body">All Types</a></div>';
		result += '<hr />';
		for (arpType in this.sortedArpTypes) {
			result += '<div><a href="toc_classes.html#${arpType}" target="classes">${arpType}</a></div>';
		}
		result += HTML_FOOT;
		return result;
	}

	private function printTocClasses():String {
		var result:String = "";
		result += HTML_HEAD;
		result += '<div><a href="index_classes.html" target="body">All Classes</a></div>';
		result += '<hr />';

		for (arpType in this.sortedArpTypes) {
			result += '<a id=${arpType} name=${arpType}></a><h2>${arpType}</h2>';
			for (classInfo in this.classInfos.get(arpType)) {
				result += '<div><a href=${classFileNameFor(classInfo)} target="body">${classNameFor(classInfo)}</a></div>';
			}
		}
		result += HTML_FOOT;
		return result;
	}

	private function printClass(classInfo:ArpClassInfo):String {
		var result:String = "";
		result += HTML_HEAD;
		result += new ArpClassHelpPrinter(classInfo).print();
		result += HTML_FOOT;
		return result;
	}

	public static inline var HTML_HEAD:String = '<html>\n<head><title>ArpDomain Reference</title></head>\n<body>\n';
	public static inline var HTML_FOOT:String = '</body>\n</html>\n';

	public static inline var HTML_FRAMES:String = '<html>\n<head><title>ArpDomain Reference</title></head>
<frameset cols="150,*" border="2" bordercolor="#AAAAAA" framespacing="0">
<frameset rows="40%,60%" border="2" bordercolor="#AAAAAA" framespacing="0">
<frame src="toc_types.html" name="banks" frameborder="0" />
<frame src="toc_classes.html" name="classes" frameborder="0" />
</frameset>
<frame src="index_types.html" name="body" frameborder="0" />
</frameset>
<noframes><body><p>Frames required.</p></body></noframes></html>';

}
