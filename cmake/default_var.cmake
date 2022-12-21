# Whether to build always or not
if (NOT DO_BUILD_ALWAYS)
    set(DO_BUILD_ALWAYS ON)
endif()

# -- Sets the CMake Variable for the Superbuild install location
if (NOT SUPERBUILD_INSTALL_DIR)
        set(SUPERBUILD_INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR}/../install)
        get_filename_component(SUPERBUILD_INSTALL_DIR ${SUPERBUILD_INSTALL_DIR} ABSOLUTE)
        message(INFO " -- [Superbuild] `SUPERBUILD_INSTALL_DIR` not specified, setting it to ${SUPERBUILD_INSTALL_DIR}")
endif()

# -- Macro which sets the CMake variable for the install dir of a Package
macro(SUPERBUILD_DEFAULT_INSTALL_DIR)
    set(DEPENDENCY ${ARGV0})
    if (NOT ${DEPENDENCY}_INSTALL_DIR)
        set(${DEPENDENCY}_INSTALL_DIR ${SUPERBUILD_INSTALL_DIR}/${DEPENDENCY})
        set(${DEPENDENCY}_INSTALL_DIR ${SUPERBUILD_INSTALL_DIR}/${DEPENDENCY} PARENT_SCOPE)
        message(INFO " -- [Superbuild] Setting the install dir of package '${DEPENDENCY}' to ${${DEPENDENCY}_INSTALL_DIR} ")
    endif()
endmacro()