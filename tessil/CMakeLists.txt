include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(tessil v0.6.3)

ExternalProject_Add(
    tessil 
    PREFIX tessil

    GIT_REPOSITORY https://github.com/Tessil/robin-map
    GIT_TAG ${tessil-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${tessil_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${tessil_INSTALL_DIR}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON


    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(tessil share/cmake/tsl-robin-map tsl-robin-map)