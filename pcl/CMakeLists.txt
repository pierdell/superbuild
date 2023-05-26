include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(pcl pcl-1.13.1)

if (NOT Eigen3_CMAKE_PATH)
    message(FATAL_ERROR " -- [Superbuild] The CMake variable Eigen3_CMAKE_PATH is not set")
endif()

ExternalProject_Add(
    pcl
    PREFIX pcl

    GIT_REPOSITORY https://github.com/PointCloudLibrary/pcl
    GIT_TAG ${pcl-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${pcl_INSTALL_DIR}
    CMAKE_ARGS
    -DWITH_VTK=FALSE
    -DCMAKE_INSTALL_PREFIX=${pcl_INSTALL_DIR}
    -DEigen3_DIR=${Eigen3_CMAKE_PATH}
    -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=TRUE

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(pcl share/pcl-1.13 PCL)