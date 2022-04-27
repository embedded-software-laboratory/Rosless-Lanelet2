# Define library. Only source files here!
project(liblanelet2_validation VERSION 0.1 LANGUAGES CXX)

add_library(lanelet2_validation SHARED
        src/validators/CheckTags.cpp
        src/validators/CurvatureTooBig.cpp
        src/validators/DuplicatedPoints.cpp
        src/validators/PointsTooClose.cpp
        src/validators/RoutingGraphIsValid.cpp
        src/Validation.cpp
        src/ValidatorFactory.cpp
        src/Cli.cpp
        src/BasicValidator.cpp)

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths.
target_include_directories(lanelet2_validation PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE src)

# If we have compiler requirements for this library, list them
# here
target_compile_features(lanelet2_validation
        PUBLIC cxx_auto_type
        PRIVATE cxx_variadic_templates)

# Depend on a library that we defined in the top-level file
target_link_libraries(lanelet2_validation
        Boost::boost
        Boost::program_options
        lanelet2_core
        lanelet2_io
        lanelet2_routing
        lanelet2_projection
        lanelet2_traffic_rules)

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS lanelet2_validation EXPORT Lanelet2ValidationConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
install(EXPORT Lanelet2ValidationConfig DESTINATION share/Lanelet2Validation/cmake)

# This makes the project importable from the build directory
export(TARGETS lanelet2_validation FILE Lanelet2ValidationConfig.cmake)

add_executable(lanelet2_validator tools/lanelet2_validate/main.cpp)

target_link_libraries(lanelet2_validator lanelet2_validation)
