include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(glad v0.1.34)

ExternalProject_Add(
    glad 
    PREFIX glad 

    GIT_REPOSITORY https://github.com/Dav1dde/glad
    GIT_TAG ${glad-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${glad_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${glad_INSTALL_DIR}
    -DGLAD_INSTALL=ON
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(glad lib/cmake/glad)