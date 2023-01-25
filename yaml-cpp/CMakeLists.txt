include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(yaml-cpp yaml-cpp-0.6.3)

ExternalProject_Add(
    yaml-cpp 
    PREFIX yaml-cpp

    GIT_REPOSITORY https://github.com/jbeder/yaml-cpp
    GIT_TAG ${yaml-cpp-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${yaml-cpp_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DCMAKE_INSTALL_PREFIX=${yaml-cpp_INSTALL_DIR}
    -DYAML_CPP_BUILD_TESTS=OFF
    -DYAML_CPP_BUILD_TOOLS=OFF
    -DYAML_CPP_BUILD_CONTRIB=OFF
    -DYAML_CPP_BUILD_TESTS=OFF

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(yaml-cpp lib/cmake/yaml-cpp)