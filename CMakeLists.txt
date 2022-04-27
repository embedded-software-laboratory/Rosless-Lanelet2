# At LEAST 2.8 but newer is better
cmake_minimum_required(VERSION 3.2 FATAL_ERROR)
project(lanelet2 VERSION 1.1.1 LANGUAGES CXX)

# Must use GNUInstallDirs to install libraries into correct
# locations on all platforms.
include(GNUInstallDirs)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED)

# Include Boost as an imported target
find_package(Boost REQUIRED serialization filesystem program_options)
message(STATUS "Boost Version: ${Boost_VERSION_STRING}")

# Include Eigen as an imported target
find_package(Eigen3 REQUIRED NO_MODULE)
message(STATUS "Eigen3 Version: ${EIGEN3_VERSION_STRING}")

# Include PugiXML as an imported target
find_package(PugiXml REQUIRED NO_MODULE)
message(STATUS "PugiXml Version: ${PugiXml_VERSION}")

# Targets that we develop here
enable_testing()
add_subdirectory(lanelet2_core)
add_subdirectory(lanelet2_io)
add_subdirectory(lanelet2_projection)
add_subdirectory(lanelet2_traffic_rules)
add_subdirectory(lanelet2_routing)
add_subdirectory(lanelet2_validation)

# add_library(lanelet2 INTERFACE)

# Depend on a library that we defined in the top-level file
# target_link_libraries(lanelet2 INTERFACE
#        lanelet2_core
#        lanelet2_io
#        lanelet2_projection
#        lanelet2_routing
#        lanelet2_traffic_rules
#        lanelet2_validation)

# 'make install' to the correct locations (provided by GNUInstallDirs).
#install(TARGETS lanelet2 EXPORT Lanelet2Config
#        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
# install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
# install(EXPORT Lanelet2Config DESTINATION share/Lanelet2/cmake)

# This makes the project importable from the build directory
# export(TARGETS lanelet2 FILE Lanelet2Config.cmake)
