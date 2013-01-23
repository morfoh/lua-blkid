-- Copyright (c) 2013 by Christian Wiese <chris@opensde.org>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

--
-- typedefs
--
local typedefs = [[
]]
c_source "typedefs" (typedefs)
-- pass extra C type info to FFI.
ffi_cdef (typedefs)

export_definitions {
"BLKID_DEV_FIND",
"BLKID_DEV_CREATE",
"BLKID_DEV_VERIFY",
"BLKID_DEV_NORMAL",
}

--
-- blkid_cache
--
object "blkid_cache" {
	constructor "get" {
                var_in { "const char *", "filename", is_optional = true, default = 0 },
                c_source [[
  blkid_cache tmpcache = NULL;
  int rc;

  if ((rc = blkid_get_cache(&tmpcache, ${filename})) != 0) {
  	lua_pushnil(L);
	return 1;
  } else {
	*${this} = tmpcache;
  }
                ]],
        },

	-- put cache
	method "put" {
		c_call "void" "blkid_put_cache" {
					"blkid_cache *", "*this<1"
		}
	},

	-- probe all
	method "probe_all" {
		c_call "int" "blkid_probe_all" {
					"blkid_cache *", "*this<1"
		}
	},
}

--
-- blkid_dev
--
object "blkid_dev" {
	-- get
	constructor "get" {
		var_in { "blkid_cache", "cache" },
		var_in { "const char *", "devicename" },
		var_in { "int", "flags" },
		c_source[[
  blkid_dev tmpdev;

  blkid_get_cache(&cache, NULL);
  tmpdev = blkid_get_dev(cache, devicename, BLKID_DEV_NORMAL);
  ${this} = *(blkid_dev **)&tmpdev;
		]]
	},

	-- devname
        method "devname" {
		var_out { "const char *", "name" },
                c_source[[
  name = blkid_dev_devname((blkid_dev)${this});
		]]
        },
}
