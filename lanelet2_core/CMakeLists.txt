# Define library. Only source files here!
project(liblanelet2_core VERSION 1.1.1 LANGUAGES CXX)

add_library(lanelet2_core SHARED
        src/Attribute.cpp
        src/BasicRegulatoryElements.cpp
        src/Lanelet.cpp
        src/LaneletMap.cpp
        src/LaneletSequence.cpp
        src/LineStringGeometry.cpp
        src/PolygonTriangulationGeometry.cpp
        src/RegulatoryElement.cpp
        src/RegulatoryElementGeometry.cpp)

set_property(TARGET lanelet2_core PROPERTY VERSION ${CMAKE_PROJECT_VERSION})

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths.
target_include_directories(lanelet2_core PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE src)

# If we have compiler requirements for this library, list them
# here
target_compile_features(lanelet2_core
        PUBLIC cxx_auto_type
        PRIVATE cxx_variadic_templates)

# Depend on a library that we defined in the top-level file
target_link_libraries(lanelet2_core
        Boost::boost
        Eigen3::Eigen)

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS lanelet2_core EXPORT Lanelet2CoreConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
install(EXPORT Lanelet2CoreConfig DESTINATION share/Lanelet2Core/cmake)

# This makes the project importable from the build directory
export(TARGETS lanelet2_core FILE Lanelet2CoreConfig.cmake)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(Lanelet2CoreConfigVersion.cmake VERSION ${PROJECT_VERSION} COMPATIBILITY SameMajorVersion)
