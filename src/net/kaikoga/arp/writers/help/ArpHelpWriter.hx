package net.kaikoga.arp.writers.help;

import net.kaikoga.arp.domain.reflect.ArpTemplateInfo;
import net.kaikoga.arp.domain.reflect.ArpDomainInfo;

class ArpHelpWriter {

	public function new() {
	}

	public function write(domainInfo:ArpDomainInfo, prefix:String = "doc/"):Void {
		var context:ArpWriterContext = new ArpWriterContext();

		context.get("index_types.html").addString(HTML_HEAD);
		context.get("index_templates.html").addString(HTML_HEAD);
		context.get("toc_types.html").addString(HTML_HEAD);
		context.get("toc_templates.html").addString(HTML_HEAD);

		context.get("index_types.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_types.html").addString('<hr />');
		context.get("index_templates.html").addString('<h1>ArpDomain Reference</h1>');
		context.get("index_templates.html").addString('<hr />');

		context.get("toc_types.html").addString('<div><a href="index_types.html" target="body">All Banks</a></div>');
		context.get("toc_types.html").addString('<hr />');
		context.get("toc_templates.html").addString('<div><a href="index_templates.html" target="body">All Templates</a></div>');
		context.get("toc_templates.html").addString('<hr />');

		var templates:Map<String, Array<ArpTemplateInfo>> = domainInfo.groupByArpType();
		for (arpType in templates.keys()) {
			context.get("index_types.html").addString('<div><a href="index_templates.html#${arpType}">${arpType}</a></div>');
			context.get("index_templates.html").addString('<a id=${arpType} name=${arpType}></a>');
			context.get("index_templates.html").addString('<h2>${arpType}</h2>');
			context.get("toc_types.html").addString('<div><a href="toc_templates.html#${arpType}" target="templates">${arpType}</a></div>');
			context.get("toc_templates.html").addString('<a id=${arpType} name=${arpType}></a>');
			context.get("toc_templates.html").addString('<h2>${arpType}</h2>');
			context.dir("templates");
			for (template in templates.get(arpType)) {
				context.dir('templates/${arpType}');
				var templateName:String = template.templateName;
				if (templateName == null) templateName = arpType;
				var templateFileName:String = 'templates/${arpType}/${templateName}.html';
				context.get("index_templates.html").addString('<div><a href=${templateFileName}>${templateName}</a></div>');
				context.get("toc_templates.html").addString('<div><a href=${templateFileName} target="body">${templateName}</a></div>');
				context.get(templateFileName).addString('<h1>ArpDomain Reference</h1>');
				context.get(templateFileName).addString('<hr />');
				context.get(templateFileName).addString(new ArpTemplateHelpPrinter().print(template));
			}
		}

		context.get("index_types.html").addString(HTML_FOOT);
		context.get("index_templates.html").addString(HTML_FOOT);
		context.get("toc_types.html").addString(HTML_FOOT);
		context.get("toc_templates.html").addString(HTML_FOOT);

		context.get("index.html").addString(HTML_FRAMES);

		context.writeAll(prefix);
	}

	public static inline var HTML_HEAD:String = '<html>\n<head><title>ArpDomain Reference</title></head>\n<body>\n';
	public static inline var HTML_FOOT:String = '</body>\n</html>\n';

	public static inline var HTML_FRAMES:String = '<html>\n<head><title>ArpDomain Reference</title></head>
<frameset cols="150,*" border="2" bordercolor="#AAAAAA" framespacing="0">
<frameset rows="40%,60%" border="2" bordercolor="#AAAAAA" framespacing="0">
<frame src="toc_types.html" name="banks" frameborder="0" />
<frame src="toc_templates.html" name="templates" frameborder="0" />
</frameset>
<frame src="index_types.html" name="body" frameborder="0" />
</frameset>
<noframes><body><p>Frames required.</p></body></noframes></html>';

}
