package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpDomainInfo;

class ArpHelpWriter {

	private var context:ArpWriterContext;

	private var domainInfo:ArpDomainInfo;
	private var prefix:String;

	private var classInfos:Map<String, Array<ArpClassInfo>>;

	public function new(domainInfo:ArpDomainInfo, prefix:String = "doc/") {
		this.context = new ArpWriterContext();
		this.domainInfo = domainInfo;
		this.prefix = prefix;
		this.classInfos = domainInfo.groupByArpType();
	}

	public function write():Void {
		this.writeIndex();
		this.writeIndexTypes();
		this.writeIndexClasses();
		this.writeTocTypes();
		this.writeTocClasses();
		this.writeClasses();

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

	private function writeIndex():Void {
		context.get("index.html").addString(HTML_FRAMES);
	}

	private function writeIndexTypes():Void {
		context.get("index_types.html").addString(HTML_HEAD);
		context.get("index_types.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_types.html").addString('<hr />');

		for (arpType in this.classInfos.keys()) {
			context.get("index_types.html").addString('<div><a href="index_classes.html#${arpType}">${arpType}</a></div>');
		}

		context.get("index_types.html").addString(HTML_FOOT);
	}

	private function writeIndexClasses():Void {
		context.get("index_classes.html").addString(HTML_HEAD);
		context.get("index_classes.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_classes.html").addString('<hr />');

		for (arpType in this.classInfos.keys()) {
			context.get("index_classes.html").addString('<a id=${arpType} name=${arpType}></a><h2>${arpType}</h2>');
			for (classInfo in this.classInfos.get(arpType)) {
				context.get("index_classes.html").addString('<div><a href=${classFileNameFor(classInfo)}>${classNameFor(classInfo)}</a></div>');
			}
		}

		context.get("index_classes.html").addString(HTML_FOOT);
	}

	private function writeTocTypes():Void {
		context.get("toc_types.html").addString(HTML_HEAD);

		context.get("toc_types.html").addString('<div><a href="index_types.html" target="body">All Types</a></div>');
		context.get("toc_types.html").addString('<hr />');

		for (arpType in this.classInfos.keys()) {
			context.get("toc_types.html").addString('<div><a href="toc_classes.html#${arpType}" target="classes">${arpType}</a></div>');
		}

		context.get("toc_types.html").addString(HTML_FOOT);
	}

	private function writeTocClasses():Void {
		context.get("toc_classes.html").addString(HTML_HEAD);

		context.get("toc_classes.html").addString('<div><a href="index_classes.html" target="body">All Classes</a></div>');
		context.get("toc_classes.html").addString('<hr />');

		for (arpType in this.classInfos.keys()) {
			context.get("toc_classes.html").addString('<a id=${arpType} name=${arpType}></a><h2>${arpType}</h2>');
			for (classInfo in this.classInfos.get(arpType)) {
				context.get("toc_classes.html").addString('<div><a href=${classFileNameFor(classInfo)} target="body">${classNameFor(classInfo)}</a></div>');
			}
		}

		context.get("toc_classes.html").addString(HTML_FOOT);
	}

	private function writeClasses():Void {
		context.dir("classes");
		for (arpType in this.classInfos.keys()) {
			for (classInfo in this.classInfos.get(arpType)) {
				context.dir('classes/${arpType}');
				var classFileName:String = classFileNameFor(classInfo);
				context.get(classFileName).addString(HTML_HEAD);
				context.get(classFileName).addString(new ArpClassHelpPrinter(classInfo).print());
				context.get(classFileName).addString(HTML_FOOT);
			}
		}
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
