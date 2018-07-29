package arpx.impl.cross.audio;

#if (arp_audio_backend_flash || arp_audio_backend_openfl)
typedef ResourceAudioImpl = arpx.impl.flash.audio.ResourceAudioImpl;
#elseif arp_audio_backend_heaps
typedef ResourceAudioImpl = arpx.impl.heaps.audio.ResourceAudioImpl;
#elseif arp_audio_backend_stub
typedef ResourceAudioImpl = arpx.impl.stub.audio.ResourceAudioImpl;
#end
