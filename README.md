# CMake Modules Collection

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Modules](#modules)
- [Licenses](#licenses)

## Introduction
This is a collection of miscellaneous CMake modules.

## Usage
Copy the modules you need to the ``cmake`` subfolder of your project and add the following near the top of your main CMakeLists.txt (not above the project() call):
```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
```

## Modules
- FindSDL_gpu - Searches for the [SDL_gpu](https://github.com/grimfang4/sdl-gpu) library.
- FindAngelscript - Searches for [Angelscript](https://www.angelcode.com/angelscript/).

## Licenses
Modules that I wrote myself are distributed under the MIT licenses (see the accompnying LICENSE file).