#[[
    #########################################################################################
    # FindAngelscript                                                                       #
    #########################################################################################
    # Locates Angelscript                                                                   #
    #########################################################################################
    # This module will set the following variables in your project:                         #
    # Angelscript_FOUND - true if Angelscript was found, false otherwise.                   #
    # Angelscript_VERSION_STRING - A human readable string with the version of Angelscript. #
    # Angelscript_LIBRARIES - The name of the library to link against.                      #
    # Angelscript_INCLUDE_DIRS - The path containing the header files.                      #
    #########################################################################################
    # Copyright (c) 2022, Elhanan Flesch                                                    #
    # Distributed under the MIT license (see the accompnying LICENSE file)                  #
    #########################################################################################
]]

# Search for the Angelscript include dir
find_path(Angelscript_INCLUDE_DIR angelscript.h
    HINTS
        ENV CMAKE_PREFIX_PATH
        /usr
        /usr/local
    PATH_SUFFIXES include
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(VC_LIB_PATH_SUFFIX lib/x64)
else()
    set(VC_LIB_PATH_SUFFIX lib/x86)
endif()

# Search for the Angelscript import library
find_library(Angelscript_LIBRARY
    NAMES angelscript
    HINTS
        ENV CMAKE_PREFIX_PATH
        /usr
        /usr/local
    PATH_SUFFIXES lib ${VC_LIB_PATH_SUFFIX}
)

# Grab the version string
if(Angelscript_INCLUDE_DIR AND EXISTS "${Angelscript_INCLUDE_DIR}/angelscript.h")
    file(STRINGS "${Angelscript_INCLUDE_DIR}/angelscript.h" Angelscript_VERSION_STRING REGEX "^#define[ \t]+ANGELSCRIPT_VERSION_STRING[ \t]+\".+$")
    string(REGEX REPLACE "#define[ \t]+ANGELSCRIPT_VERSION_STRING[ \t]+\"(.+)\"$" "\\1" Angelscript_VERSION_STRING "${Angelscript_VERSION_STRING}")
endif()

set(Angelscript_LIBRARIES ${Angelscript_LIBRARY})
set(Angelscript_INCLUDE_DIRS ${Angelscript_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(Angelscript
    FOUND_VAR Angelscript_FOUND
    REQUIRED_VARS Angelscript_LIBRARIES Angelscript_INCLUDE_DIRS
    VERSION_VAR Angelscript_VERSION_STRING
)

mark_as_advanced(Angelscript_LIBRARY, Angelscript_INCLUDE_DIR)
