find_library(PugiXml_LIBRARIES NAMES pugixml)
find_path(PugiXml_INCLUDE_DIRS NAMES pugixml.hpp PATH_SUFFIXES pugixml)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PugiXml DEFAULT_MSG PugiXml_LIBRARIES PugiXml_INCLUDE_DIRS)

if (PugiXml_FOUND)
    add_library(PugiXml INTERFACE IMPORTED)
    target_link_libraries(PugiXml INTERFACE ${PugiXml_LIBRARIES})
    target_include_directories(PugiXml INTERFACE ${PugiXml_INCLUDE_DIRS})
endif ()

