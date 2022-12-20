include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(gtsam 4.1.1)

if (NOT Eigen3_CMAKE_PATH)
    message(FATAL_ERROR " -- [Superbuild] The CMake variable Eigen3_CMAKE_PATH is not set")
endif()

ExternalProject_Add(
    gtsam 
    PREFIX gtsam 

    GIT_REPOSITORY https://github.com/borglab/gtsam
    GIT_TAG ${gtsam-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${gtsam_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${gtsam_INSTALL_DIR}
    -DGTSAM_USE_SYSTEM_EIGEN=ON
    -DEigen3_DIR=${Eigen3_CMAKE_PATH}
    -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=TRUE

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(gtsam lib/cmake/GTSAM GTSAM)