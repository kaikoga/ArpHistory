package arpx.impl.cross;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ArpEngineShell = arpx.impl.flash.ArpEngineShell;
#elseif arp_display_backend_heaps
typedef ArpEngineShell = arpx.impl.heaps.ArpEngineShell;
#elseif arp_display_backend_sys
typedef ArpEngineShell = arpx.impl.sys.ArpEngineShell;
#elseif arp_display_backend_stub
typedef ArpEngineShell = arpx.impl.stub.ArpEngineShell;
#end
