include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)
SUPERBUILD_DEPENDENCY_HEADER(imgui docking)


# Fetch implot dependency (at build time), to integrate the source with imgui in the generated dependency
FetchContent_Declare(
        implot
        GIT_REPOSITORY https://github.com/epezent/implot
        GIT_TAG b47c8ba)


if (NOT implot_POPULATED)
    FetchContent_Populate(implot)
    set(IMPLOT_HDRS
            ${implot_SOURCE_DIR}/implot.h
            ${implot_SOURCE_DIR}/implot_internal.h)
    set(IMPLOT_SRCS
            ${implot_SOURCE_DIR}/implot.cpp
            ${implot_SOURCE_DIR}/implot_demo.cpp
            ${implot_SOURCE_DIR}/implot_items.cpp)
endif ()

FetchContent_Declare(
        IconFontHeaders
        GIT_REPOSITORY https://github.com/juliettef/IconFontCppHeaders
        GIT_TAG 685673d)

if (NOT IconFontHeaders_POPULATED)
        FetchContent_Populate(IconFontHeaders)

        set(IconFontHeaders_HDRS 
                ${iconfontheaders_SOURCE_DIR}/IconsFontAwesome4.h
                ${iconfontheaders_SOURCE_DIR}/IconsFontAwesome5.h
                ${iconfontheaders_SOURCE_DIR}/IconsFontAwesome5Brands.h
                ${iconfontheaders_SOURCE_DIR}/IconsFontAwesome5Pro.h
                ${iconfontheaders_SOURCE_DIR}/IconsFontAwesome6Brands.h
                ${iconfontheaders_SOURCE_DIR}/IconsFontaudio.h
                ${iconfontheaders_SOURCE_DIR}/IconsForkAwesome.h
                ${iconfontheaders_SOURCE_DIR}/IconsKenney.h
                ${iconfontheaders_SOURCE_DIR}/IconsMaterialDesign.h)
endif()

find_package(OpenGL REQUIRED)
find_package(glad REQUIRED)
find_package(glfw3 REQUIRED)

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)

# --  Fetch IMGUI dependency (at build time), to compensate for the lack CMakeLists.txt in the project
FetchContent_Declare(
        imgui_dir
        GIT_REPOSITORY https://github.com/pierdell/imgui
        GIT_TAG docking)

        if (NOT imgui_dir_POPULATED)
        FetchContent_Populate(imgui_dir)
        set(_IMGUI_SOURCE_DIR ${imgui_dir_SOURCE_DIR})
        set(FONTS_DIR ${_IMGUI_SOURCE_DIR}/misc/fonts)
    
        ##################################################################################################################
        # Project Files
        ##################################################################################################################
        set(HEADERS_CXX_FILES
                ${_IMGUI_SOURCE_DIR}/imgui.h
                ${_IMGUI_SOURCE_DIR}/imconfig.h
                ${_IMGUI_SOURCE_DIR}/imgui_internal.h
                ${_IMGUI_SOURCE_DIR}/imstb_rectpack.h
                ${_IMGUI_SOURCE_DIR}/imstb_textedit.h
                ${_IMGUI_SOURCE_DIR}/imstb_truetype.h
                ${_IMGUI_SOURCE_DIR}/misc/cpp/imgui_stdlib.h
                ${IMPLOT_HDRS} 
                ${IconFontHeaders_HDRS})
    
        set(SOURCES_CXX_FILES
                ${_IMGUI_SOURCE_DIR}/imgui.cpp
                ${_IMGUI_SOURCE_DIR}/imgui_draw.cpp
                ${_IMGUI_SOURCE_DIR}/imgui_widgets.cpp
                ${_IMGUI_SOURCE_DIR}/imgui_tables.cpp
                ${_IMGUI_SOURCE_DIR}/imgui_demo.cpp
                ${_IMGUI_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp
                ${IMPLOT_SRCS})
        file(GLOB FONTS_FILES ${FONTS_DIR}/*.ttf)
        set(HEADERS_CXX_IMPL_FILES
                ${_IMGUI_SOURCE_DIR}/backends/imgui_impl_opengl3.h
                ${_IMGUI_SOURCE_DIR}/backends/imgui_impl_glfw.h)
        set(SOURCES_CXX_IMPL_FILES
                ${_IMGUI_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
                ${_IMGUI_SOURCE_DIR}/backends/imgui_impl_glfw.cpp)
    
        ##################################################################################################################
        # Target
        ##################################################################################################################
        add_library(imgui SHARED
                ${HEADERS_CXX_FILES}
                ${SOURCES_CXX_FILES}
                ${HEADERS_CXX_IMPL_FILES}
                ${SOURCES_CXX_IMPL_FILES}
                ${FONTS_FILES})
        target_include_directories(imgui PUBLIC
                "$<BUILD_INTERFACE:${implot_SOURCE_DIR}>"
                "$<BUILD_INTERFACE:${_IMGUI_SOURCE_DIR}>"
                "$<BUILD_INTERFACE:${_IMGUI_SOURCE_DIR}/backends>"
                "$<INSTALL_INTERFACE:imgui/include>")
    
        target_link_libraries(imgui PUBLIC OpenGL::GL glfw glad::glad)
        target_compile_definitions(imgui PUBLIC IMGUI_IMPL_OPENGL_LOADER_GLAD)


        set(SLAM_TARGET imgui)
        set(SLAM_TARGET_PREFIX imgui)
        configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/template_config.cmake.in
                        ${CMAKE_CURRENT_BINARY_DIR}/imguiConfig.cmake
                        INSTALL_DESTINATION ${imgui_INSTALL_DIR}/lib/cmake)

        install(FILES ${HEADERS_CXX_FILES} DESTINATION ${imgui_INSTALL_DIR}/include)
        install(TARGETS imgui DESTINATION ${imgui_INSTALL_DIR}/lib EXPORT imguiTargets)
        install(EXPORT imguiTargets 
                NAMESPACE imgui:: 
                DESTINATION ${imgui_INSTALL_DIR}/lib/cmake)
        install(FILES
                ${CMAKE_CURRENT_BINARY_DIR}/imguiConfig.cmake
                DESTINATION ${imgui_INSTALL_DIR}/lib/cmake)

        SUPERBUILD_DEPENDENCY_FOOTER(imgui lib/cmake)
endif ()
