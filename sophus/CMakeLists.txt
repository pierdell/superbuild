include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(sophus v1.0.0)

# ExternalProject_Add(
#     sophus 
#     PREFIX sophus 

#     GIT_REPOSITORY  https://github.com/strasdat/Sophus
#     GIT_TAG ${sophus-tag} 

#     BUILD_ALWAYS ${DO_BUILD_ALWAYS}
#     INSTALL_DIR ${sophus_INSTALL_DIR}
#     CMAKE_ARGS
#     -DEigen3_DIR=${Eigen3_CMAKE_PATH}
#     -DCMAKE_INSTALL_PREFIX=${sophus_INSTALL_DIR}
#     -DNANOFLANN_BUILD_EXAMPLES=OFF

#     STEP_TARGETS install
#     BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 6)
# SUPERBUILD_DEPENDENCY_FOOTER(sophus share/shophus/cmake)

FetchContent_Declare(sophus
GIT_REPOSITORY  https://github.com/strasdat/Sophus
GIT_TAG ${sophus-tag} )

if (NOT sophus_POPULATED)
    # notice that we do not call `add_subdirectory`, we simply fetch and then
    # use the subdirectory sources directly.
    find_package(Eigen3 REQUIRED CONFIG PATHS ${Eigen3_CMAKE_PATH} )
    FetchContent_Populate(sophus)

    ################################################################################
    SET( SOURCE_DIR "${sophus_SOURCE_DIR}/sophus")

    SET( TEMPLATES so2
               se2
               so3
               se3
               rxso3
               sim3)

    SET(SOURCES ${SOURCE_DIR}/common.hpp
                ${SOURCE_DIR}/types.hpp
                ${SOURCE_DIR}/example_ensure_handler.cpp )

    FOREACH(templ ${TEMPLATES})
        LIST(APPEND SOURCES ${SOURCE_DIR}/${templ}.hpp)
    ENDFOREACH(templ)

    INSTALL(FILES ${SOURCES} DESTINATION ${sophus_INSTALL_DIR}/include/sophus)

    add_library(sophus INTERFACE)
    target_include_directories(sophus INTERFACE
        "$<INSTALL_INTERFACE:sophus/include>")

    SUPERBUILD_INSTALL_TARGET(TARGET sophus
        TARGET_PREFIX sophus
        INCLUDE_DIRECTORY ${SOURCE_DIR}
        INSTALL_DIRECTORY ${sophus_INSTALL_DIR})

endif ()

SUPERBUILD_DEPENDENCY_FOOTER(sophus lib/cmake)