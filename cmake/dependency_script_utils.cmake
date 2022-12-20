# ---------------------------------
macro(SUPERBUILD_DEPENDENCY_HEADER)
    # A macro which loads scripts to include and set default variables 
    # Prior defining a configuration for a dependency (via ExternalProject)
    # Usage: SUPERBUILD_DEPENDENCY_HEADER(<Dependency-Name> <default-tag/version>)

    set(DEPENDENCY ${ARGV0})
    set(DEFAULT_TAG ${ARGV1})

    cmake_minimum_required(VERSION 3.14)
    project(${DEPENDENCY}-dependency)
    include(ExternalProject)
    include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/default_var.cmake)
    message(INFO "-- [Superbuild] Configuring ${DEPENDENCY} dependency")

    # Setting the default tag 
    if (NOT ${DEPENDENCY}-tag AND DEFAULT_TAG)
        set(${DEPENDENCY}-tag ${DEFAULT_TAG})
        message(INFO " -- [Superbuild] Setting the CMake variable `${DEPENDENCY}-tag` to ${DEFAULT_TAG}")
    endif()

endmacro()


# ---------------------------------
macro(SUPERBUILD_DEPENDENCY_FOOTER)
    set(DEPENDENCY ${ARGV0})
    set(DEPENDENCY_CMAKE_RPATH ${ARGV1})
    set(DEPENDENCY_PACKAGE_NAME ${ARGV2})
    if (NOT DEPENDENCY_PACKAGE_NAME)
        # If the depency package name is different from the Dependency
        # Correct it here
        set(DEPENDENCY_PACKAGE_NAME ${DEPENDENCY})
    endif()

    if (NOT DEPENDENCY)
        message(FATAL_ERROR " [Superbuild] -- The Dependency Name is empty !")
    endif()

    if (NOT DEPENDENCY_CMAKE_RPATH)
        message(FATAL_ERROR " [Superbuild] -- The rpath from the build directory to the cmake config file is not precised !")
    endif()

    set(_DEPENDENCY ${DEPENDENCY})
    set(_PACKAGE_NAME ${DEPENDENCY_PACKAGE_NAME})
    set(_PACKAGE_INSTALL_DIR ${${DEPENDENCY}_INSTALL_DIR})
    set(_PACKAGE_CMAKE_RPATH ${DEPENDENCY_CMAKE_RPATH})


    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/default_find_package.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/find_${DEPENDENCY}.cmake @ONLY)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/find_${DEPENDENCY}.cmake DESTINATION ${${DEPENDENCY}_INSTALL_DIR})
endmacro()


