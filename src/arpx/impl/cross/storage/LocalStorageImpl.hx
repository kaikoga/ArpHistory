package arpx.impl.cross.storage;

#if arp_storage_backend_flash
typedef LocalStorageImpl = arpx.impl.flash.storage.LocalStorageImpl;
#else
typedef LocalStorageImpl = IStorageImpl;
#end
