#pragma once
#include <lanelet2_io/Exceptions.h>
#include <lanelet2_io/Projection.h>

namespace lanelet {
namespace projection {
class CpmProjector : public Projector {
 public:
  explicit CpmProjector(Origin origin);

  BasicPoint3d forward(const GPSPoint& gps) const override;

  GPSPoint reverse(const BasicPoint3d& utm) const override;
};

}  // namespace projection
}  // namespace lanelet
