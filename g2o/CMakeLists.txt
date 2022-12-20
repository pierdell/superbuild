include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(g2o master)

if (Eigen3_INSTALL_DIR)
    set(DEPENDS_VAR "")
    if (TARGET Eigen3::Eigen)
        set(DEPENDS_VAR "${DEPENDS_VAR} Eigen3-install Eigen3")
    endif()
    if (DEPENDS_VAR)
        set(DEPENDS_VAR " DEPENDS ${DEPENDS_VAR}")
    endif()

    ExternalProject_Add(
        g2o 
        PREFIX g2o

        GIT_REPOSITORY https://github.com/RainerKuemmerle/g2o
        GIT_TAG ${g2o-tag}

        BUILD_ALWAYS ${DO_BUILD_ALWAYS}
        INSTALL_DIR ${g2o_INSTALL_DIR}
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${g2o_INSTALL_DIR}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=TRUE

        BUILD_ALWAYS ${DO_BUILD_ALWAYS}
        INSTALL_DIR ${g2o_INSTALL_DIR}
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${g2o_INSTALL_DIR}
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DEigen3_DIR=${Eigen3_CMAKE_PATH}
        -DEIGEN3_INCLUDE_DIR=${Eigen3_INSTALL_DIR}/include

        ${DEPENDS_VAR}
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)
else()
    message(FATAL_ERROR "g2o depends on Eigen3, which must be installed locally (so the variables Eigen3_INSTALL_DIR must be specified)")
endif()

SUPERBUILD_DEPENDENCY_FOOTER(g2o lib/cmake/g2o)