package arpx.impl.cross.storage;

#if arp_storage_backend_flash
typedef LocalStorageImpl = arpx.impl.flash.storage.LocalStorageImpl;
#elseif arp_storage_backend_js
typedef LocalStorageImpl = arpx.impl.js.storage.LocalStorageImpl;
#elseif arp_storage_backend_stub
typedef LocalStorageImpl = arpx.impl.stub.storage.LocalStorageImpl;
#elseif arp_storage_backend_sys
typedef LocalStorageImpl = arpx.impl.sys.storage.LocalStorageImpl;
#end
