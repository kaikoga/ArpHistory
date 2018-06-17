package arpx.impl.cross.audio;

#if (arp_audio_backend_flash || arp_audio_backend_openfl)
typedef ResourceAudioImpl = arpx.impl.flash.audio.ResourceAudioFlashImpl;
#end

#if arp_audio_backend_heaps
typedef ResourceAudioImpl = arpx.impl.heaps.audio.ResourceAudioHeapsImpl;
#end
