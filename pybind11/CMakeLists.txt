include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(pybind11 v2.10.1)

ExternalProject_Add(
    pybind11 
    PREFIX pybind11 

    GIT_REPOSITORY https://github.com/pybind/pybind11
    GIT_TAG ${pybind11-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${pybind11_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${pybind11_INSTALL_DIR}

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(pybind11 share/cmake/pybind11)