#include "lanelet2_projection/CPM.h"

namespace lanelet {
namespace projection {

CpmProjector::CpmProjector(Origin origin) : Projector(origin){}

BasicPoint3d CpmProjector::forward(const GPSPoint& gps) const {
  BasicPoint3d utm{gps.lon, gps.lat, gps.ele};
  return utm;
}

GPSPoint CpmProjector::reverse(const BasicPoint3d& utm) const {
  GPSPoint gps{utm.y(), utm.x(), utm.z()};
  return gps;
}

}  // namespace projection
}  // namespace lanelet
