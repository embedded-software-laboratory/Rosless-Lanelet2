# Define library. Only source files here!
project(liblanelet2_matching VERSION 0.1 LANGUAGES CXX)

add_library(lanelet2_matching SHARED
	src/Utilities.cpp
    src/LaneletMatching.cpp)

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths.
target_include_directories(lanelet2_matching PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE src)

# If we have compiler requirements for this library, list them
# here
target_compile_features(lanelet2_matching
        PUBLIC cxx_auto_type
        PRIVATE cxx_variadic_templates)

# Depend on a library that we defined in the top-level file
target_link_libraries(lanelet2_matching
        lanelet2_core
        lanelet2_traffic_rules)

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS lanelet2_matching EXPORT Lanelet2MatchingConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
install(EXPORT Lanelet2MatchingConfig DESTINATION share/Lanelet2Matching/cmake)

# This makes the project importable from the build directory
export(TARGETS lanelet2_matching FILE Lanelet2MatchingConfig.cmake)
