package arpx.impl.cross.audio;

#if (arp_audio_backend_flash || arp_audio_backend_openfl)
typedef IAudioImpl = arpx.impl.flash.audio.IAudioImpl;
#end

#if arp_audio_backend_heaps
typedef IAudioImpl = arpx.impl.heaps.audio.IAudioImpl;
#end
