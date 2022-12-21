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
    include(FetchContent)
    include(CMakePackageConfigHelpers)

    include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/default_var.cmake)
    message(INFO "-- [Superbuild] Configuring ${DEPENDENCY} dependency")

    # Sets the variable ${DEPENDENCY}_INSTALL_DIR
    SUPERBUILD_DEFAULT_INSTALL_DIR(${DEPENDENCY})

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

# ---------------------------------
macro(SUPERBUILD_INSTALL_TARGET)
    # Installs a CMake target (used for external dependencies resolved with FetchContent)
    if (NOT HDR_EXT)
        set(HDR_EXT "h")
    endif ()

        set(on_value_args TARGET TARGET_PREFIX INCLUDE_DIRECTORY INSTALL_DIRECTORY INSTALL_INCLUDE_SUFFIX)
    cmake_parse_arguments(SLAM "" "${on_value_args}" "" ${ARGN})

    if (NOT SLAM_INSTALL_INCLUDE_SUFFIX)
        set(SLAM_INSTALL_INCLUDE_SUFFIX include)
    endif ()
    # message(FATAL_ERROR "${SLAM_TARGET} -- ${SLAM_INSTALL_DIRECTORY}")
    configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/template_config.cmake.in
            ${CMAKE_CURRENT_BINARY_DIR}/${SLAM_TARGET}Config.cmake
            INSTALL_DESTINATION lib/cmake)

    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${SLAM_TARGET}Config.cmake"
            DESTINATION ${SLAM_TARGET}/lib/cmake)
    install(TARGETS ${SLAM_TARGET} DESTINATION ${SLAM_TARGET}/lib EXPORT ${SLAM_TARGET}Targets)
    install(EXPORT ${SLAM_TARGET}Targets
            NAMESPACE ${SLAM_TARGET_PREFIX}::
            DESTINATION ${SLAM_TARGET}/lib/cmake)
    install(DIRECTORY ${SLAM_INCLUDE_DIRECTORY} DESTINATION ${SLAM_TARGET}/include FILES_MATCHING PATTERN "*.${HDR_EXT}")
endmacro(SUPERBUILD_INSTALL_TARGET)

