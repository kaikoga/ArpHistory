package arp.writers.help;

import arp.domain.reflect.ArpClassInfo;
import arp.domain.reflect.ArpDomainInfo;

class ArpHelpWriter {

	private var domainInfo:ArpDomainInfo;
	private var prefix:String;

	public function new(domainInfo:ArpDomainInfo, prefix:String = "doc/") {
		this.domainInfo = domainInfo;
		this.prefix = prefix;
	}

	public function write():Void {
		var context:ArpWriterContext = new ArpWriterContext();

		context.get("index_types.html").addString(HTML_HEAD);
		context.get("index_classes.html").addString(HTML_HEAD);
		context.get("toc_types.html").addString(HTML_HEAD);
		context.get("toc_classes.html").addString(HTML_HEAD);

		context.get("index_types.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_types.html").addString('<hr />');
		context.get("index_classes.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_classes.html").addString('<hr />');

		context.get("toc_types.html").addString('<div><a href="index_types.html" target="body">All Types</a></div>');
		context.get("toc_types.html").addString('<hr />');
		context.get("toc_classes.html").addString('<div><a href="index_classes.html" target="body">All Classes</a></div>');
		context.get("toc_classes.html").addString('<hr />');

		var classInfos:Map<String, Array<ArpClassInfo>> = domainInfo.groupByArpType();
		for (arpType in classInfos.keys()) {
			context.get("index_types.html").addString('<div><a href="index_classes.html#${arpType}">${arpType}</a></div>');
			context.get("index_classes.html").addString('<a id=${arpType} name=${arpType}></a>');
			context.get("index_classes.html").addString('<h2>${arpType}</h2>');
			context.get("toc_types.html").addString('<div><a href="toc_classes.html#${arpType}" target="classes">${arpType}</a></div>');
			context.get("toc_classes.html").addString('<a id=${arpType} name=${arpType}></a>');
			context.get("toc_classes.html").addString('<h2>${arpType}</h2>');
			context.dir("classes");
			for (classInfo in classInfos.get(arpType)) {
				context.dir('classes/${arpType}');
				var className:String = classInfo.className;
				if (className == null) className = arpType;
				var classFileName:String = 'classes/${arpType}/${className}.html';
				context.get("index_classes.html").addString('<div><a href=${classFileName}>${className}</a></div>');
				context.get("toc_classes.html").addString('<div><a href=${classFileName} target="body">${className}</a></div>');
				context.get(classFileName).addString('<h1>ArpDomain Reference</h1>');
				context.get(classFileName).addString('<hr />');
				context.get(classFileName).addString(new ArpClassHelpPrinter(classInfo).print());
			}
		}

		context.get("index_types.html").addString(HTML_FOOT);
		context.get("index_classes.html").addString(HTML_FOOT);
		context.get("toc_types.html").addString(HTML_FOOT);
		context.get("toc_classes.html").addString(HTML_FOOT);

		context.get("index.html").addString(HTML_FRAMES);

		context.writeAll(prefix);
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
