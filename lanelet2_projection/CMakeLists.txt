# Define library. Only source files here!
project(liblanelet2_projection VERSION 0.1 LANGUAGES CXX)

add_library(lanelet2_projection SHARED
	src/UTM.cpp
        src/CPM.cpp)

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths.
target_include_directories(lanelet2_projection PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE src)

# If we have compiler requirements for this library, list them
# here
target_compile_features(lanelet2_projection
        PUBLIC cxx_auto_type
        PRIVATE cxx_variadic_templates)

# Depend on a library that we defined in the top-level file
target_link_libraries(lanelet2_projection
        lanelet2_core
        lanelet2_io
        GeographicLib)

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS lanelet2_projection EXPORT Lanelet2ProjectionConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
install(EXPORT Lanelet2ProjectionConfig DESTINATION share/Lanelet2Projection/cmake)

# This makes the project importable from the build directory
export(TARGETS lanelet2_projection FILE Lanelet2ProjectionConfig.cmake)
