#[[
    #################################################################################
    # FindSDL_gpu                                                                   #
    #################################################################################
    # Locates the SDL_gpu library                                                   #
    #################################################################################
    # This module will set the following variables in your project:                 #
    # SDL_GPU_FOUND - true if SDL_gpu was found, false otherwise.                   #
    # SDL_GPU_VERSION_STRING - A human readable string with the version of SDL_gpu. #
    # SDL_GPU_LIBRARIES - The name of the library to link against.                  #
    # SDL_GPU_INCLUDE_DIRS - The path containing the header files.                  #
    #################################################################################
    # Copyright (c) 2021, Elhanan Flesch                                            #
    # Distributed under the MIT license (see the accompnying LICENSE file)          #
    #################################################################################
]]

# Search for the SDL_gpu include dir
find_path(SDL_GPU_INCLUDE_DIR SDL_gpu.h
    HINTS
        ENV SDLGPUDIR
        ENV SDL2DIR
    PATH_SUFFIXES SDL2
        include/SDL2 include
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(VC_LIB_PATH_SUFFIX lib/x64)
else()
    set(VC_LIB_PATH_SUFFIX lib/x86)
endif()

# Search for the SDL_gpu library
find_library(SDL_GPU_LIBRARY
    NAMES SDL2_gpu SDL2_gpu_s
    HINTS
        ENV SDLGPUDIR
        ENV SDL2DIR
    PATH_SUFFIXES lib ${VC_LIB_PATH_SUFFIX}
)

# Get the SDL_gpu version
if(SDL_GPU_INCLUDE_DIR AND EXISTS "${SDL_GPU_INCLUDE_DIR}/SDL_gpu_version.h")
    file(STRINGS "${SDL_GPU_INCLUDE_DIR}/SDL_gpu_version.h" SDL_GPU_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SDL_GPU_VERSION_MAJOR[ \t]+[0-9]+$")
    file(STRINGS "${SDL_GPU_INCLUDE_DIR}/SDL_gpu_version.h" SDL_GPU_VERSION_MINOR_LINE REGEX "^#define[ \t]+SDL_GPU_VERSION_MINOR[ \t]+[0-9]+$")
    file(STRINGS "${SDL_GPU_INCLUDE_DIR}/SDL_gpu_version.h" SDL_GPU_VERSION_PATCH_LINE REGEX "^#define[ \t]+SDL_GPU_VERSION_PATCH[ \t]+[0-9]+$")
    string(REGEX REPLACE "^#define[ \t]+SDL_GPU_VERSION_MAJOR[ \t]+([0-9]+)$" "\\1" SDL_GPU_VERSION_MAJOR "${SDL_GPU_VERSION_MAJOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_GPU_VERSION_MINOR[ \t]+([0-9]+)$" "\\1" SDL_GPU_VERSION_MINOR "${SDL_GPU_VERSION_MINOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_GPU_VERSION_PATCH[ \t]+([0-9]+)$" "\\1" SDL_GPU_VERSION_PATCH "${SDL_GPU_VERSION_PATCH_LINE}")
    set(SDL_GPU_VERSION_STRING "${SDL_GPU_VERSION_MAJOR}.${SDL_GPU_VERSION_MINOR}.${SDL_GPU_VERSION_PATCH}")
    unset(SDL_GPU_VERSION_MAJOR_LINE)
    unset(SDL_GPU_VERSION_MINOR_LINE)
    unset(SDL_GPU_VERSION_PATCH_LINE)
    unset(SDL_GPU_VERSION_MAJOR)
    unset(SDL_GPU_VERSION_MINOR)
    unset(SDL_GPU_VERSION_PATCH)
endif()

set(SDL_GPU_LIBRARIES ${SDL_GPU_LIBRARY})
set(SDL_GPU_INCLUDE_DIRS ${SDL_GPU_INCLUDE_DIR})

INCLUDE(FindPackageHandleStandardArgs)

find_package_handle_standard_args(SDL_gpu
    FOUND_VAR SDL_GPU_FOUND
    REQUIRED_VARS SDL_GPU_LIBRARIES SDL_GPU_INCLUDE_DIRS
    VERSION_VAR SDL_GPU_VERSION_STRING
)

# Backward compatibility
set(SDLGPU_LIBRARY ${SDL_GPU_LIBRARIES})
set(SDLGPU_INCLUDE_DIR ${SDL_GPU_INCLUDE_DIRS})
set(SDLGPU_FOUND ${SDL_GPU_FOUND})

mark_as_advanced(SDL_GPU_LIBRARY, SDL_GPU_INCLUDE_DIR)