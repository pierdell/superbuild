include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(OpenCV 4.5.3)

if (NOT Eigen3_INSTALL_DIR)
    message(FATAL_ERROR " [Superbuild] -- Eigen3_INSTALL_DIR not specified !")
endif ()

if (NOT glog_INSTALL_DIR)
    message(FATAL_ERROR " [Superbuild] -- glog_INSTALL_DIR not specified !")
endif()

ExternalProject_Add(
    opencv_contrib
    PREFIX opencv_contrib
    GIT_REPOSITORY https://github.com/opencv/opencv_contrib
    GIT_TAG ${OpenCV-tag}

    BUILD_ALWAYS ${DO_BUILD_ALWAYS}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND "")

set(OPENCV_CMAKE_ARGS
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DCMAKE_INSTALL_PREFIX=${OpenCV_INSTALL_DIR}
    -DCMAKE_CXX_STANDARD=14
    -DOPENCV_EXTRA_MODULES_PATH=${CMAKE_CURRENT_BINARY_DIR}/opencv_contrib/src/opencv_contrib/modules)

set(OPENCV_EIGEN3_INCLUDE_PATH ${Eigen3_INSTALL_DIR}/include/eigen3)
message(INFO "${LOG_PREFIX}Setting the CMake variable OPENCV_EIGEN3_INCLUDE_PATH=${OPENCV_EIGEN3_INCLUDE_PATH}")
set(OPENCV_CMAKE_ARGS
        ${OPENCV_CMAKE_ARGS}
        -DWITH_EIGEN=ON
        -DGLOG_INCLUDE_DIR=${glog_INSTALL_DIR}/include
        -DBUILD_opencv_sfm=OFF
        -DBUILD_TESTS=OFF
        -DEIGEN_INCLUDE_PATH=${OPENCV_EIGEN3_INCLUDE_PATH})

# INSTALL OpenCV
ExternalProject_Add(
    opencv
    PREFIX opencv

    GIT_REPOSITORY https://github.com/opencv/opencv
    GIT_TAG ${OpenCV-tag}

    BUILD_ALWAYS OFF 

    INSTALL_DIR ${OpenCV_INSTALL_DIR}
    CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
    BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config ${CMAKE_BUILD_TYPE} --target install --parallel 8
    DEPENDS opencv_contrib)

SUPERBUILD_DEPENDENCY_FOOTER(OpenCV lib/cmake/opencv4)
