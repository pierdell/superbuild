cmake_minimum_required(VERSION 3.14)
project(Superbuild-test)

include(../cmake/default_var.cmake)
include(${SUPERBUILD_INSTALL_DIR}/find_superbuild.cmake)

SUPERBUILD_FIND_ALL_PACKAGES()

macro(CHECK_TARGET)
    set(TARGET_NAME ${ARGV0})

    if (NOT TARGET ${TARGET_NAME})
        message(FATAL_ERROR " -- [Superbuild][Test] Could not find target ${TARGET_NAME}")
    endif()
    message(INFO " -- [Superbuild][Test][Sucess] Found Target ${TARGET_NAME}")
endmacro()

CHECK_TARGET(GTest::gtest)
CHECK_TARGET(Eigen3::Eigen)
CHECK_TARGET(glog::glog)
CHECK_TARGET(Ceres::ceres)
CHECK_TARGET(cereal)
CHECK_TARGET(yaml-cpp)
CHECK_TARGET(tsl::robin_map)
CHECK_TARGET(g2o::core)
CHECK_TARGET(nanoflann::nanoflann)
CHECK_TARGET(opencv_core)
CHECK_TARGET(gtsam)
CHECK_TARGET(pybind11::pybind11)




