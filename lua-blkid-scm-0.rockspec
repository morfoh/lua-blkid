#!/usr/bin/env lua

package	= 'lua-blkid'
version	= 'scm-0'
source	= {
	url	= 'https://github.com/morfoh/lua-blkid'
}
description	= {
	summary	= "Lua bindings for libblkid.",
	detailed	= '',
	homepage	= 'https://github.com/morfoh/lua-blkid',
	license	= 'MIT',
	maintainer = "Christian Wiese",
}
dependencies = {
	'lua >= 5.1',
}
external_dependencies = {
	BLKID = {
		header = "blkid.h",
		library = "blkid",
	}
}
build	= {
	type = "builtin",
	modules = {
		blkid = {
			sources = { "src/blkid.nobj.pre_generated.c" },
			libraries = { "blkid" },
		}
	}
}
