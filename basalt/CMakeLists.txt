include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(basalt master)

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

FetchContent_Declare(basalt
GIT_REPOSITORY  https://gitlab.com/VladyslavUsenko/basalt-headers
GIT_TAG ${basalt-tag}) 

if (NOT basalt_POPULATED)
    # notice that we do not call `add_subdirectory`, we simply fetch and then
    # use the subdirectory sources directly.
    find_package(Eigen3 REQUIRED CONFIG PATHS ${Eigen3_CMAKE_PATH} )
    if (NOT sophus_CMAKE_PATH)
        set(sophus_CMAKE_PATH ${SUPERBUILD_INSTALL_DIR}/sophus/lib/cmake)
    endif()
    find_package(sophus REQUIRED CONFIG PATHS ${sophus_CMAKE_PATH} )

    FetchContent_Populate(basalt)
    set(MODULES "spline" "utils" "imu" "camera" "image" "calibration")
    FOREACH(module ${MODULES})
        FILE(GLOB_RECURSE basalt_${module}_HEADERS ${basalt_SOURCE_DIR}/include/basalt/${module}/*.h*)
        INSTALL(FILES ${basalt_${module}_HEADERS} DESTINATION ${basalt_INSTALL_DIR}/include/basalt/${module})
    ENDFOREACH()
    
    add_library(basalt INTERFACE)

    target_include_directories(basalt INTERFACE
        "$<INSTALL_INTERFACE:basalt/include>")

    SUPERBUILD_INSTALL_TARGET(TARGET basalt 
        TARGET_PREFIX basalt 
        INCLUDE_DIRECTORY ${SOURCE_DIR}
        INSTALL_DIRECTORY ${sophus_INSTALL_DIR})

endif ()
SUPERBUILD_DEPENDENCY_FOOTER(basalt lib/cmake)