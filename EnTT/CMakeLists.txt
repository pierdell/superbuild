include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(EnTT v3.11.1)

ExternalProject_Add(
    EnTT 
    PREFIX EnTT 

    GIT_REPOSITORY https://github.com/skypjack/entt
    GIT_TAG ${EnTT-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${EnTT_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${EnTT_INSTALL_DIR}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(EnTT lib/EnTT/cmake)