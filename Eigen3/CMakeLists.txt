include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(Eigen3 3.3.7)

ExternalProject_Add(
    Eigen3 
    PREFIX Eigen3 

    GIT_REPOSITORY https://gitlab.com/libeigen/eigen
    GIT_TAG ${Eigen3-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${Eigen3_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${Eigen3_INSTALL_DIR}

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(Eigen3 share/eigen3/cmake)