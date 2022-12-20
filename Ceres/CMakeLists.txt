include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(Ceres 2.0.0)

if (Eigen3_INSTALL_DIR AND glog_INSTALL_DIR)

    set(DEPENDS_VAR "")
    if (TARGET Eigen3::Eigen)
        set(DEPENDS_VAR "${DEPENDS_VAR} Eigen3-install Eigen3")
    endif()
    if (TARGET glog::glog)
        set(DEPENDS_VAR "${DEPENDS_VAR} glog")
    endif()
    if (DEPENDS_VAR)
        set(DEPENDS_VAR " DEPENDS ${DEPENDS_VAR}")
    endif()

    ExternalProject_Add(
        Ceres
        PREFIX Ceres

        GIT_REPOSITORY https://ceres-solver.googlesource.com/ceres-solver
        GIT_TAG ${Ceres-tag}

        BUILD_ALWAYS ${DO_BUILD_ALWAYS}
        INSTALL_DIR ${Ceres_INSTALL_DIR}
        CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DCMAKE_INSTALL_PREFIX=${Ceres_INSTALL_DIR}
        -DBUILD_TESTING=OFF
        -DBUILD_EXAMPLES=OFF
        -DPROVIDE_UNINSTALL_TARGET=OFF
        -DEIGENSPARSE=ON
        -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON
        -DEigen3_DIR=${Eigen3_INSTALL_DIR}/share/eigen3/cmake
        -DGLOG_INCLUDE_DIR=${glog_INSTALL_DIR}/include
        -DGLOG_LIBRARY=${glog_INSTALL_DIR}/lib
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DBUILD_SHARED_LIBS=ON
        ${DEPENDS_VAR}
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)
else()
    message(FATAL_ERROR "Ceres depends on Eigen3 and glog, which must be installed locally (so the variables glog_INSTALL_DIR and Eigen3_INSTALL_DIR must be specified)")
endif()

# CERES
if (MSVC)
    set(CERES_DEFAULT_RPATH CMake)
else()
    set(CERES_DEFAULT_RPATH lib/cmake/Ceres)
endif()
SUPERBUILD_DEPENDENCY_FOOTER(Ceres ${CERES_DEFAULT_RPATH})