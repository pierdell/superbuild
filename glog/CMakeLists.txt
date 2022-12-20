include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(glog v0.5.0)

ExternalProject_Add(
    glog 
    PREFIX glog

    GIT_REPOSITORY https://github.com/google/glog
    GIT_TAG ${glog-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${glog_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${glog_INSTALL_DIR}

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(glog lib/cmake/glog)