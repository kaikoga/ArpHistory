package arpx.impl.cross.audio;

#if (arp_audio_backend_flash || arp_audio_backend_openfl)
typedef IAudioImpl = arpx.impl.flash.audio.IAudioImpl;
#elseif arp_audio_backend_heaps
typedef IAudioImpl = arpx.impl.heaps.audio.IAudioImpl;
#elseif arp_audio_backend_sys
typedef IAudioImpl = arpx.impl.sys.audio.IAudioImpl;
#elseif arp_audio_backend_stub
typedef IAudioImpl = arpx.impl.stub.audio.IAudioImpl;
#end
