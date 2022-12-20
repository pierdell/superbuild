include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(nanoflann v1.4.1)

ExternalProject_Add(
    nanoflann 
    PREFIX nanoflann 

    GIT_REPOSITORY https://github.com/jlblancoc/nanoflann
    GIT_TAG ${nanoflann-tag} 

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    INSTALL_DIR ${nanoflann_INSTALL_DIR}
    CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${nanoflann_INSTALL_DIR}
    -DNANOFLANN_BUILD_EXAMPLES=OFF

    STEP_TARGETS install
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)

SUPERBUILD_DEPENDENCY_FOOTER(nanoflann share/nanoflann/cmake)