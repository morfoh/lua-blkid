lua-blkid - Lua bindings for libblkid
=====================================
:author: Christian Wiese
:email:  chris@opensde.org


[WARNING]
The Lua bindings for `libblkid` provided here are in a very early stage of
development, thus do not use them in a production environment!

Build Dependencies
------------------

- cmake
- libblkid shipped with util-linux


Installing
----------

=== Install from git

Clone the git repository
-----------------------------------------------------------------------------
git clone git://github.com/morfoh/lua-blkid.git
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
cd lua-blkid
-----------------------------------------------------------------------------

Prepare a dedicated build directory
-----------------------------------------------------------------------------
mkdir build
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
cd build
-----------------------------------------------------------------------------

Generate Makefiles and related build infrastructure
-----------------------------------------------------------------------------
cmake ../
-----------------------------------------------------------------------------

Alternatively you can specify the path where to install the module
-----------------------------------------------------------------------------
cmake ../ -DINSTALL_CMOD=/usr/local/lib/lua/5.1
-----------------------------------------------------------------------------

Compile the module
-----------------------------------------------------------------------------
make
-----------------------------------------------------------------------------

Install the module
-----------------------------------------------------------------------------
sudo make install
-----------------------------------------------------------------------------


=== Install using lua-rocks

[WARNING]
In the current stage of development the installation via lua-rocks is not
tested by the author, thus you are on your own when trying to use this
installation method!

-----------------------------------------------------------------------------
curl -O "https://github.com/morfoh/lua-blkid/raw/master/lua-blkid-scm-0.rockspec"
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
luarocks install lua-blkid-scm-0.rockspec
-----------------------------------------------------------------------------


Development
-----------

=== Re-generating the bindings

By default CMake will use the pre-generated bindings that are include in the
project.

To be able to re-generate the bindings, you will need to install
https://github.com/Neopallium/LuaNativeObjects[LuaNativeObjects] and set the
CMake variable `USE_PRE_GENERATED_BINDINGS` to `FALSE`.

-----------------------------------------------------------------------------
cmake ../ -DUSE_PRE_GENERATED_BINDINGS=FALSE
-----------------------------------------------------------------------------

Mandantory for re-generating Lua bindings from `*.nobj.lua` files:

* https://github.com/Neopallium/LuaNativeObjects[LuaNativeObjects], this is the
  bindings generator used to convert the `*.nobj.lua` files into a native Lua
  module.

Optional for re-generating documentation

* https://github.com/keplerproject/luadoc[luadoc]

To not re-generate documentation by luadocs when re-generating the bindings
you have to to set the CMake variable `GENERATE_LUADOCS` to `FALSE`.
-----------------------------------------------------------------------------
cmake ../ -DUSE_PRE_GENERATED_BINDINGS=FALSE -DGENERATE_LUADOCS=FALSE
-----------------------------------------------------------------------------

