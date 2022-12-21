include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)
SUPERBUILD_DEPENDENCY_HEADER(sqlite3 no-tag)


FetchContent_Declare(sqlite3 URL "https://sqlite.org/2021/sqlite-amalgamation-3350400.zip")
if (NOT sqlite3_POPULATED)
    # notice that we do not call `add_subdirectory`, we simply fetch and then
    # use the subdirectory sources directly.
    FetchContent_Populate(sqlite3)
endif ()

set(SQLITE_INSTALL_DIR ${sqlite3_INSTALL_DIR})
set(SQLITE_SOURCE_INCLUDE_DIR ${sqlite3_SOURCE_DIR})
set(SQLITE_INSTALL_INCLUDE_DIR ${SQLITE_INSTALL_DIR}/include)

file(GLOB SQLITE_SOURCES "${sqlite3_SOURCE_DIR}/*")
file(GLOB SQLITE_HEADERS "${sqlite3_SOURCE_DIR}/*.h")

set(CMAKE_INSTALL_PREFIX ${SUPERBUILD_INSTALL_DIR})
#message(FATAL_ERROR ${CMAKE_INSTALL_PREFIX})

# Build the library and setup the include dir
add_library(sqlite3 SHARED "${SQLITE_SOURCES}")
target_include_directories(sqlite3 INTERFACE
        "$<BUILD_INTERFACE:${SQLITE_SOURCE_INCLUDE_DIR}>"
        "$<INSTALL_INTERFACE:sqlite3/include>")

SUPERBUILD_INSTALL_TARGET(TARGET sqlite3
        TARGET_PREFIX sqlite3
        INCLUDE_DIRECTORY ${SQLITE_SOURCE_INCLUDE_DIR}/
        INSTALL_DIRECTORY ${sqlite3_INSTALL_DIR})

SUPERBUILD_DEPENDENCY_FOOTER(sqlite3 lib/cmake)