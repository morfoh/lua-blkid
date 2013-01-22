#
# Lua bindings for libblkid
#
cmake_minimum_required(VERSION 2.8)

project(lua-blkid C)

set(BUILD_SHARED_LIBS TRUE)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(INSTALL_CMOD share/lua/cmod CACHE PATH "Directory to install Lua binary modules (configure lua via LUA_CPATH)")

set(COMMON_CFLAGS "${CFLAGS}")
set(COMMON_LDFLAGS)
set(COMMON_LIBS)

## Lua 5.1.x
include(FindLua51)
if(NOT ${LUA51_FOUND})
    message(FATAL_ERROR "The FindLua51 module could not find lua :-(")
endif()
set(COMMON_LIBS "${COMMON_LIBS};${LUA_LIBRARIES}")

## LibBlkid
include(FindPkgConfig)
pkg_search_module(BLKID REQUIRED blkid)
set(COMMON_CFLAGS "${COMMON_CFLAGS} ${BLKID_CFLAGS}")
set(COMMON_LDFLAGS "${COMMON_LDFLAGS} ${BLKID_LDFLAGS}")
set(COMMON_LIBS "${COMMON_LIBS};${BLKID_LIBRARIES}")

## LuaNativeObjects
include(LuaNativeObjects)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                    ${CMAKE_CURRENT_BINARY_DIR}
                    ${LUA_INCLUDE_DIR})

## LuaBlkid
set(LUA_BLKID_SRC
	blkid.nobj.lua
)

if(${USE_PRE_GENERATED_BINDINGS})
	set(LUA_BLKID_SRC src/pre_generated-blkid.nobj.c)
else()
	# Generate Lua bindings.
	GenLuaNativeObjects(LUA_BLKID_SRC)
endif()

add_library(lua-blkid MODULE ${LUA_BLKID_SRC})
target_link_libraries(lua-blkid ${COMMON_LIBS})
set_target_properties(lua-blkid PROPERTIES PREFIX "")
set_target_properties(lua-blkid PROPERTIES COMPILE_FLAGS "${COMMON_CFLAGS}")
set_target_properties(lua-blkid PROPERTIES OUTPUT_NAME blkid)

install(TARGETS lua-blkid
        DESTINATION "${INSTALL_CMOD}")

