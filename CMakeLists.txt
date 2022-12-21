cmake_minimum_required(VERSION 3.14)
project(superbuild)

include(cmake/default_var.cmake)
option(BUILD_ONLY_UNINSTALLED_PACKAGE "Whether to build uninstalled package only (otherwise rebuild all packages)" ON)

macro(BUILD_PACKAGE)
    
    set(DEPENDENCY ${ARGV0})
    # Setting the install dir for the dependency
    if (NOT ${DEPENDENCY}_INSTALL_DIR)
        set(${DEPENDENCY}_INSTALL_DIR ${SUPERBUILD_INSTALL_DIR}/${DEPENDENCY})
        message(INFO " -- [Superbuild] Setting `${DEPENDENCY}_INSTALL_DIR` var to the default ${${DEPENDENCY}_INSTALL_DIR}")
    endif()

    set(find_cmake_file_path "${SUPERBUILD_INSTALL_DIR}/${ARGV0}/find_${ARGV0}.cmake")
    if (NOT BUILD_ONLY_UNINSTALLED_PACKAGE OR NOT EXISTS ${find_cmake_file_path})
        # Add the subdirectory
        add_subdirectory(${ARGV0}) 
    else()
        message(INFO " [Superbuild] Found the file ${find_cmake_file_path}. Skipping the configuration of the dependency ${ARGV0}")
        include(${find_cmake_file_path})
    endif()
endmacro()



set(CMAKE_INSTALL_PREFIX ${SUPERBUILD_INSTALL_DIR})

BUILD_PACKAGE(GTest)
BUILD_PACKAGE(Eigen3)
BUILD_PACKAGE(glog)
BUILD_PACKAGE(Ceres)
BUILD_PACKAGE(yaml-cpp)
BUILD_PACKAGE(cereal)
BUILD_PACKAGE(tessil)
BUILD_PACKAGE(g2o)
BUILD_PACKAGE(nanoflann)
BUILD_PACKAGE(OpenCV)
BUILD_PACKAGE(gtsam)
BUILD_PACKAGE(pybind11)
BUILD_PACKAGE(glfw)
BUILD_PACKAGE(glad)
BUILD_PACKAGE(EnTT)

BUILD_PACKAGE(sqlite3)
BUILD_PACKAGE(tclap)
BUILD_PACKAGE(colormap)
BUILD_PACKAGE(tinyply)
BUILD_PACKAGE(imgui)


# Install util to find the file
install(FILES cmake/find_superbuild.cmake DESTINATION ${SUPERBUILD_INSTALL_DIR})