include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(cereal v1.3.0)

ExternalProject_Add(
    cereal 
    PREFIX cereal

    GIT_REPOSITORY https://github.com/USCiLab/cereal
    GIT_TAG ${cereal-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${cereal_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${cereal_INSTALL_DIR}
    -DJUST_INSTALL_CEREAL=ON
    -DSKIP_PORTABILITY_TEST=ON
    -DSKIP_PERFORMANCE_COMPARISON=ON
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON


    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(cereal share/cmake/cereal)