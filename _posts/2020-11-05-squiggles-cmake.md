---
layout: post
tags: [programming, cpp]
title: Setting up a C++ library with CMake
---

I recently started a new side project, [Squiggles](https://squiggles.readthedocs.io), a C++ library for generating
spline-based 2D paths for robots. This project was my first time setting up a
C++ library meant to be included in other projects across different platforms.
[CMake](https://cmake.org/) is the build system typically used in these cases
and seemed like the right fit for this project. CMake has an impressive set of
functionality but can be a bit cumbersome to set up. I'll be walking through the
build system requirements for this project and how I used CMake to set that up.

## Project Organization

The project's organization was shaped by two goals: to create a reliable, tested
library and to visualize the generated paths. These two goals led to the
`tst` and `vis` folders, respectively. This, along with the standard C/C++
`include` and `src` directories led to the following project structure:

```text
squiggles
  - build
  - include
  - src
  - tst
  - vis
```

As is the norm with CMake, each of these source directories (`src`, `tst`, and
`vis`) got their own `CMakeLists.txt` config file.

The `src` directory got the typical config for a source directory; each of the
files in the directory were added to the sources list and an executable was
defined to run the project's `main.cpp`. This config also defined a static
library for use with googletest (more on that later). The `CMakeLists.txt`
consists of the following four lines:

```text
set(BINARY ${CMAKE_PROJECT_NAME})
file(GLOB_RECURSE SOURCES LIST_DIRECTORIES true *.h *.cpp)
add_executable(${BINARY}_run ${SOURCES})
add_library(${CMAKE_PROJECT_NAME}_lib STATIC ${SOURCES})
```

The config files for the `tst` and `vis` directory were determined largely by
their unique uses.

## GoogleTest

I had some experience with [GoogleTest](https://github.com/google/googletest) from a previous project and found it
to be an enjoyable testing framework. GoogleTest is set up to be easily
integrated with an existing CMake project so it was a particularly good fit. The
README for GoogleTest lists two methods for adding it to an existing project:
Adding it as a Git submodule and installing it as a CMake `ExternalProject`. The
Git submodule is, in my opinion, the easiest installation option. I'm more
familiar with Git than CMake and it was an easy setup process.

I later learned, however, that this method would cause difficulties when
adding the Squiggles project as a dependency to other projects. I started adding
Squiggles as an `ExternalProject` to a different CMake project and got hit with
a variety of errors. These errors all pointed to the same root issue - CMake
does not play nicely with dependencies sharing a common dependency. In this case
both Squiggles and its future child project depended on GoogleTest. Both projects
attempted to install GoogleTest separately and caused conflicts.

```text
    GoogleTest
       ^   ^
       |   |
Squiggles  |
    ^      |
    |------|
    |
  Child
```

The key to resolving this shared dependency issue would be to only download the
GoogleTest source and include it in the project when Squiggles was being set
up in a development environment. One crucial detail to this solution is that
CMake, when installing an `ExternalProject`, will configure that project by
downloading the source and all of its submodules, then running its root
`CMakeLists.txt` and the default arguments.

I switched from the submodule approach to including GoogleTest as an
`ExternalProject` in Squiggles. This switch would allow me to hide the GoogleTest
installation behind a CMake `option`. The default behavior when setting up the
project, the behavior used by CMake's project installation process, will be to
ignore any GoogleTest involvement. Only the static library is built and there's
no need to build or run the tests. The development environment, alternatively,
can toggle that `option` flag and set up the tests.

The configuration for GoogleTest needed to be split out into a separate file
to ensure that it would only be loaded and run when the right option is set.
This separate config file, `CMakeLists.txt.in`, looks like this:

```text
project(external-dependencies NONE)

include(ExternalProject)

ExternalProject_Add(googletest
  GIT_REPOSITORY    https://github.com/google/googletest.git
  GIT_TAG           release-1.8.1
  SOURCE_DIR        "${CMAKE_BINARY_DIR}/googletest-src"
  BINARY_DIR        "${CMAKE_BINARY_DIR}/googletest-build"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
```

We then set up the root `CMakeLists.txt` file to conditionally include the above
file and install GoogleTest:

```text
option(SQUIGGLES_TEST "determines if we're gonna pull googletest" OFF)

if (SQUIGGLES_TEST)
    # Download and unpack googletest at configure time
    configure_file(CMakeLists.txt.in external-dependencies/CMakeLists.txt)
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
            RESULT_VARIABLE result
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/external-dependencies )
    if(result)
        message(FATAL_ERROR "CMake step for dependencies failed: ${result}")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
            RESULT_VARIABLE result
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/external-dependencies )
    if(result)
        message(FATAL_ERROR "Build step for dependencies failed: ${result}")
    endif()

    # Prevent overriding the parent project's compiler/linker
    # settings on Windows
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    # Add googletest directly to our build. This defines
    # the gtest and gtest_main targets.
    add_subdirectory(${CMAKE_BINARY_DIR}/googletest-src
                    ${CMAKE_BINARY_DIR}/googletest-build
                    EXCLUDE_FROM_ALL)

    # The gtest/gtest_main targets carry header search path
    # dependencies automatically when using CMake 2.8.11 or
    # later. Otherwise we have to add them here ourselves.
    if (CMAKE_VERSION VERSION_LESS 2.8.11)
        include_directories("${gtest_SOURCE_DIR}/include")
    endif()
endif()

include_directories(include)
include_directories(vis)

add_subdirectory(src)
if (SQUIGGLES_TEST)
    add_subdirectory(tst)
endif()
```

The `CMakeLists.txt` file for the `tst` directory is almost identical to the one
in the `src` directory but with the addition of the following two lines:

```text
add_test(NAME ${BINARY} COMMAND ${BINARY})
target_link_libraries(${BINARY} PUBLIC ${CMAKE_PROJECT_NAME}_lib gtest)
```

## Visualization

My go-to tool for visualizing any sort of 2D data is Python's [Matplotlib](https://matplotlib.org/).
I'm positive that there must be a similar option for C++ out there but it's
honestly pretty easy to interact with a C or C++ program from Python.

I set up the shared library (`.so` on linux, `.dll` on windows) in the root
`CMakeLists.txt` file. I still needed a `CMakeLists.txt` file in the `vis`
directory to get CMake to recognize it as a subdirectory but I was able to keep
it blank.

The shared object config consisted of the following lines appended to the root
`CMakeLists.txt` file:

```text
set(VIS_SO
  # A decent sized list of headers and source files needed from the source code...
  vis/compat.hpp
  vis/compat.cpp)

add_library(RobotSquiggles SHARED ${VIS_SO})
```

The `compat.hpp` and `compat.cpp` files defined C-compatible functions for
interacting with the C++ library. This isn't the most elegant solution but was
needed to convert the Object-Oriented design of the library into functions for
Python's _ctypes_ library.

The Python code loads the shared object from the `build` directory and calls
functions from the `compat` layer to generate paths for visualization.

## Documentation

[Doxygen](https://www.doxygen.nl/index.html) is the standard for C/C++ documentation generation. In a similar
vein as my earlier point about Matplotlib, though, I am used to working instead
with [Sphinx](https://www.sphinx-doc.org/en/master/). Sphinx is designed with Python documentation in mind and has an
excellent, free hosting option in [ReadTheDocs](https://readthedocs.org/). Sphinx does not support
autodocumentation of C++ code out of the box but can use Doxygen as a bridge
with the excellent [Exhale](https://exhale.readthedocs.io/en/latest/) tool. Exhale generates Doxygen XML as a part of
the Sphinx build process and automatically documents C++ code for Sphinx as if
it were natively supported Python docs.

Despite the complicated nature of Exhale's relationship with Doxygen and Sphinx
I was able to set it up very easily. I copied in the configuration details from
the Exhale README to my Sphinx `conf.py` and started building my docs without
messing with any Doxygen configuration. This also worked on the first attempt
with ReadTheDocs which made the deployment process easy as well. I was mostly
intending to use Sphinx/Exhale just because of my familiarity with Sphinx but I
found it to be a remarkably easy documentation generation setup.

You can view the docs for Squiggles live at [ReadTheDocs](https://squiggles.readthedocs.io).

### Python Dependency Management

Dependency Management in Python is an unsolved problem in 2020. There are good
tools out there for sure but the choice of which tool to use is far from clear.
ReadTheDocs uses the traditional method of installing `pip` dependencies from a
`requirements.txt` file, so my Sphinx dependencies are kept there. For local
development of the docs and visualization, however, I opted to go with
[Poetry](https://python-poetry.org/). Poetry is a much heavier tool but makes it easy to set up a
virtual environment and use a different Python version than the system version.
I'm running Pop!\_OS 20.04 for my development machine and that release is in a
weird limbo with system Python versions. Using Poetry was a bit of hassle given
the duplication of dependencies with ReadTheDocs' `requirements.txt` file but
made it much easier to set up a clean development environment for me.
