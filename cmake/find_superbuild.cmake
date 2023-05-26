if (NOT SUPERBUILD_INSTALL_DIR)
    set(SUPERBUILD_INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR} PARENT_SCOPE)
    set(SUPERBUILD_INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR})
endif()

macro(SUPERBUILD_FIND_PACKAGE)
    set(DEPENDENCY ${ARGV0})
    set(DEPENDENCY_FILE_PATH "${SUPERBUILD_INSTALL_DIR}/${DEPENDENCY}/find_${DEPENDENCY}.cmake")
    if (EXISTS ${DEPENDENCY_FILE_PATH}) 
        include(${DEPENDENCY_FILE_PATH})
    else()
        message(FATAL_ERROR "-- [Superbuild][ERROR] Could not find file ${DEPENDENCY_FILE_PATH}") 
    endif()
endmacro()

# List All Superbuild Dependencies Package Names
list(APPEND SUPERBUILD_ALL_DEPENDENCIES 
        GTest Eigen3 glog 
        Ceres cereal tessil 
        yaml-cpp g2o OpenCV 
        nanoflann gtsam pybind11 
        sqlite3 tclap colormap 
        tinyply EnTT
        glfw glad imgui assimp sophus basalt)

# Finds all packages from the Superbuild
macro(SUPERBUILD_FIND_ALL_PACKAGES)
        foreach(DEPENDENCY IN LISTS SUPERBUILD_ALL_DEPENDENCIES)
        SUPERBUILD_FIND_PACKAGE(${DEPENDENCY})
    endforeach()
endmacro()