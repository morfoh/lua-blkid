-- make generated variable nicer                                                                                                       
set_variable_format "%s"

c_module "blkid" {

-- enable FFI bindings support.
luajit_ffi = true,

-- load BLKID shared library.
ffi_load"blkid",

sys_include "blkid.h",

subfiles {
"src/blkid.nobj.lua",
},
}

